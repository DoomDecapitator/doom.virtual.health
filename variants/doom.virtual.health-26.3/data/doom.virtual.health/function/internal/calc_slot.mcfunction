$execute store result score #_a dvh.temp run data get entity @s equipment.$(slot).components.minecraft:attribute_modifiers[{type:"minecraft:max_health"}].amount
$execute unless data entity @s equipment.$(slot).components.minecraft:attribute_modifiers[{type:"minecraft:max_health"}] run scoreboard players set #_a dvh.temp 0
scoreboard players operation #total dvh.temp += #_a dvh.temp