# Doom Virtual Health (DVH) v3.0 + Doom Bossbar (DBB)

为 Minecraft 实体注入**独立于原版血量的虚拟血量系统**，自动映射到 Bossbar。支持 auto_init（`/summon` 直接带 NBT）、高频 tick 伤害检测、自定义死亡回调、百分比血量判定、无敌控制、余数精度补偿。

---

## 架构

```
doom.virtual.health     ← 完全独立
    │
    ▼ (依赖: scoreboard + tag)
doom.bossbar            ← 依赖 DVH，自动同步血条
```

---

## 快速开始

### auto_init（推荐）

```mcfunction
# summon 时直接写 data.dvh → 下一 tick 自动初始化
/summon minecraft:zombie ~ ~ ~ {
  data:{dvh:{max_health:"2000",health:"2000"}},
  NoAI:1b
}

# 创建 Bossbar
/execute as @e[tag=virtual_health_entity] run \
  function doom.bossbar:api/create {with:{name:'"Boss"',color:red,style:progress,visible:"true",targets:"@a"}}

# 扣血 / 治疗
/execute as @e[tag=virtual_health_entity] run \
  function doom.virtual.health:api/add_health {points:-500}

# 无敌
/execute as @e[tag=virtual_health_entity] run \
  function doom.virtual.health:api/set_invulnerable {state:1b}
```

### api/create（传统方式）

```mcfunction
/execute as @n run \
  function doom.virtual.health:api/create {with:{max_health:2000,health:2000}}

/execute as @e[tag=virtual_health_entity] run \
  function doom.bossbar:api/create {with:{name:'"Boss"',color:red,style:progress,visible:"true",targets:"@a"}}
```

---

## 伤害检测原理

```
Health = 512f（无原生抗性）
  ↓ 受到攻击 → Health 下降
  ↓ Tick 检测: temp = Health × 2200, 对比 baseline = 512×2200
  ↓ delta = baseline - temp
  ↓ delta × dvh.damage_mult / 2200 → mHP（×1000 精度）
  ↓ dvh.health -= mHP
  ↓ dvh.rem_damage += 余数（下次进位）
  ↓ Health 复位 512f
  ↓ dvh.health ≤ 0 → trigger_death

dvh.damage_mult 默认 1000 = 100% 伤害，可单独调整：
  mult=200  → 20% 伤害（等效原 Resistance IV 效果）
  mult=500  → 50% 伤害
  mult=2000 → 200% 伤害（弱点）
```

精度：**0.001 HP**（mHP），余数累计补偿截断。

---

## API

### doom.virtual.health

| 函数                             | 宏   | 参数                                       | 说明                                          |
| ------------------------------ | --- | ---------------------------------------- | ------------------------------------------- |
| `api/create`                   | ⚡   | `{with:{max_health, health, on_death?}}` | 注入虚拟血量                                      |
| `api/remove`                   | ⚡   | `{with:{kill:1b/0b}}`                    | 剥离虚拟血量（可选击杀）                                |
| `api/add_health`               | ⚡   | `{points:int}`                           | 增减血量，正=治疗/负=伤害（无敌拦截负值）                      |
| `api/set_health`               | ⚡   | `{health:int}`                           | 强制设定血量（HP），≤0 触发死亡                          |
| `api/set_max_health`           | ⚡   | `{max_health:int}`                       | 设定最大血量（HP），下限保底 1                           |
| `api/add_max_health`           | ⚡   | `{points:int}`                           | 增减最大血量（HP）                                  |
| `api/get_health`               | ⚡   | `{out, scale}`                           | 导出血量 ÷scale                                 |
| `api/get_max_health`           | ⚡   | `{out, scale}`                           | 导出最大血量 ÷scale                               |
| `api/get_stats`                | ⚡   | `{damage_out, healing_out, scale}`       | 导出统计数据 ÷scale                               |
| `api/get_percentage`           | ⚡   | `{out}`                                  | 导出当前血量百分比 [0,100]                           |
| `api/set_invulnerable`         | ⚡   | `{state:1b/0b}`                          | 设置无敌状态                                      |
| `api/set_damage_mult`          | ⚡   | `{mult:int}`                             | 设置伤害比例 (×1000, 默认1000=100%)                 |
| `api/apply_trigger`            |     | —                                        | 按实体类型分配 vitality trigger 槽位                 |
| `predicate/is_invulnerable`    |     | —                                        | return 1 如果无敌                               |
| `predicate/above_percentage`   |     | —                                        | return 1 如果血量高于 `@s dvh.pp`%                |
| `predicate/below_percentage`   |     | —                                        | return 1 如果血量低于 `@s dvh.pp`%                |
| `predicate/between_percentage` |     | —                                        | return 1 如果在 `@s dvh.pp`~`@s dvh.pp_max`% 内 |

### doom.bossbar

| 函数             | 宏   | 说明                         |
| -------------- | --- | -------------------------- |
| `api/create`   | ⚡   | 创建血条，重复调用 return fail      |
| `api/remove`   |     | 销毁血条                       |
| `api/sync_dvh` |     | 手动同步血量到 Bossbar（tick 自动调用） |

