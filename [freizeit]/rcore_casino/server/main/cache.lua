Cache = {}
Cache.Settings = {}
Cache.PedNetIdCache = {}

-- MongoDB Select/Insert/Update
MongoDB = {}

-- Insert
function MongoDB:Insert(tableName, dbObject, onFinish)
    exports.mongodb:insertOne({
        collection = tableName,
        document = dbObject
    }, onFinish)
end

-- Update
function MongoDB:UpdateOne(tableName, whereObject, dbObject, callback)
    exports.mongodb:updateOne({
        collection = tableName,
        query = whereObject,
        update = {
            ["$set"] = dbObject
        }
    }, callback)
end

-- Select
function MongoDB:Select(tableName, whereObject)
    local promise = promise:new()
    local rows = {}
    local success = pcall(function()
        exports.mongodb:find({
            collection = tableName,
            query = whereObject
        }, function(success, result)
            if not success then
                promise:resolve(1)
                return
            end
            for i, document in ipairs(result) do
                table.insert(rows, document)
            end
            promise:resolve(1)
        end)
    end)

    if not success then
        promise:resolve(1)
    end

    Citizen.Await(promise)
    return rows
end

-- Select One
function MongoDB:SelectOne(tableName, whereObject)
    local data = MongoDB:Select(tableName, whereObject)
    if data and #data > 0 then
        return data[1]
    else
        return nil
    end
end

-- Delete
function MongoDB:Delete(tableName, whereObject, callback)
    exports.mongodb:delete({
        collection = tableName,
        query = whereObject
    }, callback)
end

-- cached players
local PlayerCache = {}
local PlayerState = {}

function Cache:RemovePlayerState(playerId)
    PlayerState[playerId] = nil
end

function Cache:GetPlayerState(playerId, stateKey, defaultValue)
    if not playerId or not stateKey then
        return defaultValue
    end
    if not PlayerState[playerId] or not PlayerState[playerId][stateKey] then
        return defaultValue
    end
    return PlayerState[playerId][stateKey]
end

function Cache:SetPlayerState(playerId, stateKey, stateValue)
    if not playerId or not stateKey then
        return
    end
    if PlayerState[playerId] == nil then
        PlayerState[playerId] = {}
    end
    PlayerState[playerId][stateKey] = stateValue
end

function Cache:IncrementPlayerState(playerId, stateKey, incrementValue)
    if not playerId or not stateKey then
        return
    end
    if PlayerState[playerId] == nil then
        PlayerState[playerId] = {}
    end
    if PlayerState[playerId][stateKey] == nil then
        PlayerState[playerId][stateKey] = incrementValue
    else
        PlayerState[playerId][stateKey] = PlayerState[playerId][stateKey] + incrementValue
    end
end

function Cache:PlayerToNet(playerId)
    if playerId == nil then
        return -1
    end
    return Cache.PedNetIdCache[playerId] and Cache.PedNetIdCache[playerId] or -1
end

function Cache:Get(identifier, onFinish)
    DebugStart("Cache:Get")
    -- check & return, if already cached
    if PlayerCache[identifier] then
        if onFinish then
            PlayerCache[identifier].activeTime = GetGameTimer()
            onFinish(PlayerCache[identifier])
        end
        return
    end

    if Config.MongoDB then
        -- fetch from MongoDB if not cached yet
        local row = MongoDB:SelectOne("casino_players", {
            identifier = identifier
        })
        if row then
            PlayerCache[identifier] = json.decode(row.properties)
            PlayerCache[identifier].activeTime = GetGameTimer()
            PlayerCache[identifier].lastSave = GetGameTimer()
        else
            PlayerCache[identifier] = {
                lastSave = GetGameTimer(),
                logins = 0,
                vip = false,
                firstTime = true,
                activeTime = GetGameTimer()
            }
        end

        if onFinish then
            onFinish(PlayerCache[identifier])
        end
    else
        -- fetch from MYSQL if not cached yet
        MySQL.Async.fetchAll('SELECT * FROM casino_players WHERE identifier = @id LIMIT 1', {
            ['@id'] = identifier
        }, function(result)
            if result[1] and result[1].properties then
                PlayerCache[identifier] = json.decode(result[1].properties)
                PlayerCache[identifier].activeTime = GetGameTimer()
                PlayerCache[identifier].lastSave = GetGameTimer()
            else
                -- create new prop object
                PlayerCache[identifier] = {
                    lastSave = GetGameTimer(),
                    logins = 0,
                    vip = false,
                    firstTime = true,
                    activeTime = GetGameTimer()
                }
            end

            if onFinish then
                onFinish(PlayerCache[identifier])
            end
        end)
    end
