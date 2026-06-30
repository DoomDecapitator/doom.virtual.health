execute if entity @s[tag=virtual_health_entity] run return fail
$data modify storage doom.vh:ctx _ set value $(with)
tag @s add virtual_health_entity
execute store result score @s dvh.max_health run data get storage doom.vh:ctx _.max_health
scoreboard players operation @s dvh.max_health *= #1000 dvh.temp
execute if score @s dvh.max_health matches ..0 run scoreboard players set @s dvh.max_health 1000
execute store result score @s dvh.health run data get storage doom.vh:ctx _.health
scoreboard players operation @s dvh.health *= #1000 dvh.temp
scoreboard players operation @s dvh.health < @s dvh.max_health
scoreboard players set @s dvh.total_damage 0
scoreboard players set @s dvh.total_healing 0
scoreboard players set @s dvh.player_damage 0
scoreboard players set @s dvh.rem_damage 0
scoreboard players set @s dvh.saddle_bonus 0
scoreboard players set @s dvh.damage_mult 1000
scoreboard players set @s dvh.rem_heal 0
data remove entity @s data.dvh.on_death
data modify entity @s data.dvh.on_death set from storage doom.vh:ctx _.on_death
attribute @s max_health base set 1024
effect give @s minecraft:resistance 999999 3 true
scoreboard players set @s dvh.prev_hp 1126400
data modify entity @s Health set value 512f
function doom.virtual.health:api/apply_trigger
