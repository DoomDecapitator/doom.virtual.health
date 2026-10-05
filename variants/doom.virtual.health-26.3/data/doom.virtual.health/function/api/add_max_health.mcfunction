execute unless entity @s[tag=virtual_health_entity] run return fail
$data modify storage doom.vh:ctx _ set value {pts:$(points)}
execute store result score #pts dvh.temp run data get storage doom.vh:ctx _.pts 1000
data remove storage doom.vh:ctx _
scoreboard players set #max_safe dvh.temp 2147483647
scoreboard players operation #max_safe dvh.temp -= @s dvh.max_health
execute if score #max_safe dvh.temp matches ..-1 run scoreboard players set #max_safe dvh.temp 0
execute if score #pts dvh.temp matches 1.. if score #pts dvh.temp > #max_safe dvh.temp run scoreboard players operation #pts dvh.temp = #max_safe dvh.temp
scoreboard players operation @s dvh.max_health += #pts dvh.temp
execute if score @s dvh.max_health matches ..0 run scoreboard players set @s dvh.max_health 1000
scoreboard players operation @s dvh.health < @s dvh.max_health
