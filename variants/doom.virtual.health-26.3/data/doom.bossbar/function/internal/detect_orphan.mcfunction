scoreboard players set #persist dbb.temp 0
execute if data entity @s data.dbb.persist store result score #persist dbb.temp run data get entity @s data.dbb.persist
execute unless entity @s[tag=virtual_health_entity] if score #persist dbb.temp matches 0 run function doom.bossbar:api/remove
execute if entity @s[tag=virtual_health_entity] run function doom.bossbar:api/sync_dvh
