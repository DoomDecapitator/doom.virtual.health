execute unless entity @s[tag=virtual_health_entity] run return fail
$scoreboard players set #pct dvh.temp $(pct)
scoreboard players operation #t1 dvh.temp = @s dvh.max_health
scoreboard players operation #t2 dvh.temp = @s dvh.max_health
scoreboard players operation #t1 dvh.temp /= #100 dvh.temp
scoreboard players operation #t1 dvh.temp *= #pct dvh.temp
scoreboard players operation #t2 dvh.temp %= #100 dvh.temp
scoreboard players operation #t2 dvh.temp *= #pct dvh.temp
scoreboard players operation #t2 dvh.temp /= #100 dvh.temp
scoreboard players operation #pts dvh.temp = #t1 dvh.temp
scoreboard players operation #pts dvh.temp += #t2 dvh.temp
scoreboard players set #max_safe dvh.temp 2147483647
scoreboard players operation #max_safe dvh.temp -= @s dvh.health
execute if score #max_safe dvh.temp matches ..-1 run scoreboard players set #max_safe dvh.temp 0
execute if score #pts dvh.temp matches 1.. if score #pts dvh.temp > #max_safe dvh.temp run scoreboard players operation #pts dvh.temp = #max_safe dvh.temp
execute if score #pts dvh.temp < #zero dvh.temp if entity @s[tag=dvh.invulnerable] run return fail
execute if score #pts dvh.temp > #zero dvh.temp run scoreboard players operation @s dvh.total_healing += #pts dvh.temp
scoreboard players operation @s dvh.health += #pts dvh.temp
scoreboard players operation @s dvh.health < @s dvh.max_health
execute if score @s dvh.health matches ..0 run scoreboard players set @s dvh.health 0
execute if score @s dvh.health matches 0 run function doom.virtual.health:internal/trigger_death
