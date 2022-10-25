-- ====================================================================================
--                                    RoadToSix 
-- ====================================================================================

function getPhoneRandomNumber()

    local numBase = math.random(1000000, 9999999)
    num = string.format("%07d", numBase)
    return num
end

ESX.RegisterUsableItem('phone', function(source)
    TriggerClientEvent('roadphone:use', source)
end)

RegisterCommand('fixphone', function(source)
    TriggerEvent('roadphone:playerLoad', source)
end)


function GetPlayerFromPhone(number)
    local identifier = MySQL.scalar.await(
                           'SELECT identifier FROM users WHERE phone_number = @phone_number',
                           {['@phone_number'] = number})

    if identifier then return ESX.GetPlayerFromIdentifier(identifier) end

    return nil
end

function GetNumberFromSource(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    local phone_number = MySQL.scalar.await(
                             'SELECT phone_number FROM users WHERE identifier = @identifier',
                             {['@identifier'] = xPlayer.identifier})

    if phone_number then return phone_number end

    return nil
end

function getJobName(identifier)

    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    if xPlayer then return xPlayer.getJob().name end

    return nil

end

function getNumberFromIdentifier(identifier)

    local phone_number = MySQL.scalar.await(
                             'SELECT phone_number FROM users WHERE identifier = @identifier',
                             {['@identifier'] = identifier})

    if phone_number then return phone_number end

    return nil

end



RegisterNetEvent('roadphone:sendDispatch')
AddEventHandler('roadphone:sendDispatch', function(source, text, job, position, anonym)
    local sourcePlayer = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(sourcePlayer)
    local playernumber = GetNumberFromSource(sourcePlayer)

    if xPlayer and playernumber then

        if not text then text = "0" end

        if checkExploitString(sourcePlayer, text) then do return end end

        local sender = playernumber

        if anonym then sender = 0 end

        MySQL.query(
            "INSERT INTO `roadphone_jobs` (`sender`, `jobreceived`, `message`, `gps`) VALUES (@sender, @jobsreceived, @message, @gps)",
            {
                ['@sender'] = sender,
                ['@jobsreceived'] = job,
                ['@message'] = text,
                ['@gps'] = json.encode(position)
            }, function()
                TriggerClientEvent('roadphone:dispatchnotify', -1, job)
            end)

        if sender == 0 then sender = "Anonym" end

        sendToDiscordJobs("15158332", "Jobs",
                          'Number: ' .. sender .. '\n' .. 'Message: ' .. text ..
                              '\n' .. 'Received Job: ' .. job, "RoadPhone",
                          "")
    end
end)

if not Config.myMultichar then
    AddEventHandler(Config.ESXName .. ':playerLoaded',
                    function(playerId, xPlayer)

        Wait(4000)
        TriggerEvent("roadphone:playerLoad", playerId)

    end)
end

function checkYellowPageMoney(identifier, cb)

    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    if xPlayer then
        if API.YellowPageFee > 0 then
            if xPlayer.getAccount('bank').money < API.YellowPageFee then
                TriggerClientEvent("roadphone:sendNotification", xPlayer.source,
                                   {
                    title = _U('yellowpageapp'),
                    sender = _U('yellownotenoughmoney'),
                    message = nil,
                    img = "/public/html/static/img/icons/app/gelbeseiten.png"
                })
                if Config.ShowOffNotifications then
                    xPlayer.showNotification(_U('yellownotenoughmoney'))
                end
                cb(false)
                return
            end
            xPlayer.removeAccountMoney('bank', API.YellowPageFee)
            cb(true)
            return
        end
        cb(true)
    end
end

function getFirstname(identifier)
    local result = MySQL.query.await("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] then

        if not result[1].firstname then
            result[1].firstname = " "
        end

        if not result[1].lastname then
            result[1].lastname = " "
        end

        return result[1].firstname .. ' ' ..result[1].lastname
    end
    return nil
end

ESX.RegisterServerCallback('roadphone:getPhoneAmount', function(source, cb)
    if Config.NeedItem then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return; end
        for _, v in pairs(Config.Items) do
            local items = xPlayer.getInventoryItem(v)
            if items.count > 0 then
                cb(true)
                return
            end
        end
        cb(nil)
    else
        cb(true)
    end
end)

ESX.RegisterServerCallback('roadphone:getRadioAmount', function(source, cb)
    if Config.RadioNeedItem then
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return; end
        for _, v in pairs(Config.RadioItems) do
            local items = xPlayer.getInventoryItem(v)
            if items.count > 0 then
                cb(true)
                return
            end
        end
        cb(nil)
    else
        cb(true)
    end
end)

-- Comment out if you want the job to update itself directly in the JobsApp.

--[[AddEventHandler("esx:setJob", function(source, job)
        local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer then
            MySQL.update("UPDATE users SET job = @job, job_grade = @job_grade WHERE identifier = @identifier", {
                ["@job"] = job.name,
                ["@job_grade"] = job.grade,
                ["@identifier"] = xPlayer.identifier
            }) 
        end
end)--]]

ESX.RegisterServerCallback("roadphone:loadWorkmates", function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return; end

    local job = xPlayer.getJob().name

    if tostring(job) == tostring(Config.unemployedJobName) then
        cb()
        return
    end

    local result = MySQL.query.await(
                       "SELECT job,job_grade,firstname,lastname,phone_number FROM " ..
                           Config.UserTable .. " WHERE job = @job",
                       {['@job'] = job})

    if result then
        cb(result)
        return
    end

    cb()

end)

 function sendToDiscordBankTransactions(color, name, message, footer)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = {["text"] = footer}
        }
    }

    local bankwebhook = API.BankTransactionsWebhook

    if bankwebhook == '' then return end

    PerformHttpRequest(bankwebhook, function(err, text, headers) end, 'POST',
                       json.encode({username = name, embeds = embed}),
                       {['Content-Type'] = 'application/json'})
