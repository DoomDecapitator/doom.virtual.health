// .github/tools/check_pack.mjs —— 包体静态检查（不需要 Minecraft）。
//
//   node .github/tools/check_pack.mjs
//   DOOM_ROOT=<仓库根> node .github/tools/check_pack.mjs
//
// 查三类问题，都是真机上会直接「Failed to load function」、而肉眼看不出来的：
//
//   ① JSON 可解析
//      pack.mcmeta 与 data/**/tags/**/*.json 必须能被 JSON.parse。带 BOM 或尾逗号会静默失效。
//
//   ② mcfunction 行级合法性
//      Brigadier 在**加载期**解析每一条命令，任何一行不合法 ⇒ 整个函数失效（不报运行期错）。
//      已实测会触发失效的写法：
//        · 行尾 `#` 注释 —— Brigadier 不认，`#` 必须独占一行
//        · 连续两个空格 —— 参数分隔歧义，直接拒整条命令
//        · `~+N` / `~-N` —— 非法坐标写法
//        · 宏行缺 `$(name)` 占位符 —— "No variables in macro"，整函数加载失败
//        · 用了 `$(name)` 却没写 `$` 前缀 —— 会被当字面量
//
//   ③ 引用闭包
//      每个 `function <ns>:<path>` 引用的函数文件必须存在（或在 #标签 里）。
//      悬空引用在 1.20.2+ 是**加载期**错误，整函数失效。
//
// 不含：加载期门（要真服），真机断言（要 RCON + 多版本实例）。
//
// 来源：从 doom.schedule 的同名门移植（2026-10-08）。差异：PACKS 指向 DVH 的主包体与 26.3 变体。
import fs from 'node:fs';
import path from 'node:path';

const ROOT = process.env.DOOM_ROOT ? path.resolve(process.env.DOOM_ROOT) : path.resolve(import.meta.dirname, '..', '..');

// 默认检查主用包体；也把变体一起查
const PACKS = [
  path.join(ROOT, 'doom.virtual.health'),
  path.join(ROOT, 'variants', 'doom.virtual.health-26.3'),
].filter((p) => fs.existsSync(p));

if (!PACKS.length) { console.error('❌ 找不到任何包体目录'); process.exit(2); }

const walk = (d, rel = '', out = []) => {
  for (const e of fs.readdirSync(d, { withFileTypes: true })) {
    const q = path.join(d, e.name);
    const r = rel ? rel + '/' + e.name : e.name;
    if (e.isDirectory()) walk(q, r, out);
    else out.push(r);
  }
  return out;
};

let errors = 0;
const err = (f, line, msg) => { errors++; console.log('  ❌ ' + f + (line ? ':' + line : '') + ' :: ' + msg); };

for (const pack of PACKS) {
  const label = path.relative(ROOT, pack) || '.';
  console.log('\n=== ' + label + ' ===');
  const files = walk(pack);

  // ① JSON 可解析
  let jsonN = 0;
  for (const rel of files.filter((f) => f.endsWith('.json'))) {
    jsonN++;
    const p = path.join(pack, rel);
    const buf = fs.readFileSync(p);
    if (buf[0] === 0xEF && buf[1] === 0xBB && buf[2] === 0xBF) { err(rel, 0, '带 UTF-8 BOM（JSON.parse 会失败）'); continue; }
    const t = buf.toString('utf8');
    try { JSON.parse(t); } catch (e) { err(rel, 0, 'JSON 解析失败：' + String(e.message).slice(0, 80)); }
    if (/,\s*[}\]]/.test(t)) err(rel, 0, '疑似尾随逗号（JSON 不允许）');
  }
  console.log('  JSON ' + jsonN + ' 个已解析');

  // ② mcfunction 行级合法性
  const mcf = files.filter((f) => f.endsWith('.mcfunction'));
  let lineN = 0;
  for (const rel of mcf) {
    const p = path.join(pack, rel);
    const buf = fs.readFileSync(p);
    if (buf[0] === 0xEF && buf[1] === 0xBB && buf[2] === 0xBF) err(rel, 1, '带 UTF-8 BOM（第 1 行会解析失败）');
    const lines = buf.toString('utf8').split(/\r?\n/);
    lines.forEach((raw, i) => {
      const line = raw.replace(/\r$/, '');
      const n = i + 1;
      if (!line.trim()) return;
      if (/^\s*#/.test(line)) return;          // 注释行整行跳过
      lineN++;
      // 行尾注释：`#` 前面有空白，且不是计分板假玩家名 / 标签
      {
        const stripped = line
          .replace(/"[^"]*"/g, '""')
          .replace(/(^|[\s([{,])#([A-Za-z0-9_.:\/-]+)/g, '$1');
        if (/[^\s]\s+#/.test(stripped)) err(rel, n, '行尾注释（`#` 必须独占一行，否则整函数失效）');
      }
      if (/  /.test(line.replace(/"[^"]*"/g, '""'))) err(rel, n, '连续两个空格（Brigadier 直接拒整条命令）');
      if (/~[+-]\d/.test(line)) err(rel, n, '非法的 `~+N` / `~-N` 坐标写法');
      if (/^\s*\$/.test(line) && !/\$\([a-zA-Z_][\w]*\)/.test(line)) err(rel, n, '`$` 开头的宏行没有 `$(name)` 占位符（No variables in macro）');
      if (!/^\s*\$/.test(line) && /\$\([a-zA-Z_][\w]*\)/.test(line)) err(rel, n, '用了 `$(name)` 但行首没有 `$` 前缀');
    });
  }
  console.log('  mcfunction ' + mcf.length + ' 个 · ' + lineN + ' 行已查');

  // ③ 引用闭包
  const fnRoot = path.join(pack, 'data');
  const existsFn = (ns, p) => fs.existsSync(path.join(fnRoot, ns, 'function', p + '.mcfunction'));
  const tagFiles = new Set();
  (function w(x, rel = '') {
    for (const e of fs.readdirSync(x, { withFileTypes: true })) {
      const q = path.join(x, e.name); const r2 = rel ? rel + '/' + e.name : e.name;
      if (e.isDirectory()) w(q, r2);
      else if (r2.includes('tags/function/') && e.name.endsWith('.json')) tagFiles.add(r2.replace(/^[\w.]+\/tags\/function\//, '').replace(/\.json$/, ''));
    }
  })(fnRoot);

  let refN = 0;
  for (const rel of mcf) {
    const lines = fs.readFileSync(path.join(pack, rel), 'utf8').split(/\r?\n/);
    lines.forEach((raw, i) => {
      const line = raw.replace(/\r$/, '');
      if (!line.trim() || /^\s*#/.test(line)) return;
      for (const m of line.matchAll(/(?:^|\s)function\s+#?([a-z0-9_.-]+):([a-z0-9_./-]+)/g)) {
        refN++;
        const [, ns, p] = m;
        if (ns === 'minecraft') continue;
        if (line.includes('#' + ns + ':' + p)) {
          if (!tagFiles.has(p) && !existsFn(ns, p)) err(rel, i + 1, '引用了不存在的函数标签 #' + ns + ':' + p);
        } else if (!existsFn(ns, p)) {
          err(rel, i + 1, '引用了不存在的函数 ' + ns + ':' + p);
        }
      }
    });
  }
  console.log('  函数引用 ' + refN + ' 处已查');
}

console.log('\n' + (errors ? '❌ ' + errors + ' 个问题' : '✅ 0 个问题'));
process.exit(errors ? 1 : 0);
