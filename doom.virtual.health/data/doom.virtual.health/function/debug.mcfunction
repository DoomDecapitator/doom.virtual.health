execute unless entity @s[tag=virtual_health_entity] run tellraw @a {"text":"[DVH] Not a VH entity","color":"red"}
execute unless entity @s[tag=virtual_health_entity] run return fail
tellraw @a ["",{"text":"=== DVH Debug ===","color":"gold"}]
tellraw @a [{"text":"Health(mHP): ","color":"gray"},{"score":{"name":"@s","objective":"dvh.health"},"color":"green"},{"text":" / ","color":"gray"},{"score":{"name":"@s","objective":"dvh.max_health"},"color":"green"}]
tellraw @a [{"text":"Damage(mHP): ","color":"gray"},{"score":{"name":"@s","objective":"dvh.total_damage"},"color":"red"},{"text":" | Player(mHP): ","color":"gray"},{"score":{"name":"@s","objective":"dvh.player_damage"},"color":"red"},{"text":" | Heal(mHP): ","color":"gray"},{"score":{"name":"@s","objective":"dvh.total_healing"},"color":"green"}]
execute if entity @s[tag=dvh.invulnerable] run tellraw @a [{"text":"Invulnerable: ","color":"gray"},{"text":"true","color":"green"}]
execute unless entity @s[tag=dvh.invulnerable] run tellraw @a [{"text":"Invulnerable: ","color":"gray"},{"text":"false","color":"red"}]
execute if entity @s[tag=dbb.has_bossbar] run tellraw @a [{"text":"Bossbar: ","color":"gray"},{"nbt":"data.dbb.id","entity":"@s","color":"blue"},{"text":" persist="},{"nbt":"data.dbb.persist","entity":"@s"}]
execute unless entity @s[tag=dbb.has_bossbar] run tellraw @a [{"text":"Bossbar: ","color":"gray"},{"text":"none","color":"dark_gray"}]
execute if data entity @s data.dvh.on_death run tellraw @a [{"text":"on_death: ","color":"gray"},{"nbt":"data.dvh.on_death","entity":"@s","color":"yellow"}]
execute unless data entity @s data.dvh.on_death run tellraw @a [{"text":"on_death: ","color":"gray"},{"text":"none","color":"dark_gray"}]
tellraw @a ["",{"text":"=================","color":"gold"}]