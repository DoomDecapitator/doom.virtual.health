execute unless entity @s[tag=virtual_health_entity] run return fail
scoreboard players operation #h dvh.temp = @s dvh.health
scoreboard players operation #h dvh.temp /= #1000 dvh.temp
scoreboard players operation #m dvh.temp = @s dvh.max_health
scoreboard players operation #m dvh.temp /= #1000 dvh.temp
scoreboard players operation #h dvh.temp *= #100 dvh.temp
execute if score #m dvh.temp matches 0 run scoreboard players set #m dvh.temp 1
scoreboard players operation #h dvh.temp /= #m dvh.temp
$scoreboard players operation $(out) dvh.temp = #h dvh.temp
