ESX = nil 
local admins = {
    'license:b7a7e5207f262bec153355234b7e4a89c16fae1a'
}
---
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
function isAdmin(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end
RegisterServerEvent('souki_pedmenu:checkadmin')
AddEventHandler('souki_pedmenu:checkadmin', function()
	local id = source
	if isAdmin(id) then
		TriggerClientEvent("souki_pedmenu:checkid", source)
	end
end)