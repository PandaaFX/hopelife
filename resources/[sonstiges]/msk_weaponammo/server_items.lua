----------------------------------------------------------------
--------------------- CUSTOM ITEMS -----------------------------
----------------------------------------------------------------

-- !!! You can add Weapon Clips and Weapon Components !!!
-- !!! You have to configure them in the config.lua !!!

-- xPlayer.triggerEvent('msk_weaponammo:checkItem', 'itemname') -- Weapon Clip
-- xPlayer.triggerEvent('msk_weaponammo:addComponent', 'itemname') -- Weapon Component


ESX.RegisterUsableItem('polweaclip', function(source) -- Requested by spotxgrphy
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:checkItem', 'polweaclip')
end)

ESX.RegisterUsableItem('polweabox', function(source) -- Requested by spotxgrphy
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.triggerEvent('msk_weaponammo:checkItem', 'polweabox')
end)

----------------------------------------------------------------
-------------------- ORIGINAL ITEMS ----------------------------
----------------------------------------------------------------

-- Usable Items
ESX.RegisterUsableItem('weaclip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:checkItem', 'weaclip')
end)

ESX.RegisterUsableItem('weabox', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.triggerEvent('msk_weaponammo:checkItem', 'weabox')
end)

ESX.RegisterUsableItem('pistolclip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:checkItem', 'pistolclip')
end)

ESX.RegisterUsableItem('smgclip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:checkItem', 'smgclip')
end)

ESX.RegisterUsableItem('shotgunclip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:checkItem', 'shotgunclip')
end)

ESX.RegisterUsableItem('rifleclip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:checkItem', 'rifleclip')
end)

ESX.RegisterUsableItem('mgclip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:checkItem', 'mgclip')
end)

ESX.RegisterUsableItem('sniperclip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:checkItem', 'sniperclip')
end)

ESX.RegisterUsableItem('throwableclip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:checkItem', 'throwableclip')
end)

-- Attachments
ESX.RegisterUsableItem('scope', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addComponent', 'scope')
end)

ESX.RegisterUsableItem('grip', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addComponent', 'grip')
end)

ESX.RegisterUsableItem('flashlight', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addComponent', 'flashlight')
end)

ESX.RegisterUsableItem('clip_extended', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addComponent', 'clip_extended')
end)

ESX.RegisterUsableItem('suppressor', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addComponent', 'suppressor')
end)

ESX.RegisterUsableItem('luxary_finish', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addComponent', 'luxary_finish')
end)

-- Tints
ESX.RegisterUsableItem('tint_green', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
    xPlayer.triggerEvent('msk_weaponammo:addTint', 'tint_green')
end)

ESX.RegisterUsableItem('tint_gold', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addTint', 'tint_gold')
end)

ESX.RegisterUsableItem('tint_pink', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addTint', 'tint_pink')
end)

ESX.RegisterUsableItem('tint_army', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addTint', 'tint_army')
end)

ESX.RegisterUsableItem('tint_lspd', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addTint', 'tint_lspd')
end)

ESX.RegisterUsableItem('tint_orange', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addTint', 'tint_orange')
end)

ESX.RegisterUsableItem('tint_platinum', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.triggerEvent('msk_weaponammo:addTint', 'tint_platinum')
end)

-- Remover
ESX.RegisterUsableItem('attachment_remover', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.triggerEvent('msk_weaponammo:openAttachmentMenu')
end)