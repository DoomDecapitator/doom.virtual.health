execute unless entity @s[tag=virtual_health_entity] run return fail
$scoreboard players set #pts dvh.temp $(points)
scoreboard players operation #pts dvh.temp *= #1000 dvh.temp
execute if score #pts dvh.temp < #zero dvh.temp if entity @s[tag=dvh.invulnerable] run return fail
execute if score #pts dvh.temp > #zero dvh.temp run scoreboard players operation @s dvh.total_healing += #pts dvh.temp
scoreboard players operation @s dvh.health += #pts dvh.temp
scoreboard players operation @s dvh.health < @s dvh.max_health
execute if score @s dvh.health matches ..0 run scoreboard players set @s dvh.health 0
execute if score @s dvh.health matches 0 run function doom.virtual.health:internal/trigger_death
