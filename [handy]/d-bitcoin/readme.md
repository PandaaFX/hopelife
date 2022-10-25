<IMPORTANT>
VERSION 0.1
Join my Discord and read the messages in the #verify-your-payment channel
You received your transactionid in the email of tebex.

Discord Link  > https://discord.gg/tngc5yN6mf

<INSTALLATION>
1. Drag & Drop this resource in your resource folder
2. Insert the sql.sql and item.sql in your database
3. Configure everything in the config.lua file
4. start the resource directly after es_extented
5. If you have the D-Phone ( https://store.deun.xyz/package/4865564 )
    1. Download the latest version from keymaster.fivem.net
    2. Enable Config.bitcoin in the config of the d-phone
6. If you have Problems check the troubleshooting channel in our discord or write in bug-report

<Support>
If there are any bugs then report these on my Discord > https://discord.gg/tngc5yN6mf

 <RIGHTS>
 You are not allowed to sell this script. 
 CREATOR: deun.xyz

 <DOCS>

 Add bitcoin to your script
```lua
 Bitcoin = nil

TriggerEvent("d-bitcoin:getfunctions", function(obj) Bitcoin = obj end)

```

All Functions

Get clientsource by source or by walletid
```lua
-- by Source ( this one uses way less performance )
local Data = Bitcoin.GetUserbySource(source)
Wait(10)
if Data ~= nil then
    local clientsource = Data.clientsource
    -- Your code
end

-- by Walletid
local clientsource = Bitcoin.GetUserbyWallet(walletid)
Wait(10)
if Data ~= nil then
    local clientsource = Data.clientsource
    -- Your code
end

```

Notication
```lua
Bitcoin.Notify(source, title, message, icon, color, length)
```

Check if user has enough bitcoin
```lua
Bitcoin.HasEnoughBitcoin(clientsource, amount)

-- Example 
    local clientsource = Bitcoin.GetUserbySource(source)
    Wait(10)
    local amount = tonumber(amount)

  if Bitcoin.HasEnoughBitcoin(clientsource, amount) then
    Bitcoin.AddBitcoinByWalletid(receiverwallet, amount, clientsource)
  end
```

Add Bitcoin
```lua
Bitcoin.AddBitcoin(clientsource, amount)
-- For this the user has to be online
-- Example 
    local clientsource = Bitcoin.GetUserbySource(source)

    if price <= accountMoney then
        xPlayer.removeAccountMoney('bank', price)
        Bitcoin.AddBitcoinHistory(clientsource, _U("hmarket"), Data.walletid,  amount, true, false)
        Bitcoin.AddBitcoin(clientsource, amount)
        Bitcoin.Notify(_source, _U("hmarket"),_U("boughtbitcoins", amount, price), Config.Market, "green", 5000)

    else
        local needmoney = price - accountMoney
        Bitcoin.Notify(_source, _U("hmarket"),_U("notenoughmoney", needmoney), Config.Market, "red", 5000)
    end
-- or
-- For this the user can be offline
Bitcoin.AddBitcoinByWalletid(receiverwallerid, amount, senderclientsource)
-- Example 
    local clientsource = Bitcoin.GetUserbySource(source)
    local amount = tonumber(amount)

    if Bitcoin.HasEnoughBitcoin(clientsource, amount) then
        Bitcoin.AddBitcoinByWalletid(receiverwallet, amount, clientsource)
    end

```

Remove Bitcoin
```lua
Bitcoin.RemoveBitcoin(clientsource, amount)
-- For this the user has to be online
-- Example 
    local clientsource = Bitcoin.GetUserbySource(source)

    if price <= accountMoney then
        xPlayer.removeAccountMoney('bank', price)
        Bitcoin.AddBitcoinHistory(clientsource, _U("hmarket"), Data.walletid,  amount, true, false)
        Bitcoin.RemoveBitcoin(clientsource, amount)
        Bitcoin.Notify(_source, _U("hmarket"),_U("boughtbitcoins", amount, price), Config.Market, "green", 5000)

    else
        local needmoney = price - accountMoney
        Bitcoin.Notify(_source, _U("hmarket"),_U("notenoughmoney", needmoney), Config.Market, "red", 5000)
    end
-- or
-- For this the user can be offline
Bitcoin.RemoveBitcoinByWalletid(receiverwallerid, amount, senderclientsource)
-- Example 
    local clientsource = Bitcoin.GetUserbySource(source)
    local amount = tonumber(amount)

    if Bitcoin.HasEnoughBitcoin(clientsource, amount) then
        Bitcoin.RemoveBitcoinByWalletid(receiverwallet, amount, clientsource)
    end

```

Add a Entry is the user history tab
```lua
Bitcoin.AddBitcoinHistory(clientsource, senderwallet, receiverwallet, amount2, save, getnotifed)
-- For this the user has to be online
-- Example 
    local clientsource = Bitcoin.GetUserbySource(source)

    if price <= accountMoney then
        xPlayer.removeAccountMoney('bank', price)
        Bitcoin.AddBitcoinHistory(clientsource, _U("hmarket"), Data.walletid,  amount, true, false)
        Bitcoin.RemoveBitcoin(clientsource, amount)
        Bitcoin.Notify(_source, _U("hmarket"),_U("boughtbitcoins", amount, price), Config.Market, "green", 5000)

    else
        local needmoney = price - accountMoney
        Bitcoin.Notify(_source, _U("hmarket"),_U("notenoughmoney", needmoney), Config.Market, "red", 5000)
    end

```l