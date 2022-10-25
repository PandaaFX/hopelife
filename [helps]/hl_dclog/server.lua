ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

local webhook = "https://discord.com/api/webhooks/971455679661494363/eywHXQVjjU6QnB7v-rrGqyzUuiZpUp2leAzeg1gMh7E0oafbNEnWd4H04OrQDNEou9Rt"
local name = "Hopelife Discord"
local logo = "https://cdn.discordapp.com/attachments/705017727957336165/765153188524851200/1609855.png" -- Must end with png, jpg e.t.c.



-- Player Connecting Event --

AddEventHandler('playerConnecting', function()
    local playerName = GetPlayerName(source)
    local playerIp = GetPlayerEndpoint(source)
    local playerPing = GetPlayerPing(source)
    local playerHex = GetPlayerIdentifier(source)

    local connecting = {
        {
            ["color"] = "000000",
            ["title"] = "Player Connecting",
            ["description"] = "Player Name: *"..playerName.."*\n\nPlayer IP: *"..playerIp.."*\n\n Player Ping: *"..playerPing.."*",
	        ["footer"] = {
                ["text"] = name,
                ["icon_url"] = logo,
            },
        }
    }

    
-- Sending Embed To Discord Webhook --

PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = name, embeds = connecting}), { ['Content-Type'] = 'application/json' })
end)



-- Player Disconnecting Event --
AddEventHandler('playerDropped', function(reason)
    local xPlayer = ESX.GetPlayerFromId(source) 
    local playerName = GetPlayerName(source)
    local playerIp = GetPlayerEndpoint(source)
    local playerPing = GetPlayerPing(source)
    local playerHex = GetPlayerIdentifier(source)
    local playerMoney = xPlayer.getMoney()
    local playerBank = xPlayer.getAccount('bank').money
    local playerJob = xPlayer.job.name
    local playerId = source
    local disconnecting = {
        {
            ["color"] = "000000",
            ["title"] = "Player Disconnecting",
            ["description"] = "Player Name: *"..playerName.."*\n\nReason: *"..reason.."*\n\nPlayer IP: *"..playerIp.."*\n\nPlayer Bank: *"..playerBank.."*\n\nPlayer Cash: *"..playerMoney.."*\n\nPlayer Job: *"..playerJob.."*\n\nPlayer Steam Hex: *"..playerHex.."*\n Player Ping: *"..playerPing.."*",
            ["footer"] = {
                ["text"] = name,
                ["icon_url"] = logo,
            },
        }
    }
-- Sending Embed To Discord Webhook --
PerformHttpRequest(webhook, function (err, text, headers) end, 'POST', json.encode({username = name, embeds = disconnecting}), { ['Content-Type'] = 'application/json' })
end)