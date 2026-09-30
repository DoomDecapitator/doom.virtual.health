execute unless entity @s[tag=virtual_health_entity] run return 0
scoreboard players operation #_gp dvh.temp = @s dvh.health
scoreboard players operation #_gp dvh.temp /= #1000 dvh.temp
scoreboard players operation #_gpm dvh.temp = @s dvh.max_health
scoreboard players operation #_gpm dvh.temp /= #1000 dvh.temp
scoreboard players operation #_gp dvh.temp *= #100 dvh.temp
execute if score #_gpm dvh.temp matches 0 run scoreboard players set #_gpm dvh.temp 1
scoreboard players operation #_gp dvh.temp /= #_gpm dvh.temp
return run scoreboard players get #_gp dvh.temp
