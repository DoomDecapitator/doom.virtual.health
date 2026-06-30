# mcdoc autocomplete 示例 — doom.virtual.health
#
# 装好 Spyglass 或 Misode's mcdoc 插件后，
# 在以下命令中输入 `{` 时会触发结构补全。

# === doom.vh:ctx ===

# with — API 输入参数（create/add_health/add_max_health 等）
data merge storage doom.vh:ctx {with:{max_health:2000,health:2000}}
data merge storage doom.vh:ctx {with:{max_health:5000,health:5000,on_death:"say died"}}

# state — 无敌状态（0=vulnerable, 1=invulnerable）
data merge storage doom.vh:ctx {state:1b}

# uid0..uid3 — UUID int 分量（用于死亡归属）
data merge storage doom.vh:ctx {uid0:0,uid1:0,uid2:0,uid3:0}

# uid_hex — UUID hex 字符串
data merge storage doom.vh:ctx {uid_hex:"00000000-0000-0000-0000-000000000000"}

# on_death — 死亡回调
data merge storage doom.vh:ctx {on_death:"say I died"}

# === doom.vh:const ===

# hex_chars — UUID 十六进制查表
data get storage doom.vh:const hex_chars

# === custom_data ( /summon 补全 ) ===
# /summon 时 data:{dvh:{...}} 会触发 mcdoc 补全
summon minecraft:zombie ~ ~ ~ {data:{dvh:{max_health:"2000",health:"2000",on_death:"say died"}},NoAI:1b}
