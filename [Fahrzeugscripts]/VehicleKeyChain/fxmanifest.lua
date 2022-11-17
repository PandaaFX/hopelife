



fx_version 'cerulean'
games { 'gta5' }

author 'Philipp Decker'
description 'Manage vehicle keys!'
version '1.3'

dependency 'kimi_callbacks'
-- depending on which menu you are using (un)comment the following lines
--dependency 'ContextMenu'
dependency 'NativeUI'

server_scripts {
	'@oxmysql/lib/MySQL.lua',

	'config.lua',
	'server.lua'
}

client_scripts {
	-- comment these lines if not using the ContextMenu
	--'@ContextMenu/screenToWorld.lua',
	--'@ContextMenu/Drawables/Color.lua',
	--'@ContextMenu/Drawables/Rect.lua',
	--'@ContextMenu/Drawables/Text.lua',
	--'@ContextMenu/Drawables/Sprite.lua',
	--'@ContextMenu/Menu/Item.lua',
	--'@ContextMenu/Menu/TextItem.lua',
	--'@ContextMenu/Menu/CheckboxItem.lua',
	--'@ContextMenu/Menu/SubmenuItem.lua',
	--'@ContextMenu/Menu/Separator.lua',
	--'@ContextMenu/Menu/Border.lua',
	--'@ContextMenu/Menu/Menu.lua',
	--'@ContextMenu/Menu/MenuPool.lua',

	-- comment this line if not using NativeUILua
	'@NativeUI/NativeUI.lua',

	'config.lua',
	'client.lua'
}

server_exports {
	'IsVehicleOwner',
	'IsKeyOwner',
	'IsVehicleOrKeyOwner',
	'GetPlayerKeys',
	'GetPlayerVehicles'
}

exports {
	'IsVehicleOwner',
	'IsKeyOwner',
	'IsVehicleOrKeyOwner',
	'GetAllKeys',
	'GetAllVehicles'
}


