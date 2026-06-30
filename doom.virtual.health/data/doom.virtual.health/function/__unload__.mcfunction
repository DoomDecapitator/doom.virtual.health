execute as @e[tag=virtual_health_entity] run function doom.virtual.health:api/remove {with:{kill:false}}
data remove storage doom.vh:ctx _
data remove storage doom.vh:ctx on_death
data remove storage doom.vh:ctx uid0
data remove storage doom.vh:ctx uid1
data remove storage doom.vh:ctx uid2
data remove storage doom.vh:ctx uid3
data remove storage doom.vh:ctx b0
data remove storage doom.vh:ctx b1
data remove storage doom.vh:ctx b2
data remove storage doom.vh:ctx b3
data remove storage doom.vh:ctx b4
data remove storage doom.vh:ctx b5
data remove storage doom.vh:ctx b6
data remove storage doom.vh:ctx b7
data remove storage doom.vh:ctx b8
data remove storage doom.vh:ctx b9
data remove storage doom.vh:ctx ba
data remove storage doom.vh:ctx bb
data remove storage doom.vh:ctx bc
data remove storage doom.vh:ctx bd
data remove storage doom.vh:ctx be
data remove storage doom.vh:ctx bf
data remove storage doom.vh:ctx h0
data remove storage doom.vh:ctx h1
data remove storage doom.vh:ctx h2
data remove storage doom.vh:ctx h3
data remove storage doom.vh:ctx h4
data remove storage doom.vh:ctx h5
data remove storage doom.vh:ctx h6
data remove storage doom.vh:ctx h7
data remove storage doom.vh:ctx h8
data remove storage doom.vh:ctx h9
data remove storage doom.vh:ctx ha
data remove storage doom.vh:ctx hb
data remove storage doom.vh:ctx hc
data remove storage doom.vh:ctx hd
data remove storage doom.vh:ctx he
data remove storage doom.vh:ctx hf
data remove storage doom.vh:ctx state
data remove storage doom.vh:ctx uid_hex
scoreboard objectives remove dvh.health
scoreboard objectives remove dvh.max_health
scoreboard objectives remove dvh.total_damage
scoreboard objectives remove dvh.total_healing
scoreboard objectives remove dvh.player_damage
scoreboard objectives remove dvh.prev_hp
scoreboard objectives remove dvh.rem_damage
scoreboard objectives remove dvh.damage_mult
scoreboard objectives remove dvh.saddle_bonus
scoreboard objectives remove dvh.rem_heal
scoreboard objectives remove dvh.pp
scoreboard objectives remove dvh.pp_max
scoreboard objectives remove dvh.temp
