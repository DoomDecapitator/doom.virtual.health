data modify storage doom.vh:ctx _ set value {}
data modify storage doom.vh:ctx _.max_health set from entity @s data.dvh.max_health
data modify storage doom.vh:ctx _.health set from entity @s data.dvh.health
data modify storage doom.vh:ctx _.on_death set from entity @s data.dvh.on_death
data remove entity @s data
function doom.virtual.health:internal/auto_create_run with storage doom.vh:ctx _