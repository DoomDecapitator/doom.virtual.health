execute unless entity @s[tag=dbb.has_bossbar] run return fail
data modify storage doom.dbb:ctx id set from entity @s data.dbb.id
function doom.bossbar:internal/sync_macro with storage doom.dbb:ctx
