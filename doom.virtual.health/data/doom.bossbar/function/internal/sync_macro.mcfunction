scoreboard players operation #bmx dvh.temp = @s dvh.max_health
scoreboard players operation #bmx dvh.temp /= #1000 dvh.temp
$execute store result bossbar doom.bossbar.$(id) max run scoreboard players get #bmx dvh.temp
scoreboard players operation #bml dvh.temp = @s dvh.health
scoreboard players operation #bml dvh.temp /= #1000 dvh.temp
$execute store result bossbar doom.bossbar.$(id) value run scoreboard players get #bml dvh.temp
