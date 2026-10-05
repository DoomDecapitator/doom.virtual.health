execute unless entity @s[tag=virtual_health_entity] run return fail
execute if entity @s[tag=dvh.invulnerable] run return 1
return fail