`api/create` 参数：

| 参数        | 类型            | 默认           | 说明          |
| --------- | ------------- | ------------ | ----------- |
| `name`    | string (JSON) | `"Boss"`     | 血条显示名称      |
| `color`   | string        | `"white"`    | 颜色          |
| `style`   | string        | `"progress"` | 样式          |
| `visible` | string        | `"true"`     | 可见性         |
| `targets` | string        | `"@a"`       | 可见玩家选择器     |
| `persist` | bool          | `false`      | 实体死亡后是否保留血条 |

### scale 用法

```mcfunction
# scale=1 → mHP 原始值
/execute as @e[tag=vh] run \
  function doom.virtual.health:api/get_health {out:"#hp",scale:1}
# #hp = 2000000

# scale=1000 → HP
/execute as @e[tag=vh] run \
  function doom.virtual.health:api/get_health {out:"#hp",scale:1000}
# #hp = 2000
```

### auto_init

`/summon` 时写入 `data.dvh`，下一 tick 自动初始化：

```mcfunction
/summon minecraft:zombie ~ ~ ~ {
  data:{dvh:{max_health:"2000", health:"2000", on_death:"say died"}},
  NoAI:1b
}
```

自动补全（需 Spyglass + mcdoc）：`data:{dvh:{max_health:"", health:""}}`

---

## 计分板

| 计分板                 | 域   | 说明                 |
| ------------------- | --- | ------------------ |
| `dvh.health`        | 实体  | 当前虚拟血量 (mHP)       |
| `dvh.max_health`    | 实体  | 最大虚拟血量 (mHP)       |
| `dvh.total_damage`  | 实体  | 累计伤害 (mHP)         |
| `dvh.total_healing` | 实体  | 累计治疗 (mHP)         |
| `dvh.player_damage` | 实体  | 来自玩家的伤害 (mHP)      |
| `dvh.rem_damage`    | 实体  | 伤害余数               |
| `dvh.rem_heal`      | 实体  | 治疗余数               |
| `dvh.pp`            | 实体  | 百分比阈值（下界）[0,100]   |
| `dvh.pp_max`        | 实体  | 百分比阈值（上界）[0,100]   |
| `dvh.prev_hp`       | 实体  | 上一 tick 血量 (×2200) |
| `dvh.temp`          | #变量 | 内部临时计算             |
| `dbb.temp`          | #变量 | bossbar 临时标识       |

## 标签

| 标签                      | 说明      |
| ----------------------- | ------- |
| `virtual_health_entity` | VH 实体标识 |
| `dvh.invulnerable`      | 无敌状态    |
| `dbb.has_bossbar`       | 已绑定血条   |

---

## mcdoc

3 个 mcdoc 文件提供 Spyglass 自动补全：

| 文件                                     | 补全场景                                   |
| -------------------------------------- | -------------------------------------- |
| `mcdoc/doom.virtual.health.mcdoc`      | `data modify storage doom.vh:ctx ...`  |
| `mcdoc/doom.bossbar.mcdoc`             | `data modify storage doom.dbb:ctx ...` |
| `mcdoc/doom.virtual.health.tags.mcdoc` | 函数标签参考                                 |

示例用法见 `function/mcdoc.mcfunction`。mcdoc 依赖 Spyglass + `Misodee.vscode-mcdoc` 插件。

---

## 注意事项

- `kill` 参数用字节 `{kill:1b}`，不是布尔
- `on_death` 回调中 `@s[tag=virtual_health_entity]` 已失效，直接用 `@s`
- Predicate below/above_percentage 读 `@s dvh.pp`；between_percentage 读 `@s dvh.pp`（下界）+ `@s dvh.pp_max`（上界），范围 [0,100]
- `add_health {points:负数}` 被无敌拦截；`set_health` 不受无敌影响
- Bossbar `api/create` 重复调用 return fail
- `scale` 参数用整数，`scale:1`=mHP，`scale:1000`=HP

---

## 文件结构

```
doom.virtual.health/
├── pack.mcmeta
├── mcdoc/
├── README.md
└── data/
    ├── minecraft/tags/function/
    │   ├── load.json
    │   └── tick.json
    ├── doom.virtual.health/
    │   └── function/
    │       ├── __load__.mcfunction
    │       ├── __unload__.mcfunction
    │       ├── __help__.mcfunction
    │       ├── debug.mcfunction
    │       ├── dvhentity.mcfunction
    │       ├── core/       (main, detect_damage, setup)
    │       ├── api/        (create, remove, add/set health, get, predicate)
    │       └── internal/   (apply_damage/heal, trigger_death, uuid_hex, auto_create)
    └── doom.bossbar/
        └── function/
            ├── __load__/__unload__/__help__.mcfunction
            ├── core/main.mcfunction
            ├── api/ (create, remove, sync_dvh)
            └── internal/ (create_impl, detect_orphan, sync_macro, ...)
```

---

> **制作**：Doom_Decapitator
