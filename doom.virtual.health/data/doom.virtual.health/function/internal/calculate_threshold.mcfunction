execute if score @s dvh.pp matches 100.. run scoreboard players set @s dvh.pp 100
execute if score @s dvh.pp matches ..0 run scoreboard players set @s dvh.pp 0
scoreboard players operation #t1 dvh.temp = @s dvh.max_health
scoreboard players operation #t2 dvh.temp = @s dvh.max_health
scoreboard players operation #t1 dvh.temp /= #100 dvh.temp
scoreboard players operation #t1 dvh.temp *= @s dvh.pp
scoreboard players operation #t2 dvh.temp %= #100 dvh.temp
scoreboard players operation #t2 dvh.temp *= @s dvh.pp
scoreboard players operation #t2 dvh.temp /= #100 dvh.temp
scoreboard players operation #dvh.result dvh.temp = #t1 dvh.temp
scoreboard players operation #dvh.result dvh.temp += #t2 dvh.temp
