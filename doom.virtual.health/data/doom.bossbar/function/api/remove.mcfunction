execute unless entity @s[tag=dbb.has_bossbar] run return fail
data modify storage doom.dbb:ctx id set from entity @s data.dbb.id
function doom.bossbar:internal/delete_macro with storage doom.dbb:ctx
tag @s remove dbb.has_bossbar
data remove entity @s data.dbb
