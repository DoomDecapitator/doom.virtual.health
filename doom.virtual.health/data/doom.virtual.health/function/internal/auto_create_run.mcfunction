$scoreboard players set #_mh dvh.temp $(max_health)
$scoreboard players set #_h dvh.temp $(health)
execute if score #_mh dvh.temp matches ..0 run return 0
execute if score #_h dvh.temp matches ..0 run scoreboard players operation #_h dvh.temp = #_mh dvh.temp
execute store result storage doom.vh:ctx with.max_health int 1 run scoreboard players get #_mh dvh.temp
execute store result storage doom.vh:ctx with.health int 1 run scoreboard players get #_h dvh.temp
data modify storage doom.vh:ctx with.on_death set from storage doom.vh:ctx _.on_death
function doom.virtual.health:api/create with storage doom.vh:ctx
data remove storage doom.vh:ctx with
data remove storage doom.vh:ctx _
function doom.virtual.health:api/apply_trigger