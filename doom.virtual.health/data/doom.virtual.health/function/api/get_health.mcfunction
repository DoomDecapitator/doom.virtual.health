execute unless entity @s[tag=virtual_health_entity] run return 0
scoreboard players operation #_gh dvh.temp = @s dvh.health
scoreboard players operation #_gh dvh.temp /= #1000 dvh.temp
return run scoreboard players get #_gh dvh.temp
