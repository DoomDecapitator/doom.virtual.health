execute unless entity @s[tag=virtual_health_entity] run return fail
$scoreboard players set @s dvh.damage_mult $(mult)
execute if score @s dvh.damage_mult matches ..0 run scoreboard players set @s dvh.damage_mult 1