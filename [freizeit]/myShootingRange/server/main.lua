ESX = nil
while ESX == nil do
	TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
end

local difficulties = {}

for i=1, #Config.Difficulties do
	difficulties[Config.Difficulties[i].id] = Config.Difficulties[i].pointsScoreboard
end 



MySQL.ready(function()
	handleDatabaseTable()
	deleteScores(false)
	rewritePositionsAll()
end)

RegisterNetEvent("myShootingRange:notifyOthers")
AddEventHandler("myShootingRange:notifyOthers", function(playerCoods, text, includePlayerName)
	if includePlayerName then 
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		assert(xPlayer ~= nil, "xPlayer could not be found")
		local PlayerName = getPlayerNameDB(xPlayer.identifier)
		text = PlayerName .. text
	end 
	doNotifyOthers(source, text, playerCoods)
end)


RegisterNetEvent("myShootingRange:saveScore")
AddEventHandler("myShootingRange:saveScore", function(countTargets, points, difficulty, selectedWeapon, shootingrange_id, playerCoods)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	assert(xPlayer ~= nil, "xPlayer could not be found")
	
	local PlayerName = getPlayerNameDB(xPlayer.identifier)

	if points > 0 then 
		local newScore = calcScore(difficulty.id, points, countTargets)
		local currentScoredata = getOwnData(shootingrange_id, xPlayer.identifier) 
		local oldScore = 0
		local oldPosition = nil
		local isInsert = true
		local doSaveData = false

		if currentScoredata ~= nil then 
			oldScore = currentScoredata.score
			oldPosition = currentScoredata.placement
			isInsert = false
		end 

		if newScore > oldScore then 
			doSaveData = true
		end 

		if doSaveData then 
			handleDataSave(isInsert, shootingrange_id, xPlayer.identifier, difficulty.id, selectedWeapon, newScore)
			rewritePositions(shootingrange_id)
			local newScoredata = getOwnData(shootingrange_id, xPlayer.identifier) 
			TriggerClientEvent("myShootingRange:notify", _source, Translations[Config.Locale].new_hightscore .. Translations[Config.Locale].newline .. newScore)
			if oldPosition ~= newScoredata.placement then 
				local rewardtext = getReward(xPlayer, shootingrange_id, oldPosition, newScoredata.placement)
				TriggerClientEvent("myShootingRange:notify", _source, rewardtext)
			end
		else
			TriggerClientEvent("myShootingRange:notify", _source, Translations[Config.Locale].hightscore_not_beaten .. Translations[Config.Locale].newline .. oldScore .. "/" .. newScore)
		end 

		doNotifyOthers(_source, PlayerName .. Translations[Config.Locale]["score_result_others"] .. newScore, playerCoods )

	else
		TriggerClientEvent("myShootingRange:notify", _source, Translations[Config.Locale]["scoreis0"])
		doNotifyOthers(_source, PlayerName .. Translations[Config.Locale]["others_noscore"] .. newScore, playerCoods )
	end 
end)




ESX.RegisterServerCallback('myShootingRange:loadScores', function(source, cb, shootingrange_id)
	local xPlayer = ESX.GetPlayerFromId(source)
    assert(xPlayer ~= nil, "xPlayer could not be found")
	local identifier = nil

	local OwnScoreData = getOwnData(shootingrange_id, xPlayer.identifier) 


	local data={}
	local results = getScoreBoardData(shootingrange_id)

	for i=1, #results do 

		results[i].weaponname = ESX.GetWeaponLabel(results[i].weapon)
		results[i].difficulty_points = 0
		if difficulties[results[i].difficulty] ~= nil then 
			results[i].difficulty_points = difficulties[results[i].difficulty]
		end 
		table.insert(data, results[i])
	end 
	cb(data, OwnScoreData)
end)

