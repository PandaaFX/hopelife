# m-Halloween script for QB & ESX

| If you are intested in recieving updates join the community on **[Discord](https://discord.gg/marcinhu)**! |

# About

    This script will allow players to knock on house doors and get rewards. A zombie can also come out and you'll have to run away or he'll attack you. 
    Also whenever the event starts, it will spawn + 50 pumpkins scattered around the city to be harvested. 
    Finally, there is a hidden NPC who exchange pumpkins for valuable items.

# Features

- 0.00ms
- Optimized
- Full configurable
- 74 Houses available to knock.
- 54 Spots available on city to collect pumpkins.
- NPC trading pumpkins for itens.
- You can enable the event all restart's or with command.
- You can reset all doors.
- You can enable/stop the event with commands.

# Installation [QBCore]
    
**qb-core/shared/items.lua:**

    ['pumpkin']       	= {['name'] = 'pumpkin',      	['label'] = 'Pumpkin',      		['weight'] = 0,         ['type'] = 'item',         ['image'] = 'pumpkin.png',                 ['unique'] = false,     ['useable'] = true,     ['shouldClose'] = true,    ['combinable'] = nil,   ['description'] = ''},

**interact-sound/client/html/sounds**
    
    Put the file available on folder Sounds


# Installation [ESX]

**interact-sound/client/html/sounds**
    
    Put the file available on folder Sounds

- Run the *sql_ESX.sql*


# Requirements

**QBCore**
- qb-target
- qb-menu

**ESX**
- The script works with ox_inventory.
- qtarget
- mythic_progbar