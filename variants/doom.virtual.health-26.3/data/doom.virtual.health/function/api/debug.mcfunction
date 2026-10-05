execute unless entity @s[tag=virtual_health_entity] run tellraw @a {"text":"[DVH] Not a VH entity","color":"red"}
execute unless entity @s[tag=virtual_health_entity] run return fail
execute store result score #_h dvh.temp run scoreboard players get @s dvh.health
execute store result score #_m dvh.temp run scoreboard players get @s dvh.max_health
execute store result score #_d dvh.temp run scoreboard players get @s dvh.damage_mult
tellraw @a [{"text":"=== DVH Debug ===","color":"gold","bold":true},{"text":"  "},{"nbt":"CustomName","entity":"@s","interpret":true}]
tellraw @a [{"text":" mHP: ","color":"gray"},{"score":{"name":"#_h","objective":"dvh.temp"}},{"text":" / ","color":"gray"},{"score":{"name":"#_m","objective":"dvh.temp"}}]
tellraw @a [{"text":" Mult: ","color":"gray"},{"score":{"name":"#_d","objective":"dvh.temp"}},{"text":" (×1000)","color":"gray"}]
tellraw @a [{"text":" Invul: ","color":"gray"},{"nbt":"Tags","entity":"@s"}]
