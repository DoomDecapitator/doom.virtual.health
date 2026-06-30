# 骑乘 → mainhand
execute if entity @s[type=#doom.virtual.health:riding] if items entity @s weapon.mainhand * run data modify storage doom.vh:ctx trigger set from entity @s equipment.mainhand
execute if entity @s[type=#doom.virtual.health:riding] if items entity @s weapon.mainhand * run data modify storage doom.vh:ctx trigger.components."minecraft:enchantments"."doom.virtual.health:vitality" set value 1
execute if entity @s[type=#doom.virtual.health:riding] if items entity @s weapon.mainhand * run data modify storage doom.vh:ctx trigger.components."minecraft:item_model" set value "minecraft:air"
execute if entity @s[type=#doom.virtual.health:riding] if items entity @s weapon.mainhand * run data modify entity @s equipment.mainhand set from storage doom.vh:ctx trigger
execute if entity @s[type=#doom.virtual.health:riding] if items entity @s weapon.mainhand * run data remove storage doom.vh:ctx trigger
execute if entity @s[type=#doom.virtual.health:riding] unless items entity @s weapon.mainhand * run item replace entity @s weapon.mainhand with minecraft:saddle[minecraft:enchantments={"doom.virtual.health:vitality":1},minecraft:item_model="minecraft:air"]

# 非骑乘 → saddle
execute unless entity @s[type=#doom.virtual.health:riding] if items entity @s saddle * run data modify storage doom.vh:ctx trigger set from entity @s equipment.saddle
execute unless entity @s[type=#doom.virtual.health:riding] if items entity @s saddle * run data modify storage doom.vh:ctx trigger.components."minecraft:enchantments"."doom.virtual.health:vitality" set value 1
execute unless entity @s[type=#doom.virtual.health:riding] if items entity @s saddle * run data modify storage doom.vh:ctx trigger.components."minecraft:item_model" set value "minecraft:air"
execute unless entity @s[type=#doom.virtual.health:riding] if items entity @s saddle * run data modify entity @s equipment.saddle set from storage doom.vh:ctx trigger
execute unless entity @s[type=#doom.virtual.health:riding] if items entity @s saddle * run data remove storage doom.vh:ctx trigger
execute unless entity @s[type=#doom.virtual.health:riding] unless items entity @s saddle * run item replace entity @s saddle with minecraft:saddle[minecraft:enchantments={"doom.virtual.health:vitality":1},minecraft:item_model="minecraft:air"]