ESX.RegisterServerCallback('myShootingRange:pay', function(source, cb, priceMain, priceRent)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	--print(tosting(xPlayer))

	assert(xPlayer ~= nil, "xPlayer could not be found")


	if Config.AccountMoneyType == "money" then
		-- for ESX 1.1 compatibility
		local price = priceMain + priceRent;
		if xPlayer.getMoney() >= price then 
			if price > 0 then 
				xPlayer.removeMoney(price)
			end 
			cb(true)
		else
			cb(false)
		end 
	else
		if xPlayer.getAccount(Config.AccountMoneyType) ~= nil then
			local playerMoney = xPlayer.getAccount(Config.AccountMoneyType).money
			local price = priceMain + priceRent;
			if playerMoney >= price then 
				if price > 0 then 
					xPlayer.removeAccountMoney(Config.AccountMoneyType, price)
				end 
				cb(true)
			else
				cb(false)
			end 
		else
			cb(false)
		end
	end
end)


if ESX.RegisterCommand ~= nil then
	ESX.RegisterCommand('deleteScoresShootingrange', 'admin', function(xPlayer, args, showError)
		deleteScores(true)	
	end, false, {help = "", validate = false, arguments = {}})

	
	--ESX.RegisterCommand('rewritepositions', 'admin', function(xPlayer, args, showError)
	--	rewritePositions(1)	
	--end, false, {help = "", validate = false, arguments = {}})

end

function handleDataSave(doInsert, shootingrange_id, identifier, difficulty_id, selectedWeapon, score)
	local Query = "" .. 
		"INSERT INTO `shootingranges_scores`(" ..
			" `shootingrange_id`" .. 
			" ,`identifier`" ..
			" ,`difficulty`" ..
			" ,`weapon`" .. 
			" ,`score`" ..
			" ,`score_created`" ..
		") VALUES (" ..
			" @shootingrange_id" .. 
			", @identifier" ..
			", @difficulty" .. 
			", @weapon" .. 
			", @score" ..
			", NOW()" ..
		") ON DUPLICATE KEY UPDATE " ..
			" `score` = VALUES(`score`)" ..
			" ,`weapon` = VALUES(`weapon`)" ..
			" ,`difficulty` = VALUES(`difficulty`)" ..
			" ,`score_created` = VALUES(`score_created`)"

	MySQL.Sync.execute(Query, {					
			['@shootingrange_id'] = shootingrange_id, 
			['@identifier'] = identifier,
			['@difficulty'] = difficulty_id,
			['@weapon'] = selectedWeapon,
			['@score'] = score			
	})
end 


function rewritePositionsAll()
	for i=1, #Config.ShootingRanges do 
		rewritePositions(Config.ShootingRanges[i].id)
	end 
end


function rewritePositions(shootingrange_id)
	local results = {}
	local Query = ""

	if Config.UseOldMySQL == false then 

		Query = "" ..
			" SELECT * FROM (" .. 
			" SELECT *, ROW_NUMBER() OVER (ORDER BY score DESC) row_num  FROM shootingranges_scores" .. 
			" WHERE shootingrange_id = @shootingrange_id" .. 
			" order by score DESC" .. 
			" ) as temp" .. 
			" where temp.row_num <> temp.placement"

		results = MySQL.Sync.fetchAll(Query, {
			['@shootingrange_id'] = shootingrange_id
		})

		if #results > 0 then
			for i=1, #results do
				MySQL.Sync.execute(
					'UPDATE `shootingranges_scores` SET `placement` = @placement WHERE `shootingrange_id` = @shootingrange_id AND `identifier` = @identifier', {					
					['@shootingrange_id'] = results[i].shootingrange_id, 
					['@identifier'] = results[i].identifier,
					['@placement'] = results[i].row_num
				})
			end 
		end 
	else
		Query = "" ..
			" SELECT *" .. 
			" FROM shootingranges_scores" ..
			" WHERE shootingrange_id = @shootingrange_id" .. 
			" order by score DESC" 
			
		results = MySQL.Sync.fetchAll(Query, {
			['@shootingrange_id'] = shootingrange_id
		})

		if #results > 0 then
			for i=1, #results do
				if i ~= results[i].placement then 
					MySQL.Sync.execute(
						'UPDATE `shootingranges_scores` SET `placement` = @placement WHERE `shootingrange_id` = @shootingrange_id AND `identifier` = @identifier', {					
						['@shootingrange_id'] = results[i].shootingrange_id, 
						['@identifier'] = results[i].identifier,
						['@placement'] = i
					})
				end
			end 
		end 
	end 

	return #results
