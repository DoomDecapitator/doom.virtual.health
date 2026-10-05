execute unless entity @s[tag=virtual_health_entity] run return fail
function doom.virtual.health:internal/calculate_threshold
scoreboard players operation #dvh.low_limit dvh.temp = #dvh.result dvh.temp
execute if score @s dvh.pp_max matches 100.. run scoreboard players set @s dvh.pp_max 100
execute if score @s dvh.pp_max matches ..0 run scoreboard players set @s dvh.pp_max 0
scoreboard players operation #t1 dvh.temp = @s dvh.max_health
scoreboard players operation #t2 dvh.temp = @s dvh.max_health
scoreboard players operation #t1 dvh.temp /= #100 dvh.temp
scoreboard players operation #t1 dvh.temp *= @s dvh.pp_max
scoreboard players operation #t2 dvh.temp %= #100 dvh.temp
scoreboard players operation #t2 dvh.temp *= @s dvh.pp_max
scoreboard players operation #t2 dvh.temp /= #100 dvh.temp
scoreboard players operation #dvh.high_limit dvh.temp = #t1 dvh.temp
scoreboard players operation #dvh.high_limit dvh.temp += #t2 dvh.temp
execute if score @s dvh.health >= #dvh.low_limit dvh.temp if score @s dvh.health <= #dvh.high_limit dvh.temp run return 1
return fail
