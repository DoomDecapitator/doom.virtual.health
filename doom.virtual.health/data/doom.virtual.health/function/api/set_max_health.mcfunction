execute unless entity @s[tag=virtual_health_entity] run return fail
$scoreboard players set @s dvh.max_health $(max_health)
scoreboard players operation @s dvh.max_health *= #1000 dvh.temp
execute if score @s dvh.max_health matches ..0 run scoreboard players set @s dvh.max_health 1000
scoreboard players operation @s dvh.health < @s dvh.max_health