end 

function getScoreBoardData(shootingrange_id)
	local dateformat = '%Y-%m-%d %H:%i'

	if Config.Locale == 'de' then
		dateformat = '%d.%m.%Y %H:%i'
	end 



	local Query = "" ..
		"SELECT" ..
			" shootingranges_scores.placement" ..
			" ,shootingranges_scores.identifier" ..
			" ,CONCAT(users.firstname, ' ',users.lastname) as _name" ..
			" ,shootingranges_scores.score" ..
			" ,shootingranges_scores.weapon" ..
			" ,shootingranges_scores.difficulty" ..
			" ,date_format(score_created, '" .. dateformat .. "') as scorecreated" ..

		" FROM shootingranges_scores" ..
			" LEFT JOIN users ON users.identifier = shootingranges_scores.identifier" ..

		" WHERE shootingrange_id = @shootingrange_id" ..
			" AND placement <= 10" .. 
		" ORDER BY placement"

	local results = MySQL.Sync.fetchAll(Query, {
		['@shootingrange_id'] = shootingrange_id
	})

	return results
end 


function deleteScores(forceDelte)
	if forceDelte == false then 
		MySQL.Async.fetchAll("SELECT count(*) as cnt FROM shootingranges_scores where date(score_created) <= date_sub(date(now()), INTERVAL @days day)", {['@days'] = Config.DeleteScoresDays},function(result)
			if result ~= nil then
				if result[1].cnt > 0 then 
					MySQL.Async.execute('truncate table shootingranges_scores', {})
				end 
			end
		end)
	else 
		MySQL.Async.execute('truncate table shootingranges_scores', {})
	end 	
end



function getOwnData(shootingrange_id, identifier)

	local retval = nil 

	local Query = "SELECT * from shootingranges_scores WHERE `shootingrange_id` = @shootingrange_id AND `identifier` = @identifier"


	local results = MySQL.Sync.fetchAll(Query, {
		['@shootingrange_id'] = shootingrange_id,
		['@identifier'] = identifier
	})

	if #results > 0 then
		retval = results[1]
	end 

	return retval
end 


function getPlayerNameDB(identifier)
	local retval = ''
	local Query = "SELECT * FROM `users` WHERE `identifier` = @identifier"

	local results = MySQL.Sync.fetchAll(Query, {
		['@identifier'] = identifier
	})

	if #results > 0 then
		retval = results[1].firstname .. " " .. results[1].lastname
	end 

	return retval
end 


function getReward(xPlayer, shootingrange_id, oldPosition, newPosition)
	local returnText = ""

	if oldPosition ~= newPosition then 
		local rewardText = ""
		local rewards = getCorrectShootingRangeRewards(shootingrange_id)

		returnText = Translations[Config.Locale].new_position .. newPosition
		
		if rewards[newPosition] ~= nil then 

			if rewards[newPosition].item.name ~= nil and rewards[newPosition].item.name ~= "" and rewards[newPosition].item.amount ~= nil and rewards[newPosition].item.amount > 0 then 
				xPlayer.addInventoryItem(rewards[newPosition].item.name, rewards[newPosition].item.amount)
				rewardText = rewardText .. "~g~" .. rewards[newPosition].item.amount .. "x " .. "~g~" .. rewards[newPosition].item.label
			end 

			if rewards[newPosition].money ~= nil and rewards[newPosition].money > 0 then 
				xPlayer.addAccountMoney(Config.AccountMoneyType, rewards[newPosition].money)
				if rewardText ~= "" then rewardText = rewardText .. Translations[Config.Locale].newline end
				rewardText = rewardText .. "~g~$" .. rewards[newPosition].money
			end 
		end 

		if rewardText ~= "" then 
			rewardText =  Translations[Config.Locale].newline .. Translations[Config.Locale].newline .. Translations[Config.Locale].youwonreward .. Translations[Config.Locale].newline .. rewardText
		end 

		returnText = returnText .. rewardText 
	end 

	return returnText
