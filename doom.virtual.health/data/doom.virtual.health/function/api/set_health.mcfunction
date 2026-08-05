execute unless entity @s[tag=virtual_health_entity] run return fail
execute if entity @s[tag=dvh.invulnerable] run return fail
$data modify storage doom.vh:ctx _ set value {hp:$(health)}
execute store result score @s dvh.health run data get storage doom.vh:ctx _.hp 1000
data remove storage doom.vh:ctx _
scoreboard players operation @s dvh.health < @s dvh.max_health
execute if score @s dvh.health matches ..0 run scoreboard players set @s dvh.health 0
execute if score @s dvh.health matches 0 run function doom.virtual.health:internal/trigger_death
