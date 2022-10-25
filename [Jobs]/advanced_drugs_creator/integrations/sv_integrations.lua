-- You can edit the events on the right side if you for any reason don't use the default event name

EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found    
}

-- If you use different names for police job, you can add/change it here, all jobs here will be used for police features (example: the alerts)
POLICE_JOBS_NAMES = {
    ["police"] = true,
    ["fbi"] = true
}

-- Skips or not if an item exists (useful with inventories that doesn't save items in database or in ESX.Items table, example ox_inventory)
SKIP_ITEM_EXISTS_CHECK = false

-- Enable or not the integration for ox_inventory for ESX.Items table
USE_OX_INVENTORY = false

-- Force inventory refresh or not. Set to true if NPC selling is not working properly
FORCE_INVENTORY_REFRESH = true

--[[
    Completely disables the players inventories refresh, so the automaitc NPC selling will be not possible, but will result in better performance
    when enabling this option, it's suggested to enable the command to manually sell to the closest NPC (the option "COMMAND_TO_MANUALLY_SELL_TO_NPCS")
]]
COMPLETELY_DISABLE_INVENTORIES_REFRESH = false

--[[
    if set to "nil" (without quotes), the command will NOT be available
    if set to any command, the command will be available

    This command will make the players to sell drugs to the closest NPC

    Examples:

    COMMAND_TO_MANUALLY_SELL_TO_NPCS = nil -- Disabled command
    COMMAND_TO_MANUALLY_SELL_TO_NPCS = "sell" -- Enabled command with /sell command
    COMMAND_TO_MANUALLY_SELL_TO_NPCS = "drugsell" -- Enabled command with /drugsell command
]]
COMMAND_TO_MANUALLY_SELL_TO_NPCS = nil

--[[
    You can edit this function if you want to add second jobs or anything like that (editing this function is up to you)
    If you edit this, you WILL have also to edit the function in cl_integrations.lua file
]]
function isPlayerAllowedForLaboratory(playerId, allowedJobs)
    local jobName = Framework.getPlayerJobName(playerId)

    return allowedJobs[jobName]
end