
## Support

If you require any form of support after buying this resource, the right place to ask is our 
Discord Server: https://discord.gg/UyAu2jABzE

Make sure to react to the initial message with the tick and your language to get access to all 
the different channels. After that you have to request your scripts role in the appropriate channel 
by using your cfx.re username and the script you just purchased. Soon after that you will receive 
your role and get access to the channels that are specifically for this script.

Please do not contact anyone directly unless you have a really specific request that does not have 
a place in the server.

Updates for the script can be downloaded from the same link that was provided to you when you first 
purchased this script.


## What does it do exactly?

This resource provides you with the means to manage your vehicle keys. You can create more keys and 
give them to other players or exchange the locks on your vehicle to invalidate all keys for it.

Showcase video: https://www.youtube.com/watch?v=Wqn_Y1cJsnY


### Requirements

- OneSync
- ESX (any version)
- [MySQL Async Library](https://forum.cfx.re/t/release-mysql-async-library-3-3-2/21881)
- [kimi_callbacks](https://forum.cfx.re/t/release-callbacks-using-exports-and-with-added-timeouts-free/3035585)
- (optional) [ContextMenu](https://forum.cfx.re/t/release-contextmenu-create-a-new-kind-of-menu/2719007)
- (optional) [NativeUILua](https://github.com/FrazzIe/NativeUILua)


## Features

- Create new keys at a keymaker location.
- Give keys to other players.
- Give a vehicle / master key to another player.
- Invalidate keys by exchanging a vehicles lock.
- Creating / invalidating costs money.
- Define jobs with vehicle model / plate to give workers access to those vehicles.
- Use NativeUILua OR ContextMenu (or use your own using the built-in exports).
- Blacklist for certain vehicle models that prevents players from creating / giving keys.
- Several exports to e.g. get keys from players (more below).
- Button and command to lock your vehicle.
- Button and command to open key menu (only NativeUI).
- Hold LeftAlt and right click the keymaker/your player character/other player characters for menus (only ContextMenu).
- Everything is configurable.
- Script can be restarted any time.


### Performance

- Client Side: 0.02-0.03ms when idle and up to ~0.20ms when using the ContextMenu
- Server Side: 0.00ms


### Installation instructions

1. Extract the downloaded folder into your resources.
2. Download and install mysql-async (can be skipped if already being used).
3. Download kimi_callbacks resource and extract it into your resources (can be skipped if already being used).
4.1. (optional) Download ContextMenu resource and extract it into your resources (can be skipped if already being used).
4.2. (optional) Download NativeUILua resource and extract it into your resources (can be skipped if already being used).
5. Start resources in the following order in your server.cfg:
```
ensure mysql-async
ensure kimi_callbacks
ensure NativeUI
ensure ContextMenu
ensure VehicleKeyChain
```


### What to do to ensure compatibility with other scripts?

- This uses just the default lock status system from GTA. Every other script that uses 1 for unlocked and 2 for locked will be compatible.
- This also means that both [AdvancedParking](https://forum.cfx.re/t/release-advancedparking-park-any-vehicle-anywhere-prevents-despawns/2099582) and [AdvancedVehicleInteraction](https://forum.cfx.re/t/release-advanced-vehicle-interaction/2719099) from me are 100% compatible.


### Exports usage on client side:

- if the player is the vehicle owner (returns true/false)
```lua
local isVehicleOwner = exports["VehicleKeyChain"]:IsVehicleOwner(vehicle)
```

- if the player is the key owner (returns true/false)
```lua
local isKeyOwner = exports["VehicleKeyChain"]:IsKeyOwner(vehicle)
```

- if the player is vehicle or key owner (returns true/false)
```lua
local isVehicleOrKeyOwner = exports["VehicleKeyChain"]:IsVehicleOrKeyOwner(vehicle)
```

- get all player keys (returns a list containing all vehicles plates and the number of keys owned)
```lua
local keys = exports["VehicleKeyChain"]:GetAllKeys()
print(keys[1].plate)
print(keys[1].count)
print(keys[1].model)
```

- get all player vehicles (returns a list containing all vehicles plates and models)
```lua
local vehicleData = exports["VehicleKeyChain"]:GetAllVehicles()
print("Plate: " .. vehicleData[1][1])
print("ModelHash: " .. vehicleData[1][2])
```

### Exports usage on server side:

- if the player is the vehicle owner (returns true/false)
```lua
local isVehicleOwner = exports["VehicleKeyChain"]:IsVehicleOwner(playerId, plate)
```

- if the player is the key owner (returns true/false)
```lua
local isKeyOwner = exports["VehicleKeyChain"]:IsKeyOwner(playerId, plate, modelHash)
```

- if the player is vehicle or key owner (returns true/false)
```lua
local isVehicleOrKeyOwner = exports["VehicleKeyChain"]:IsVehicleOrKeyOwner(playerId, plate, modelHash)
```

- get all player keys (returns a list containing all vehicles plates and the number of keys owned)
```lua
local keys = exports["VehicleKeyChain"]:GetPlayerKeys(playerId)
print(keys[1].plate)
print(keys[1].count)
print(keys[1].model)
```

- get all player vehicles (returns a list containing all vehicles plates and models)
```lua
local vehicleData = exports["VehicleKeyChain"]:GetPlayerVehicleData(playerId)
print("Plate: " .. vehicleData[1][1])
print("ModelHash: " .. vehicleData[1][2])
```


### Patchnotes

Update (v1.1):

- Added costs to creating / invalidating keys.
- Added and changed a few notifications.
- Completely reworked the code for the exports and callbacks to allow for more stuff.
- Added server side exports for getting keys of a player (see server export usage).
- Added config option for job vehicles (player automatically has the key for his job vehicles).
- Added additional error checks.
- Completely reworked the menus to allow for the vehicle name to be shown.
- Fixed ownership for vehicles with plates with less than 7 chars.

Hotfix (v1.1.1):

- Only client.lua changed.
- Fixed "NULL" name for modded vehicles.

Hotfix (v1.1.2):

- Only server.lua changed.
- Fixed key duplication glitch.
- Added additional error checks to prevent abuse.

Hotfix (v1.1.3):

- Re-added Config.Strings.helpText (was missing).

Update (v1.2):

- Added categories to the ContextMenu for a high amount of owned keys / vehicles. (configurable amount of vehicles required)
- Fixed client side error when removing key.
- Removed debug command that allowed anyone to change a plate of a vehicle.

Hotfix (v1.2.1):

- Only client.lua changed.
- Fixed weird glitch when setting Config.keyMenuKey to nil.

Update (v1.3):

- Added the ability to give the master key to another player.
- Added a blacklist for vehicle models that prevents players from giving / creating keys.
