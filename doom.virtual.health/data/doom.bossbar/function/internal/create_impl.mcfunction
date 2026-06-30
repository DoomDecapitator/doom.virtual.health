$bossbar add doom.bossbar.$(id) $(name)
$bossbar set doom.bossbar.$(id) color $(color)
$bossbar set doom.bossbar.$(id) style $(style)
$bossbar set doom.bossbar.$(id) visible $(visible)
$bossbar set doom.bossbar.$(id) players $(targets)
$data modify entity @s data.dbb.id set value "$(id)"
$data modify entity @s data.dbb.persist set value $(persist)
tag @s add dbb.has_bossbar
function doom.bossbar:api/sync_dvh
