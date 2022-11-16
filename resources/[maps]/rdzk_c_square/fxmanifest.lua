resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'
fx_version 'cerulean'
game 'gta5'
this_is_a_map 'yes'
lua54 'yes'

file 'sp_manifest.ymt'
-- SCENARIO_POINTS_FILE may work, too
data_file 'SCENARIO_POINTS_OVERRIDE_FILE' 'sp_manifest.ymt'

escrow_ignore {
	"Legion Square [0]/rdzk_c_square/stream/Main Content [STATIC PART]/ydr/replace/*.ydr",
}
dependency '/assetpacks'

author "Rudzik"
description "Legion Square"
version "1.0"



dependency '/assetpacks'