end 



function doNotifyOthers(source, text, playerCoods)
	TriggerClientEvent("myShootingRange:notifyOthers", -1 , source, text , playerCoods)
end 




-- here start creating database-table and change charset & collation
function handleDatabaseTable()

	local query = " ".. 
		"CREATE TABLE IF NOT EXISTS `shootingranges_scores` (" ..
		"`shootingrange_id` INT NOT NULL," ..
		"`identifier` VARCHAR(90) NOT NULL," ..
		"`placement` INT(11) NOT NULL DEFAULT 0," ..
		"`difficulty` VARCHAR(20) NOT NULL DEFAULT 'easy'," ..
		"`weapon` VARCHAR(90) NOT NULL DEFAULT ''," ..
		"`score` DOUBLE NOT NULL DEFAULT 0," ..
		"`score_created` TIMESTAMP," ..
		" PRIMARY KEY (`shootingrange_id`, `identifier`)" ..
		")"
	MySQL.Sync.execute(query)
	
	local tableCollation = getUsersTableCollation()
	
	if tableCollation~= nil and #tableCollation > 0 then 
		query = "ALTER TABLE shootingranges_scores DEFAULT CHARACTER SET @charset COLLATE @collation"
		MySQL.Sync.execute(query,{
			["@charset"] = tableCollation[1].CHARACTER_SET_NAME
			,["@collation"] = tableCollation[1].TABLE_COLLATION
		});
		
		
		local identifierCfg = getIdentifierConfigDB()
		if identifierCfg~= nil and #identifierCfg > 0 then 
		
			
		
		
			query = " " ..
				"ALTER TABLE shootingranges_scores " .. 
				"MODIFY `identifier` " .. identifierCfg[1].DATA_TYPE .. " CHARACTER SET " .. identifierCfg[1].CHARACTER_SET_NAME .. " COLLATE " .. identifierCfg[1].COLLATION_NAME .. " NOT NULL DEFAULT ''"
				
				
			--print(query)
				
				
				
			MySQL.Sync.execute(query,{});
		else
			print("ERROR while setting charset and collation of identifier-column!")
		end 
	else 
		print("ERROR while setting charset and collation of table!")
	end 
end


function getIdentifierConfigDB()
	local query = " " ..
		"SELECT  " ..
			"CHARACTER_SET_NAME " ..
			",COLLATION_NAME " ..
			",IF(CHARACTER_MAXIMUM_LENGTH is not null OR NUMERIC_PRECISION is not null, concat( " ..
				"DATA_TYPE, '(',IFNULL(CHARACTER_MAXIMUM_LENGTH, NUMERIC_PRECISION),')') " ..
				",DATA_TYPE " ..
			") as DATA_TYPE " ..
		"FROM information_schema.columns " ..
		"WHERE TABLE_SCHEMA = DATABASE() " ..
			"AND TABLE_NAME = 'users' " ..
			"AND COLUMN_NAME = 'identifier' "
			
	--print(query)
	return MySQL.Sync.fetchAll(query, {})	
end 



function getUsersTableCollation()
	local query = " " ..
		"SELECT " ..
		"cset.CHARACTER_SET_NAME " ..
		",TABLE_COLLATION " ..
		"FROM information_schema.tables " ..
			"LEFT JOIN information_schema.COLLATION_CHARACTER_SET_APPLICABILITY AS cset ON cset.COLLATION_NAME = tables.TABLE_COLLATION " ..
		" WHERE table_schema = DATABASE() " ..
			" AND table_name = 'users' "
	
	
	return MySQL.Sync.fetchAll(query, {})	
end 