end

function Cache:Save(identifier)
    DebugStart("Cache:Save")
    -- props for this player don't exist
    local cache = PlayerCache[identifier]
    if not cache then
        return
    end

    cache.lastSave = GetGameTimer()
    local props = json.encode(cache)

    if Config.MongoDB then
        -- MongoDB
        MongoDB:UpdateOne("casino_players", {
            identifier = identifier
        }, {
            properties = props
        }, function(success, updatedCount)
            if success and updatedCount == 0 then
                MongoDB:Insert("casino_players", {
                    identifier = identifier,
                    properties = props
                })
            end
        end)
    else
        -- Mysql
        local rowsChanged = MySQL.Sync.execute('UPDATE casino_players SET properties = @props WHERE identifier = @id', {
            ['@props'] = props,
            ['@id'] = identifier
        })
        if rowsChanged == 0 then
            MySQL.Sync.execute('INSERT INTO casino_players (identifier, properties) VALUES (@id, @props)', {
                ['@props'] = props,
                ['@id'] = identifier
            })
        end
    end
end

function Cache:AutoSave()
    DebugStart("Cache:AutoSave")
    local time = GetGameTimer()
    for k, v in pairs(PlayerCache) do
        local savedAgo = time - tonumber(v.lastSave)
        -- if player was saved long time ago
        if not v.lastSave or time - tonumber(v.lastSave) >= Config.CASINO_SAVE_TIMER then
            Cache:Save(k)
        end
    end
    Cache:RemoveOldCache()
end

function Cache:RemoveOldCache()
    DebugStart("Cache:RemoveOldCache")
    local timer = GetGameTimer()
    for k, v in pairs(PlayerCache) do
        if v.activeTime and (timer - v.activeTime) > 60000 * 60 then
            PlayerCache[k] = nil
        end
    end
end

function Cache:PlayerOwnsVehicle(identifier, plate)
    DebugStart("Cache:PlayerOwnsVehicle")
    local result = 0

    if Config.MongoDB then
        -- MongoDB
        result = MongoDB:Select("player_vehicles", {
            citizenid = identifier,
            plate = plate
        })
    else
        -- Mysql
        if Framework.Active == 1 then
            result = MySQL.Sync.fetchAll("SELECT * FROM owned_vehicles WHERE plate = @plate AND owner = @identifier", {
                ['@plate'] = plate,
                ['@identifier'] = identifier
            })
        elseif Framework.Active == 2 then
            result = MySQL.Sync.fetchAll(
                "SELECT * FROM player_vehicles WHERE plate = @plate AND citizenid = @identifier", {
                    ['@plate'] = plate,
                    ['@identifier'] = identifier
                })
        end
    end

    return result and #result ~= 0
end

function Cache:LoadSettings()
    DebugStart("Cache:LoadSettings")
    if Config.MongoDB then
        local result = MongoDB:SelectOne("casino_settings", {})
        if result then
            Cache.Settings = result
        else
            Cache.Settings = {
                PodiumPriceProps = {}
            }
        end
    else
        MySQL.Async.fetchAll('SELECT * FROM casino_settings LIMIT 1', nil, function(result)
            if result then
                Cache.Settings = result[1]
            else
                print("^1Casino settings don't exist in your MYSQL database. It won't work without it.^7")
            end
        end)
    end
    -- register society
    local s = Config.SocietyName
    TriggerEvent('esx_society:registerSociety', s, 'Diamond Casino', s, s, s, {
        type = 'public'
    })
end