end

function sendToDiscordYellowApp(color, name, message, footer, img)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["image"] = {url = img},
            ["footer"] = {["text"] = footer}
        }
    }

    local yellowappwebhook = API.YellowAppWebhook

    if yellowappwebhook == '' then return end

    PerformHttpRequest(yellowappwebhook, function(err, text, headers) end,
                       'POST', json.encode({username = name, embeds = embed}),
                       {['Content-Type'] = 'application/json'})
end

function sendToDiscordYellowAppLogs(color, name, message, footer, img)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["image"] = {url = img},
            ["footer"] = {["text"] = footer}
        }
    }

    local yellowappwebhooklogs = API.YellowAppWebhookLogs

    if yellowappwebhooklogs == '' then return end

    PerformHttpRequest(yellowappwebhooklogs, function(err, text, headers) end,
                       'POST', json.encode({username = name, embeds = embed}),
                       {['Content-Type'] = 'application/json'})
end

function sendToDiscordExploit(color, name, message, footer, img)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["image"] = {url = img},
            ["footer"] = {["text"] = footer}
        }
    }

    local exploitwebhook = API.ExploitWebhook

    if exploitwebhook == '' then return end

    PerformHttpRequest(exploitwebhook, function(err, text, headers) end, 'POST',
                       json.encode({username = name, embeds = embed}),
                       {['Content-Type'] = 'application/json'})
end

function sendToDiscordJobs(color, name, message, footer, img)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["image"] = {url = img},
            ["footer"] = {["text"] = footer}
        }
    }

    local jobswebhook = API.JobsAppWebhook

    if jobswebhook == '' then return end

    PerformHttpRequest(jobswebhook, function(err, text, headers) end, 'POST',
                       json.encode({username = name, embeds = embed}),
                       {['Content-Type'] = 'application/json'})
end

function sendToDiscordMessages(color, name, message, footer, img)
    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["image"] = {url = img},
            ["footer"] = {["text"] = footer}
        }
    }

    local messagewebhook = API.MessageAppWebhook

    if messagewebhook == '' then return end

    PerformHttpRequest(messagewebhook, function(err, text, headers) end, 'POST',
                       json.encode({username = name, embeds = embed}),
                       {['Content-Type'] = 'application/json'})

end

function valetWebhook(color, name, message, footer)

    local embed = {
        {
            ["color"] = color,
            ["title"] = "**" .. name .. "**",
            ["description"] = message,
            ["footer"] = {["text"] = footer}
        }
    }

    local valetWebhook = API.ValetWebhook

    if valetWebhook == '' then return end

    PerformHttpRequest(valetWebhook, function(err, text, headers) end, 'POST',
                       json.encode({username = name, embeds = embed}),
                       {['Content-Type'] = 'application/json'})
    
end
