execute unless entity @s[tag=virtual_health_entity] run return fail
$data modify storage doom.vh:ctx _ set value $(with)
tag @s remove virtual_health_entity
effect clear @s minecraft:resistance
scoreboard players set #persist dbb.temp 0
execute if entity @s[tag=dbb.has_bossbar] if data entity @s data.dbb.persist store result score #persist dbb.temp run data get entity @s data.dbb.persist
execute if entity @s[tag=dbb.has_bossbar] if score #persist dbb.temp matches 0 run function doom.bossbar:api/remove
data remove entity @s data.dvh
execute if data entity @s equipment.saddle.components."minecraft:enchantments"."doom.virtual.health:vitality" run data modify storage doom.vh:ctx trigger set from entity @s equipment.saddle
execute if data entity @s equipment.saddle.components."minecraft:enchantments"."doom.virtual.health:vitality" run data remove storage doom.vh:ctx trigger.components."minecraft:enchantments"."doom.virtual.health:vitality"
execute if data entity @s equipment.saddle.components."minecraft:enchantments"."doom.virtual.health:vitality" run data remove storage doom.vh:ctx trigger.components."minecraft:item_model"
execute if data entity @s equipment.saddle.components."minecraft:enchantments"."doom.virtual.health:vitality" run data modify entity @s equipment.saddle set from storage doom.vh:ctx trigger
execute if data entity @s equipment.saddle.components."minecraft:enchantments"."doom.virtual.health:vitality" run data remove storage doom.vh:ctx trigger
execute if data entity @s equipment.mainhand.components."minecraft:enchantments"."doom.virtual.health:vitality" run data modify storage doom.vh:ctx trigger set from entity @s equipment.mainhand
execute if data entity @s equipment.mainhand.components."minecraft:enchantments"."doom.virtual.health:vitality" run data remove storage doom.vh:ctx trigger.components."minecraft:enchantments"."doom.virtual.health:vitality"
execute if data entity @s equipment.mainhand.components."minecraft:enchantments"."doom.virtual.health:vitality" run data remove storage doom.vh:ctx trigger.components."minecraft:item_model"
execute if data entity @s equipment.mainhand.components."minecraft:enchantments"."doom.virtual.health:vitality" run data modify entity @s equipment.mainhand set from storage doom.vh:ctx trigger
execute if data entity @s equipment.mainhand.components."minecraft:enchantments"."doom.virtual.health:vitality" run data remove storage doom.vh:ctx trigger
execute unless data storage doom.vh:ctx _.kill run data modify storage doom.vh:ctx _.kill set value 1b
execute if data storage doom.vh:ctx _{kill: 1b} run damage @s 2147483647 minecraft:out_of_world


