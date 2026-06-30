data remove storage doom.vh:ctx on_death
data modify storage doom.vh:ctx on_death set from entity @s data.dvh.on_death
function doom.virtual.health:api/remove {with:{kill:false}}
execute if data storage doom.vh:ctx on_death at @s run function doom.virtual.health:internal/execute_on_death with storage doom.vh:ctx
execute unless data storage doom.vh:ctx on_death run data remove storage doom.vh:ctx uid0
execute unless data storage doom.vh:ctx on_death run data remove storage doom.vh:ctx uid1
execute unless data storage doom.vh:ctx on_death run data remove storage doom.vh:ctx uid2
execute unless data storage doom.vh:ctx on_death run data remove storage doom.vh:ctx uid3
execute unless data storage doom.vh:ctx on_death run execute if data entity @s last_hurt_by_mob store result storage doom.vh:ctx uid0 int 1 run data get entity @s last_hurt_by_mob[0]
execute unless data storage doom.vh:ctx on_death run execute if data entity @s last_hurt_by_mob store result storage doom.vh:ctx uid1 int 1 run data get entity @s last_hurt_by_mob[1]
execute unless data storage doom.vh:ctx on_death run execute if data entity @s last_hurt_by_mob store result storage doom.vh:ctx uid2 int 1 run data get entity @s last_hurt_by_mob[2]
execute unless data storage doom.vh:ctx on_death run execute if data entity @s last_hurt_by_mob store result storage doom.vh:ctx uid3 int 1 run data get entity @s last_hurt_by_mob[3]
execute unless data storage doom.vh:ctx on_death run execute if data storage doom.vh:ctx uid0 run function doom.virtual.health:internal/uuid_hex
execute unless data storage doom.vh:ctx on_death run execute if data storage doom.vh:ctx b0 run function doom.virtual.health:internal/uuid_join with storage doom.vh:ctx
execute unless data storage doom.vh:ctx on_death run execute if data storage doom.vh:ctx uid_hex run function doom.virtual.health:internal/damage_attributed with storage doom.vh:ctx
execute unless data storage doom.vh:ctx on_death run execute unless data storage doom.vh:ctx uid_hex run damage @s 2147483647 minecraft:out_of_world
