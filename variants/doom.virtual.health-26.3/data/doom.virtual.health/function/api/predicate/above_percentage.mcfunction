execute unless entity @s[tag=virtual_health_entity] run return fail
function doom.virtual.health:internal/calculate_threshold
execute if score @s dvh.health > #dvh.result dvh.temp run return 1
return fail
