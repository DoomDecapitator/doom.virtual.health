execute unless entity @s[tag=virtual_health_entity] run return fail
execute if entity @s[tag=dvh.invulnerable] run return fail
$scoreboard players set #pct dvh.temp $(pct)
scoreboard players operation #t1 dvh.temp = @s dvh.max_health
scoreboard players operation #t2 dvh.temp = @s dvh.max_health
scoreboard players operation #t1 dvh.temp /= #100 dvh.temp
scoreboard players operation #t1 dvh.temp *= #pct dvh.temp
scoreboard players operation #t2 dvh.temp %= #100 dvh.temp
scoreboard players operation #t2 dvh.temp *= #pct dvh.temp
scoreboard players operation #t2 dvh.temp /= #100 dvh.temp
scoreboard players operation @s dvh.health = #t1 dvh.temp
scoreboard players operation @s dvh.health += #t2 dvh.temp
scoreboard players operation @s dvh.health < @s dvh.max_health
execute if score @s dvh.health matches ..0 run scoreboard players set @s dvh.health 0
execute if score @s dvh.health matches 0 run function doom.virtual.health:internal/trigger_death
