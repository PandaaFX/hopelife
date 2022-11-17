 >#  How the script works.
* If you don't put any limits to the sowing, players will be able to sow the seeds anywhere they want.
* When the plant is growing you can add water and fertilize to increase it.
* There is a timer of decaying if the plant has no more water left and you can set the timer as it suits your server.
* The plant quality will drop if it has no water or fertilize.
* The plant quality will raise if it has water and fertilize.
* The harvest amount will be set depending on the quality of the plant as soon as it is ready to harvest.
* The plant can give an extra item if you choose to. For example leafs or seeds etc.
* You can change a lot of things in config files such as how long will plant take to frow, how fast it will need water or fertilizing etc.
* The scrip is coded to be customizable and optimized as much as it can be. On both server and client side it will never get high ms values.
* An action by one player works synchronously on all players. Everyone can fertilize, watering, burn (you can disable it) and hervest any plant. It doesn't matter who planted it.
* Time processes according to the server time. Datas is saved in json file. Even if the server is restarted, this will not affect the old plants.
* Growth times are designed to be long for the script. You can make it longer or shorter depending on your server needs. 
* It is ready to use for esx and qb-core. For other frameworks you need to change server.lua settings depending on your framework. (You have to change funtions like; give and remove item, player citizen id etc...)
* All processes made by players are sent to the sendlog() function. If you want you can use this and add to your police dispatch system or your log system.
* The codes you may need to change are all not encrypted. You can configure it as you want. I will help you out if you want to edit from the encrypted part.
 
># CPU usage:
* On the client side, 0.00 to 0.01 if you are too far away for the markers to be visible. It can go up to 0.02 ms after +1000 plants but it won't go any higher. I tested up to +2500 plants. After an average of 1500 plants depending to the players system, the appearance of the markers may be shown a few seconds later than usual. For example, if you teleport next to a plant at +1500 plant, it may take up to 10.15 seconds untill the marker will be active, however if you go there by car you won't notice it.
* On the server side, i tested cpu ms on low system and results were between 0.01 to 0.02. ms won't increase even if the number of plants increases. 

># About config
* You can limit how many seeds a player can plant.
* You can limit how many seeds of one type a player can plant.
* You can limit how many seeds of different types a player can plant.
  For each plant; 
* You can select where players can or can't plant the seed.
* You can select if players can burn other players plants or not.
* You can select how many items will be given when harvesting.
* You can select how many times it will need to be fertilized and watered until harvesting for better quality.
* You can select how much quality will increase/decrease if the plant has/has not water and fertilize.
* You can select if it will decay because lack of water or not.
* You can select if it will decay or won't decay after becoming ready for harvesting. There are more settings like this from the config.

># Things you should know.
* You need to add the names of the items in the config to your framework. The names of the items that need to be added are printed to the server console as information when the script is started.
* Weed, poppy(opium), tobacco, dragon fruit, strawberry, mushroom are allready added and ready for use in the config file.
* You can adjust all the settings of the plants as you wish.
* You can add or remove any plant with a prop as you want.
* Plant data is saved to json file at certain periods of time. If you want, you can manually save with "saveplants" command from the server console. Advised to save manually before shutting down the server.
* if the ui is bugged and you can't turn it off. You can close it using the command "/closeplantui".
* I used mythic_notify for the notification system. However, you can chance the notification system by simply changing the function below.
* You can easily change the language settings from locale.lua.
* There is no scenario in this script where players will buy seeds or sell their harvests. You should set this up on your own. You can use my FREE scenario if you want to use;