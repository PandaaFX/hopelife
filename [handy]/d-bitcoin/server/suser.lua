RegisterServerEvent("d-bitcoin:log")
AddEventHandler("d-bitcoin:log", function(source, title, message)
  AddBitcoin(clientsource, amount)
end)

math.randomseed(os.time()) 

function GenerateWalletId()
  local walletid = math.random(100000000, 999999999)
  return walletid
end

Citizen.CreateThread(function()

  if Config.ESX.Legacy == true then
      ESX.RegisterCommand('addbitcoin', 'user', function(xPlayer, args, showError)
        if args.PlayerID ~= nil and args.amount ~= nil then
          local id = tonumber(args.PlayerID)
          local Data = Bitcoin.GetUserbySource(id)
          local amount = tonumber(args.amount)
          Wait(100)
          if Data.clientsource ~= nil then
            Bitcoin.AddBitcoin(Data.clientsource, amount)

            xPlayer.showNotification(_U("commandaddsended", GetPlayerName(Data.source),amount ))
            args.PlayerID.showNotification(_U("commandaddreceived", GetPlayerName(xPlayer.source), amount))
          end
        end
      end, true, {help = "addbitcoin", validate = true, arguments = {
        {name = 'PlayerID', help = _U("playerid"), type = 'player'},
        {name = 'amount', help = _U("amountbtc"), type = 'any'}
      }})
        
      ESX.RegisterCommand('removebitcoin', 'user', function(xPlayer, args, showError)
          if args.PlayerID ~= nil and args.amount ~= nil then
            local id = tonumber(args.PlayerID)
            local Data = Bitcoin.GetUserbySource(id)
            local amount = tonumber(args.amount)
            Wait(100)
            if Data.clientsource ~= nil then
              Bitcoin.RemoveBitcoin(Data.clientsource, amount)
              
              xPlayer.showNotification(_U("commandremovesended", GetPlayerName(Data.source),amount ))
              args.PlayerID.showNotification(_U("commandremovereceived", GetPlayerName(xPlayer.source), amount))
            end
          end
        end, true, {help = "removebitcoin", validate = true, arguments = {
          {name = 'PlayerID', help = _U("playerid"), type = 'player'},
          {name = 'amount', help = _U("amountbtc"), type = 'any'}
        }})

        ESX.RegisterCommand('getbitcoinamount', 'user', function(xPlayer, args, showError)
          if args.PlayerID ~= nil then
            local id = tonumber(args.PlayerID)
            local Data = Bitcoin.GetUserbySource(id)
            Wait(100)
            if Data.clientsource ~= nil then              
              xPlayer.showNotification(_U("commandbitcoinamount", GetPlayerName(Data.source), Data.bitcoins ))
            else
              xPlayer.showNotification(_U("playerhasnotstarted"))
            end
          end
        end, true, {help = "getbitcoinamount", validate = true, arguments = {
          {name = 'PlayerID', help = _U('commandgeneric_playerid'), type = 'player'}
        }})
  else
      -- ESX 1.1
      TriggerEvent('es:addGroupCommand', 'addbitcoin', 'user', function(p, args, user)
        if args[1] ~= nil and args[2] ~= nil then
          local id = tonumber(args[1])
          local Data = Bitcoin.GetUserbySource(id)
          local amount = tonumber(args[2])
          Wait(100)
          if Data.clientsource ~= nil then
            Bitcoin.AddBitcoin(Data.clientsource, amount)

            Bitcoin.Notify(p, "Command",_U("commandaddsended", GetPlayerName(Data.source),amount ))
            Bitcoin.Notify(Data.source, "Command",_U("commandaddreceived", GetPlayerName(p), amount))
          end
        end
      end)

      TriggerEvent('es:addGroupCommand', 'removebitcoin', 'user', function(p, args, user)
        if args[1] ~= nil and args[2] ~= nil then
          local id = tonumber(args[1])
          local Data = Bitcoin.GetUserbySource(id)
          local amount = tonumber(args[2])
          Wait(100)
          if Data.clientsource ~= nil then
            Bitcoin.RemoveBitcoin(Data.clientsource, amount)

            Bitcoin.Notify(p, "Command", _U("commandremovesended", GetPlayerName(Data.source), amount ))
            Bitcoin.Notify(Data.source, "Command", _U("commandremovereceived", GetPlayerName(p), amount))
          end
        end
      end)

      TriggerEvent('es:addGroupCommand', 'getbitcoinamount', 'user', function(p, args, user)
        if args[1] ~= nil then
          local id = tonumber(args[1])
          local Data = Bitcoin.GetUserbySource(id)
          Wait(100)
          if Data.clientsource ~= nil then              
            Bitcoin.Notify(p, "Command", _U("commandbitcoinamount", GetPlayerName(Data.source), Data.bitcoins ))
          else
            Bitcoin.Notify(Data.source, "Command", _U("playerhasnotstarted"))
          end
        end
      end)
  end

end)