function Cache:UpdateSetting(setting, settingContent)
    DebugStart("Cache:UpdateSetting")
    if Config.MongoDB then
        MongoDB:UpdateOne("casino_settings", {}, {
            [setting] = settingContent
        })
    else
        MySQL.Async.fetchAll('UPDATE casino_settings SET ' .. setting .. ' = @settingContent', {
            ['@settingContent'] = settingContent
        }, function(result)
            Cache:LoadSettings()
        end)
    end
end

function Cache:GiveVehicle(playerId, vehicleProps)
    DebugStart("Cache:GiveVehicle")
    vehicleProps.plate = VehiclePlate().GeneratePlate()
    if vehicleProps.plate == nil then
        return
    end
    local p = ESX.GetPlayerFromId(playerId)

    if Config.MongoDB then
        MongoDB:Insert("player_vehicles", {
            citizenid = p.identifier,
            mods = json.encode(vehicleProps),
            state = 1,
            damages = "{}",
            body = 1000,
            engine = 1000,
            plate = vehicleProps.plate,
            hash = vehicleProps.model
        })
    else
        if Framework.Active == 1 then
            MySQL.Async.execute(
                'INSERT INTO `owned_vehicles` (`owner`, `plate`, `vehicle`, `stored`) VALUES (@owner, @plate, @vehicle, @stored)',
                {
                    ['@owner'] = p.identifier,
                    ['@plate'] = vehicleProps.plate,
                    ['@vehicle'] = json.encode(vehicleProps),
                    ['@stored'] = 1
                }, nil)
        elseif Framework.Active == 2 then
            MySQL.Async.execute(
                'INSERT INTO `player_vehicles` (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`) VALUES (@license, @citizenid, @vehicle, @hash, @mods, @plate, @state)',
                {
                    ['@license'] = p.license,
                    ['@citizenid'] = p.identifier,
                    ['@vehicle'] = vehicleProps.podiumName,
                    ['@hash'] = vehicleProps.model,
                    ['@mods'] = json.encode(vehicleProps),
                    ['@plate'] = vehicleProps.plate,
                    ['@state'] = 1
                }, nil)
        end
    end
end

local function Mysql_InstallGrades()
    if Config.MongoDB then
        print("^1Auto-Install is only avaiable for Mysql. Get help.^7")
        return
    end
    local queries = {}
    local s = Config.JobName
    table.insert(queries, 'DELETE FROM job_grades WHERE job_name="' .. s .. '"')
    table.insert(queries, 'DELETE FROM jobs WHERE name="' .. s .. '"')
    table.insert(queries, 'INSERT IGNORE INTO jobs (name, label) VALUES ("' .. s .. '", "Casino");')
    table.insert(queries,
        'INSERT IGNORE INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES ("' .. s ..
            '", 0, "novice", "novice", 200, "{}", "{}");')
    table.insert(queries,
        'INSERT IGNORE INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES ("' .. s ..
            '", 1, "experienced", "experienced", 400, "{}", "{}");')
    table.insert(queries,
        'INSERT IGNORE INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES ("' .. s ..
            '", 2, "boss", "boss", 600, "{}", "{}");')
    for k, v in pairs(queries) do
        MySQL.Sync.execute(v)
    end
end

