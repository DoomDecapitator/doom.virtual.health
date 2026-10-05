execute unless entity @s[tag=virtual_health_entity] run return fail
scoreboard players operation #_tl dvh.temp = #dvh.hp_threshold_low dvh.temp
scoreboard players operation #_tl dvh.temp *= #1000 dvh.temp
scoreboard players operation #_th dvh.temp = #dvh.hp_threshold_high dvh.temp
scoreboard players operation #_th dvh.temp *= #1000 dvh.temp
execute if score @s dvh.health >= #_tl dvh.temp if score @s dvh.health <= #_th dvh.temp run return 1
return fail
