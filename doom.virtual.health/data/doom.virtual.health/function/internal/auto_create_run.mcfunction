# doom.virtual.health:internal/auto_create_run
# auto_init 执行：从 storage _.max_health/_.health 读取（data get 版）
# 修复：宏版 $(max_health) 展开 double (40.0) 会 scoreboard 报错 → 改用 data get 取整
# 防御：先清零再读取，避免 string 类型 data get 失败时残留旧值
scoreboard players set #_mh dvh.temp 0
scoreboard players set #_h dvh.temp 0
execute if data storage doom.vh:ctx _.max_health store result score #_mh dvh.temp run data get storage doom.vh:ctx _.max_health 1
execute if data storage doom.vh:ctx _.health store result score #_h dvh.temp run data get storage doom.vh:ctx _.health 1
execute if score #_mh dvh.temp matches ..0 run return 0
execute if score #_h dvh.temp matches ..0 run scoreboard players operation #_h dvh.temp = #_mh dvh.temp
execute store result storage doom.vh:ctx with.max_health int 1 run scoreboard players get #_mh dvh.temp
execute store result storage doom.vh:ctx with.health int 1 run scoreboard players get #_h dvh.temp
data modify storage doom.vh:ctx with.on_death set from storage doom.vh:ctx _.on_death
function doom.virtual.health:api/create with storage doom.vh:ctx
data remove storage doom.vh:ctx with
data remove storage doom.vh:ctx _
function doom.virtual.health:api/apply_trigger