local function Mysql_InstallItems()
    if Config.MongoDB then
        print("^1Auto-Install is only avaiable for Mysql. Get help.^7")
        return
    end
    local queries = {}
    local invItems = {
        ["casino_beer"] = "Casino\\'s Beer",
        ["casino_burger"] = "Casino\\'s Burger",
        [Config.ChipsInventoryItem] = "Casino\\'s Chips",
        ["casino_coffee"] = "Casino\\'s Coffee",
        ["casino_coke"] = "Casino\\'s Coke",
        ["casino_donut"] = "Casino\\'s Donut",
        ["casino_ego_chaser"] = "Casino\\'s Ego Chaser",
        ["casino_luckypotion"] = "Casino\\'s Potion",
        ["casino_psqs"] = "Casino\\'s PsQs",
        ["casino_sandwitch"] = "Casino\\'s Sandwitch",
        ["casino_sprite"] = "Casino\\'s Sprite"
    }
    table.insert(queries, 'DELETE FROM items WHERE `name` LIKE \'casino_%\'')
    for k, v in pairs(invItems) do
        table.insert(queries, "INSERT INTO `items` (`name`, `label`, `rare`, `can_remove`) VALUES ('" .. k .. "', '" ..
            v .. "', 0, 1);")
    end

    local hasWeight = MySQL.Sync.fetchAll('SHOW COLUMNS FROM `items` LIKE \'weight\';')

    if hasWeight and #hasWeight == 1 then
        table.insert(queries, 'UPDATE items SET weight=0 WHERE `name` LIKE \'casino_%\'')
    end

    for k, v in pairs(queries) do
        MySQL.Sync.execute(v)
    end
end

local function Mysql_Install()
    if Config.MongoDB then
        print("^1Auto-Install is only avaiable for Mysql. Get help.^7")
        return
    end
    local queries = {}
    table.insert(queries, 'DROP TABLE IF EXISTS `casino_players`;')
    table.insert(queries, 'DROP TABLE IF EXISTS `casino_settings`;')
    table.insert(queries,
        'CREATE TABLE `casino_players` (`ID` int(11) NOT NULL, `identifier` varchar(128) NOT NULL, `properties` longtext NOT NULL );')
    table.insert(queries, 'ALTER TABLE `casino_players` ADD PRIMARY KEY (`ID`);')
    table.insert(queries, 'ALTER TABLE `casino_players` MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;')
    table.insert(queries,
        'CREATE TABLE `casino_settings` (`ID` int(11) NOT NULL, `PodiumPriceProps` longtext NOT NULL);')
    table.insert(queries, 'INSERT INTO `casino_settings` (`ID`, `PodiumPriceProps`) VALUES(1, \'\');')
    table.insert(queries, 'ALTER TABLE `casino_settings` ADD PRIMARY KEY (`ID`);')
    table.insert(queries, 'ALTER TABLE `casino_settings` MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;')

    for k, v in pairs(queries) do
        MySQL.Sync.execute(v)
    end
end

local function Mysql_Check()
    if Config.MongoDB then
        return
    end
    local s = Config.JobName
    local result = MySQL.Sync.fetchAll('SHOW TABLES LIKE "casino_players";', {})
    if result and #result == 0 then
        print("Casino Mysql isn't created yet. Creating now.")
        Mysql_Install()
    end
end

local function Society_Check()
    local s = Config.SocietyName
    if Framework.Active == 1 then
        local result = MySQL.Sync.fetchAll('SELECT * FROM `addon_account` WHERE name = \'' .. s .. '\'')
        if result and #result ~= 1 then
            MySQL.Sync.execute(
                "INSERT IGNORE INTO `addon_account` (`name`, `label`, `shared`) VALUES ('" .. s .. "', '" .. s ..
                    "', '1');")
            print("Society account '" .. s .. "' was just created. Restart addonaccount or the server to make it work.")
        end
    end
end

local function Start()
    Mysql_Check()
    Cache:LoadSettings()
    CreateThread(function()
        Config.CASINO_SAVE_TIMER = Clamp(Config.CASINO_SAVE_TIMER, 1000, 1000 * 60 * 60)
        while true do
            Cache:AutoSave()
            Wait(Config.CASINO_SAVE_TIMER)
        end
    end, true)

end

if Config.MongoDB then
    CreateThread(function()
        while not exports.mongodb.isConnected() do
            Wait(33)
        end
        Start()
    end)
else
    MySQL.ready(function()
        Start()
    end)
end

RegisterCommand("casinoinstall", function(source, args, rawCommand)
    if Framework.Active ~= 1 then
        return
    end
    local installType = args[1]

    if installType == "job" then
        Mysql_InstallGrades()
    elseif installType == "items" then
        Mysql_InstallItems()
    elseif installType == "society" then
        Society_Check()
    else
        print("Wrong install type. Enter 'casinoinstall job/items/society'")
    end
end)
