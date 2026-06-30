execute unless entity @s[tag=virtual_health_entity] run return fail
$scoreboard players set #pts dvh.temp $(points)
scoreboard players operation #pts dvh.temp *= #1000 dvh.temp
scoreboard players operation @s dvh.max_health += #pts dvh.temp
execute if score @s dvh.max_health matches ..0 run scoreboard players set @s dvh.max_health 1000
scoreboard players operation @s dvh.health < @s dvh.max_health
