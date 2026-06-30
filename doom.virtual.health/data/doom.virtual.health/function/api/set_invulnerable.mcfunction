execute unless entity @s[tag=virtual_health_entity] run return fail
$data modify storage doom.vh:ctx state set value $(state)
execute store result score #inv_state dvh.temp run data get storage doom.vh:ctx state
execute if score #inv_state dvh.temp matches 1 run tag @s add dvh.invulnerable
execute unless score #inv_state dvh.temp matches 1 run tag @s remove dvh.invulnerable
execute unless score #inv_state dvh.temp matches 1 run execute store result score @s dvh.prev_hp run data get entity @s Health 2200
