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



RegisterServerEvent('souki_pedmenu:pedmenu:customsetpedcommand:sv')
AddEventHandler('souki_pedmenu:pedmenu:customsetpedcommand:sv', function()
	local id = source
	if isAdmin2(id) then
		TriggerClientEvent("souki_pedmenu:checkid", source)
	end
end)



local pedswithowner = {
    {license = 'license:171bdec412d216926b20b185bf0efbe30d76d2a0', ped = 'hope_gang'},
    {license = 'license:d30f00afb8429dc31f5dfb05213eae53cf6e2513', ped = 'hope_pd'},
    {license = 'license:185db27623074ebf61a01115ec9551042c78cc3a', ped = 'babyboy1'},
    {license = 'license:a8d0d5cb8c664b0dbb922140d6a3caddad388e3b', ped = 'a_c_husky'},
    {license = 'license:df3f4cd11c2cfb2ddfeaf86fee889d1067a33e7d', ped = 'a_c_shepherd'},
    {license = 'license:8e3e4f3a49847c4910cf30bb183ce79126478ca0', ped = 'babygirl02'},

}


function isAdmin2(player)
    local allowed = false
    local ped = ''
    for i,id in ipairs(pedswithowner) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == id.license then
                allowed = true
                ped = id.ped
            end
        end
    end
    return {allowed = allowed, ped = ped}
    -- print(json.encode(pedswithowner))
end

RegisterCommand('toggleped', function(source)
    local allowed = isAdmin2(source).allowed
    local ped = isAdmin2(source).ped

    if allowed then
		TriggerClientEvent("souki_pedmenu:pedmenu:customsetpedcommand:cl:setped", source, ped)
    end
end)
