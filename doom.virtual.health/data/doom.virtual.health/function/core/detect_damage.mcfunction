execute unless entity @s[tag=virtual_health_entity] run return fail
execute if entity @s[tag=dvh.invulnerable] run data modify entity @s Health set value 512f
execute if entity @s[tag=dvh.invulnerable] run return fail
execute store result score @s dvh.temp run data get entity @s Health 2200
execute if score @s dvh.temp < @s dvh.prev_hp run function doom.virtual.health:internal/apply_damage
execute if score @s dvh.temp > @s dvh.prev_hp run function doom.virtual.health:internal/apply_heal
execute if entity @s[tag=virtual_health_entity] run data modify entity @s Health set value 512f
scoreboard players set @s dvh.prev_hp 1126400
