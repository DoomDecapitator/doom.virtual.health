scoreboard players operation #heal_val dvh.temp = @s dvh.temp
scoreboard players operation #heal_val dvh.temp -= #baseline dvh.temp
scoreboard players operation #heal_val dvh.temp *= #1000 dvh.temp
scoreboard players add #heal_val dvh.temp 11
scoreboard players operation #heal_val dvh.temp += @s dvh.rem_heal
scoreboard players operation #rem dvh.temp = #heal_val dvh.temp
scoreboard players operation #rem dvh.temp %= #t22 dvh.temp
scoreboard players operation @s dvh.rem_heal = #rem dvh.temp
scoreboard players operation #heal_val dvh.temp /= #t22 dvh.temp
execute if score #heal_val dvh.temp matches ..0 run return 0
scoreboard players operation @s dvh.total_healing += #heal_val dvh.temp
scoreboard players operation @s dvh.health += #heal_val dvh.temp
scoreboard players operation @s dvh.health < @s dvh.max_health