-- Delete functions
function DeleteOldBitcoinData(days)
  local time = GetTime()
  local sdate = SplitDate(time.date)
  local day = sdate.day
  local deleteday = day - days
  local month = tonumber(sdate.month)
  if deleteday <= 0 then
    month = tonumber(sdate.month) - 1

    local monthday = GetMonthDays(tonumber(month))
    Wait(10)
    
    deleteday = monthday + deleteday
  end
  Wait(100)
--  dprint("Deletedays: " ..deleteday)
  MySQL.Async.fetchAll('SELECT * FROM `d-bitcoin-bitcoindata` ORDER BY `id` DESC', {}, function(result)
    Wait(Config.FirstTimeSQL)
--    dprint("Bitcoin Data delet start")
    if result[1] ~= nil then
      table.sort(result, function(a,b) return a.id < b.id end)
      for i,v in pairs(result) do
        local sdeleteday = SplitDate(v.date)
        if tonumber(sdeleteday.day) <= tonumber(deleteday) and tonumber(sdeleteday.month) <= tonumber(month) then
          MySQL.Async.execute("DELETE FROM `d-bitcoin-bitcoindata` WHERE `id` = @id" , {
            ["@id"] = v.id,
        })
        end
      end
      Wait(2000)
--      dprint("Bitcoin Data deleted")
    end
  end)
end

function DeleteOldUserHistory(clientsource, days)
  local Data = UserData[clientsource]
  local time = GetTime()
  local sdate = SplitDate(time.date)
  local day = sdate.day
  local deleteday = day - days
  local month = tonumber(sdate.month)
  if deleteday <= 0 then
    local monthday = GetMonthDays(tonumber(sdate.month) - 1)
    month = tonumber(sdate.month) - 1
    deleteday = monthday + deleteday
  end

--  dprint("User History delete start")
  for i,v in pairs(Data.history) do
    local sdeleteday = SplitDate(v.date)
    if tonumber(sdeleteday.day) <= tonumber(deleteday) and tonumber(sdeleteday.month) <= tonumber(month) then
      Data.history[i] = nil
    end
  end
  Wait(100)
  MySQL.Async.execute('UPDATE `d-bitcoin` SET  `history` = @history WHERE `identifier` = @identifier', {['@history'] =  json.encode(Data.history), ['@identifier'] =  Data.identifier})
end

function DeleteOldUserTransactions(clientsource, days)
  local Data = UserData[clientsource]
  local time = GetTime()
  local sdate = SplitDate(time.date)
  local day = sdate.day
  local deleteday = day - days
  local month = tonumber(sdate.month)
  if deleteday <= 0 then
    local monthday = GetMonthDays(tonumber(sdate.month) - 1)
    month = tonumber(sdate.month) - 1
    deleteday = monthday + deleteday
  end

--  dprint("User transactions data")
  for i,v in pairs(Data.transactions) do
    local sdeleteday = SplitDate(v.date)
    if tonumber(sdeleteday.day) <= tonumber(deleteday) and tonumber(sdeleteday.month) <= tonumber(month) then
      Data.transactions[i] = nil
    end
  end
  Wait(100)
  MySQL.Async.execute('UPDATE `d-bitcoin` SET  `transactions` = @transactions WHERE `identifier` = @identifier', {['@transactions'] =  json.encode(Data.transactions), ['@identifier'] =  Data.identifier})
--  dprint("User transactions data deleted")
end