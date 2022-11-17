
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

This resource provides you with the means to locate and track vehicles via blips on the map. This 
is mainly meant as a complimentary resource for any sort of parking script, as vehicles that are 
not in scope of any player simply cannot be tracked at all.

This is fully compatible with [AdvancedParking](https://forum.cfx.re/t/release-advancedparking-prevents-despawns/2099582) 
out of the box but can also be changed to work with other parking scripts.
If you are using other parking scripts, I can help you with integrating it as well.

If you are not using a parking script and you are not spawning your vehicles on server side, the 
blips will disappear when the player is too far away, as the vehicle might be unloaded by the 
engine itself. This is why it is highly recommended to use e.g. AdvancedParking, as that script 
will always return a position of a saved vehicle!

Showcase video: https://www.youtube.com/watch?v=Yg4H8DYa9r8


### Requirements

- OneSync
- [kimi_callbacks](https://forum.cfx.re/t/release-callbacks-using-exports-and-with-added-timeouts-free/3035585)
- (optional but highly recommended for fully working tracking) [AdvancedParking](https://forum.cfx.re/t/release-advancedparking-prevents-despawns/2099582)
- (optional) ESX (any version)
- (needed when using ESX) [NativeUILua](https://github.com/FrazzIe/NativeUILua)


## Features

- Serverside exports for tracking vehicles.
- Menu for tracking owned vehicles (ESX + NativeUI necessary). (configurable command and/or button)
- Tracking blips are updated every 2.5 seconds or in realtime when the vehicle is nearby 
  (configurable).
- Script can be restarted any time (trackers have to be re-enabled when doing so).

## Planned Features

- Input window for police, so they can track any vehicle.


### Performance

- Client Side: idle 0.00ms, tracking 3 vehicles: 0.01-0.04ms (depends on if they are updated client or serverside)
- Server Side: idle 0.00ms, tracking 3 vehicles: 0.01-0.02ms (depends on if they are updated client or serverside)


### Installation instructions

1. Extract the downloaded folder into your resources.
2. Download kimi_callbacks resource and extract it into your resources (can be skipped if already being used).
3. (optional) Download AdvancedParking resource and extract it into your resources.
4. (optional) Download NativeUILua resource and extract it into your resources.
5. Start resources in the following order in your server.cfg:
```
ensure kimi_callbacks
ensure NativeUI
ensure AdvancedParking
ensure VehicleTracker
```


### Exports usage on server side:

- start tracking a vehicle; returns true if successful, false if not
```lua
local success = exports["VehicleTracker"]:StartTracker(playerServerId, plate)
```

- stop tracking a vehicle; returns true if successful, false if not
```lua
local success = exports["VehicleTracker"]:StopTracker(playerServerId, plate)
```


### Patchnotes

Update (v1.1):
- Added configurable button to open the menu (defaults to nothing).
- Fixed a rare occuring error that could crash the script.
