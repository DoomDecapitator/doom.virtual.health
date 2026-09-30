# 变更日志 · doom.virtual.health

> 口径：只记**会影响玩家**的改动 —— 改了什么 · 为什么 · 能核对什么。
> 版本号规则：`vX.Y.Z`（正式）· `vX.Y.Z-beta.N` / `-rc.N`（预发布）；**Minecraft 版本不塞进版本号**，
> 它写在 `pack.mcmeta`（`pack_format: 81` · `supported_formats: 48–82`）与 [`docs/04-兼容与版本.md`](docs/04-兼容与版本.md) 里。
> 目标环境：Minecraft **1.21.7 / 1.21.8**（`pack_format` 81）。

---

## v3.0.0 · 首次附上真实产物 + 仓库形态改成玩家向 —— 2026-09-30

**下载**：[`dist/doom.virtual.health-v3.0.0.zip`](dist/doom.virtual.health-v3.0.0.zip) · sha256 `d271d11b12752493c74bf2875146e84c106f261c4e3c2166a1e5a479cf47be93`

### 一、版本号对应关系（先看这一段）

- `v3.0`（2026-08-05 的标签）**保留不动**，但它**从未附带任何产物** —— 只有标签，没有 zip。
  它的 Release 页已标注「⚠️ 已被 v3.0.0 取代」，免得玩家以为附件丢了。
- `v3.0.0` 是本版本线的**规范三位版号**，也是**第一个真正能下载的产物**。
  两者是同一个版本，没有功能差别。
- 按 SPEC 的版本号规则，这次的改动属于 **PATCH 级**（不新增能力、玩家不需要动手改任何东西）。

### 二、仓库形态改成玩家向（只影响仓库，不影响玩法）

- 顶层重排为 **README.md · LICENSE · CHANGELOG.md · dist/ · docs/ · doom.virtual.health/ · .github/**：
  第一屏直接回答"这是什么 / 下哪个 / 怎么装 / 源码在哪"，并留了首屏效果图位（见 [`docs/图-首屏效果位.md`](docs/图-首屏效果位.md)）。
- 新增 `dist/`（成品 zip + `SHA256SUMS.txt`）、`CHANGELOG.md`（本文件）、`.github/ISSUE_TEMPLATE/`（bug / 功能建议两张表单）、
  `.gitignore` 与 `.gitattributes`（`* -text`，锁住字节不被换行改写）。
- 新增 `docs/` 玩家手册五页：安装 · 用法与 API · 配置 · 兼容与版本 · 致谢与许可。
- **文档站保留并继续服务**：`docs/index.html` 与 `docs/.nojekyll` 原样留在 `docs/`，
  GitHub Pages 仍然从 `docs/` 发布 → <https://doomdecapitator.github.io/doom.virtual.health/>。
  页内版本标识从 `v3.0` 更新为 `v3.0.0`，其余内容未动。
- 数据包本体本来就在顶层 `doom.virtual.health/`，**位置不变**，每个 mcfunction 都能直接点开读。

### 三、包体同步（**本轮唯一的包内字节变化**）

GitHub 上的包体停在 2026-08-05（`v3.0` 那次合并），而工作区那一份在 **2026-09-27** 又被改过一处；
本版把**工作区最新那一份原样搬了过来**（91 个文件）。相对库内旧版只有 3 处差异，**没有一处改变游戏内行为**：

- `mcdoc/doom.virtual.health.mcdoc`：1496 B → 2628 B。把 `[string]: any` 这个"什么都收"的兜底换成**显式键名**
  （`with` / `uid0..3` / `uid_hex` / `on_death` / `state` / `_` / `trigger` / `b0..bf` / `h0..hf`），
  并补上中文说明。效果：写 `data modify storage doom.vh:ctx ...` 时**拼错键名当场报警**，而不是静默新建一个没人读的槽位。
  槽位清单与包内 `internal/uuid_hex`、`api/apply_trigger` 实际使用的键**逐个对齐**（这是它比旧版更有用的原因）。
- `pack.mcmeta`：`supported_formats` 从单行写成多行。**值一字未变**（`min_inclusive: 48` · `max_inclusive: 82`），
  连描述串 `§cDVH v3.0 §7+ §9DBB` 也照旧（同版本，不是旧包）。
- `data/doom.virtual.health/function/__unload__.mcfunction`：去掉**行首的 UTF-8 BOM**。
  旧版这个文件开头有 3 个字节 `EF BB BF`，其它 90 个文件都没有；去掉后与全包一致，
  也避免某些工具/加载路径把 BOM 当成第一条命令的一部分。

> 说明：`mcdoc` 与 BOM 这两处是**包内字节变化**，所以本版必须发版（而不是"只改文档"）—— 这条正是发布规范第 3 条。

### 四、能核对什么（数字都可以自己复算）

- 包体 **91 个文件**（63 个 `.mcfunction` + 24 个 `.json` + 3 个 `.mcdoc` + `pack.mcmeta`），
  与工作区最新那份**逐字节相同（0 差异）**。
- `dist/doom.virtual.health-v3.0.0.zip` 内 **91 个条目**与仓库 [`doom.virtual.health/`](doom.virtual.health) 下同名文件**逐字节相同（0 差异）**。
- `dist/SHA256SUMS.txt`、Release 附件 digest、本文件顶上那一串 —— **三处同一个值**。
- 仓库顶层只含白名单条目；泄漏扫描 0 命中（口径见 [`docs/README.md`](docs/README.md)）。
- **本版未做真机加载验证**（本轮只动仓库形态与版本号，没碰运行逻辑）；上一轮的真机结论仍是 v3.0 那一轮的。

---

## v3.0 —— 2026-08-05（标签保留 · **无产物**）

- 合并 "DVH v3.0 unified"：实体级百分比阈值 `dvh.pp` / `dvh.pp_max`、`auto_create` 宏、
  `pack_format` 升到 81（1.21.7 / 1.21.8）、`damage_mult` 补上限保护（H7）。
- 同日的两次提交补齐文档：完整 API 参考、`on_death` 章节、vitality 与 predicate 说明；修掉 `auto_init` 对 double 的处理
  （改用 `data get`，兼容 double / int / string），并补上"已知 Edge Cases"章节。
- 该标签**没有附带 zip**。想用这一版请下载 [`v3.0.0`](https://github.com/DoomDecapitator/doom.virtual.health/releases/tag/v3.0.0)。

## v2.x 及更早

早期版本（v1.1 / v2.1 / v3.0 三个内测打包）只在本地工作区里流转，GitHub 上没有对应的产物，也不再维护。当前包内的 API 已经从那些版本演化过若干轮，
**不建议**再从旧目录取包 —— 以本仓库的 `dist/` 为准。
