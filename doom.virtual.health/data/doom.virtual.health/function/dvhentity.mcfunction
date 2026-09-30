$execute unless entity @s[tag=virtual_health_entity] run tellraw $(target) {"text":"[DVH] Not a VH entity","color":"red"}
execute unless entity @s[tag=virtual_health_entity] run return fail
$tellraw $(target) ["",{"text":"=== DVH Entity ===","color":"gold"}]
$tellraw $(target) ["Health: ",{"score":{"name":"@s","objective":"dvh.health"},"color":"green"}," / ",{"score":{"name":"@s","objective":"dvh.max_health"},"color":"green"}]
$tellraw $(target) ["DMG: ",{"score":{"name":"@s","objective":"dvh.total_damage"},"color":"red"}," | Player: ",{"score":{"name":"@s","objective":"dvh.player_damage"},"color":"red"}," | Heal: ",{"score":{"name":"@s","objective":"dvh.total_healing"},"color":"green"}]
$execute if entity @s[tag=dvh.invulnerable] run tellraw $(target) [{"text":"Invulnerable: true","color":"green"}]
$execute unless entity @s[tag=dvh.invulnerable] run tellraw $(target) [{"text":"Invulnerable: false","color":"red"}]
$execute if entity @s[tag=dbb.has_bossbar] run tellraw $(target) [{"text":"Bossbar: ","color":"gray"},{"nbt":"data.dbb.id","entity":"@s","color":"blue"},{"text":" persist="},{"nbt":"data.dbb.persist","entity":"@s"}]
$execute unless entity @s[tag=dbb.has_bossbar] run tellraw $(target) [{"text":"Bossbar: none","color":"dark_gray"}]
$execute if data entity @s data.dvh.on_death run tellraw $(target) [{"text":"on_death: ","color":"gray"},{"nbt":"data.dvh.on_death","entity":"@s","color":"yellow"}]
$execute unless data entity @s data.dvh.on_death run tellraw $(target) [{"text":"on_death: none","color":"dark_gray"}]