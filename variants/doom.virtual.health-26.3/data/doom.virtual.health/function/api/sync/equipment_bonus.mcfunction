scoreboard players set #total dvh.temp 0
function doom.virtual.health:internal/calc_slot {slot:"head"}
function doom.virtual.health:internal/calc_slot {slot:"saddle"}
function doom.virtual.health:internal/calc_slot {slot:"body"}
function doom.virtual.health:internal/calc_slot {slot:"mainhand"}
function doom.virtual.health:internal/calc_slot {slot:"offhand"}
function doom.virtual.health:internal/calc_slot {slot:"chest"}
function doom.virtual.health:internal/calc_slot {slot:"legs"}
function doom.virtual.health:internal/calc_slot {slot:"feet"}
scoreboard players operation #bonus dvh.temp = #total dvh.temp
scoreboard players operation #bonus dvh.temp *= #1000 dvh.temp
scoreboard players operation #diff dvh.temp = #bonus dvh.temp
scoreboard players operation #diff dvh.temp -= @s dvh.saddle_bonus
execute if score #diff dvh.temp matches 0 run return 0
scoreboard players operation @s dvh.max_health += #diff dvh.temp
execute if score @s dvh.max_health matches ..0 run scoreboard players set @s dvh.max_health 1000
scoreboard players operation @s dvh.health < @s dvh.max_health
scoreboard players operation @s dvh.saddle_bonus = #bonus dvh.temp