scoreboard players set #damage dvh.temp 1126400
scoreboard players operation #damage dvh.temp -= @s dvh.temp
scoreboard players operation #damage dvh.temp *= #t50 dvh.temp
scoreboard players add #damage dvh.temp 11
scoreboard players operation #damage dvh.temp += @s dvh.rem_damage
scoreboard players operation #rem dvh.temp = #damage dvh.temp
scoreboard players operation #rem dvh.temp %= #t22 dvh.temp
scoreboard players operation @s dvh.rem_damage = #rem dvh.temp
scoreboard players operation #damage dvh.temp /= #t22 dvh.temp
scoreboard players operation #t1 dvh.temp = #damage dvh.temp
scoreboard players operation #t1 dvh.temp /= #1000 dvh.temp
scoreboard players operation #t1 dvh.temp *= @s dvh.damage_mult
scoreboard players operation #t2 dvh.temp = #damage dvh.temp
scoreboard players operation #t2 dvh.temp %= #1000 dvh.temp
scoreboard players operation #t2 dvh.temp *= @s dvh.damage_mult
scoreboard players operation #t2 dvh.temp /= #1000 dvh.temp
scoreboard players operation #damage dvh.temp = #t1 dvh.temp
scoreboard players operation #damage dvh.temp += #t2 dvh.temp
execute if score #damage dvh.temp matches ..0 run scoreboard players set #damage dvh.temp 1
scoreboard players operation @s dvh.total_damage += #damage dvh.temp
execute if data entity @s last_hurt_by_player run scoreboard players operation @s dvh.player_damage += #damage dvh.temp
scoreboard players operation @s dvh.health -= #damage dvh.temp
execute if score @s dvh.health matches ..0 run scoreboard players set @s dvh.health 0
execute if score @s dvh.health matches 0 run function doom.virtual.health:internal/trigger_death