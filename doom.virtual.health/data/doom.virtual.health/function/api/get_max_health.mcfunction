execute unless entity @s[tag=virtual_health_entity] run return fail
$scoreboard players operation $(out) dvh.temp = @s dvh.max_health
$scoreboard players set #_s dvh.temp $(scale)
$scoreboard players operation $(out) dvh.temp /= #_s dvh.temp