execute unless entity @s[tag=virtual_health_entity] run return fail
$scoreboard players operation $(damage_out) dvh.temp = @s dvh.total_damage
$scoreboard players operation $(healing_out) dvh.temp = @s dvh.total_healing
$scoreboard players set #_s dvh.temp $(scale)
$scoreboard players operation $(damage_out) dvh.temp /= #_s dvh.temp
$scoreboard players operation $(healing_out) dvh.temp /= #_s dvh.temp
