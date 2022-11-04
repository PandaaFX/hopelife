# rcore_clothes

### Installation

- rename folder to rcore_clothes
- if you have changes ESX events change them in config
- ensure rcore_clothes

### Troubleshoot

if you see error:  Bad binary format or syntax error near </1>

Read this guide: 
https://documentation.rcore.cz/cfx-auth-system/error-syntax-error-near-less-than-1-greater-than

i see "you lack the entitelment to run this resource"
Follow thid guide: https://documentation.rcore.cz/cfx-auth-system/you-lack-the-entitlement

### i cant run it on qbcore, what am i missing???

First and last step is to add this code into "qb-clothing/client/main.lua"<br>
**Warning**: This event handler has to be on bottom of the file main.lua otherwise it wont work!
```LUA
AddEventHandler("skinchanger:getSkin",function(cb)
    cb(skinData)
end)
```

### How to open stored clothes

```LUA
CreateThread(function()
    TriggerEvent("rcore_clothes:openOutfits")
end)
```

### Edit notifications

You can change notification for your that you want you can change it in two files
- client/extend/notify.lua
- server/extend/notify.lua

### Contact
discord: 
email: info@rcore.cz

How to open shop via event

```LUA
CreateThread(function()
    local section =
    {
        pos = GetEntityCoords(PlayerPedId()),
        label = '👞',
        help = 'Press ~INPUT_CONTEXT~ to open shop menu',
        components = {
            {
                label = 'Shoes',
                name = 'shoes_1',
                from = 1,
                to = 88,
                current = 1,
                price = 150,
                reset = {
                    'shoes_2'
                },
            },
            {
                label = 'Shoes color',
                name = 'shoes_2',
                from = 0,
                to = 20,
                current = 1,
                price = 50,
            }
        },
        cam = {
            offset = {
                x = -0.5,
                y = 1.0,
                z = -0.5
            },
            pointOffset = {
                x = 0,
                y = 0,
                z = -0.8
            },
            taskHeading = 354.66
        },
        size = 1.2, --Default 1
        renderDistance = 10.0,
    }

    TriggerEvent("rcore_clothes:openMenu", section, 1, 1, false, true)
    --TriggerEvent("rcore_clothes:openMenu", section, sectionIndex, shopIndex, paid, saving)
end)
```
