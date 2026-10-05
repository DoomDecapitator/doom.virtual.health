execute unless entity @s[tag=virtual_health_entity] run return 0
scoreboard players operation #_gm dvh.temp = @s dvh.max_health
scoreboard players operation #_gm dvh.temp /= #1000 dvh.temp
return run scoreboard players get #_gm dvh.temp
