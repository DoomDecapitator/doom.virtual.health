execute as @e[tag=virtual_health_entity] run function doom.virtual.health:core/detect_damage
execute as @e[tag=!virtual_health_entity] if data entity @s data.dvh run function doom.virtual.health:internal/auto_create
