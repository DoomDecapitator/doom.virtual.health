execute unless entity @s[tag=virtual_health_entity] run return fail
$data modify storage doom.vh:ctx _ set value {hp:$(max_health)}
execute store result score @s dvh.max_health run data get storage doom.vh:ctx _.hp 1000
data remove storage doom.vh:ctx _
execute if score @s dvh.max_health matches ..0 run scoreboard players set @s dvh.max_health 1000
scoreboard players operation @s dvh.health < @s dvh.max_health
