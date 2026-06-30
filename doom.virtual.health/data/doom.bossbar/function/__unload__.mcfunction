execute as @e[tag=dbb.has_bossbar] run function doom.bossbar:api/remove
data remove storage doom.dbb:ctx _
data remove storage doom.dbb:ctx id
scoreboard objectives remove dbb.temp
