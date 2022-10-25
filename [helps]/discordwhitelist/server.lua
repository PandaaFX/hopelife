
notWhitelisted = "Hopelife » Du bist nicht gewhitelisted. Bitte joine dafür auf unseren Discord Server » https://discord.gg/hopelife » Gehe danach in denn Whitelist Warteraum"
noDiscord = "Hopelife » Bitte öffne Discord bevor Du dich verbindest."

roles = {
    "Einwohner",
}

AddEventHandler("playerConnecting", function(name, setCallback, deferrals)
    local src = source
    deferrals.defer()
    deferrals.update("Hopelife » Berechtigung werden geprüft")

    for k, v in ipairs(GetPlayerIdentifiers(src)) do
        if string.sub(v, 1, string.len("discord:")) == "discord:" then
            identifierDiscord = v
        end
    end

    if identifierDiscord then
        for i = 1, #roles do
            if exports.discordwhitelist:IsRolePresent(src, roles[i]) then
                deferrals.done()
            else
                deferrals.done(notWhitelisted)
            end
        end
    else
        deferrals.done(noDiscord)
    end
end)


local FormattedToken = "Bot "..Config.DiscordToken

function DiscordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
		data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = FormattedToken})

    while data == nil do
        Citizen.Wait(0)
    end
	
    return data
end

function GetRoles(user)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break
		end
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(Config.GuildId, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			return roles
		else
			return false
		end
	else
		return false
	end
end

function IsRolePresent(user, role)
	local discordId = nil
	for _, id in ipairs(GetPlayerIdentifiers(user)) do
		if string.match(id, "discord:") then
			discordId = string.gsub(id, "discord:", "")
			break
		end
	end

	local theRole = nil
	if type(role) == "number" then
		theRole = tostring(role)
	else
		theRole = Config.Roles[role]
	end

	if discordId then
		local endpoint = ("guilds/%s/members/%s"):format(Config.GuildId, discordId)
		local member = DiscordRequest("GET", endpoint, {})
		if member.code == 200 then
			local data = json.decode(member.data)
			local roles = data.roles
			local found = true
			for i=1, #roles do
				if roles[i] == theRole then
					return true
				end
			end
			return false
		else
			return false
		end
	else
		return false
	end
end

Citizen.CreateThread(function()
	local guild = DiscordRequest("GET", "guilds/"..Config.GuildId, {})
	if guild.code == 200 then
		local data = json.decode(guild.data)
		print("Hopelife Roleplay Discord Whitelist Aktiv")
	else
		print("Discord Whitelist konnte nicht gestartet werden!") 
	end
end)
