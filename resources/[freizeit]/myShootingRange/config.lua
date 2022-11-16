Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  }

Config 			= {}
Config.Locale 	= 'de'

--[[
If you use a MySQL Version smaller 8.0 or MariaDB smaller 10.2 then set this to true
]]--
Config.UseOldMySQL = false 

Config.MarkerDrawDistance = 20.0
Config.NotifyOthersDistance = 20.0
Config.NotificationDistance = 1.0
Config.NotificationScoreListDistance = 1.0
Config.HotKeyOpen = "E"
Config.HotKeyClose = 202 --backspace
Config.HotKeyStart = 191 -- enter
Config.AccountMoneyType = "money"
Config.AllowRentWeapon = false
Config.CountDownTimeSek = 3

Config.DeleteScoresDays = 7


Config.AllowedWeapons = {
	{name = "weapon_pistol", rentPrice = 50}
	,{name = "weapon_appistol", rentPrice = 100}
	,{name = "weapon_smg", rentPrice = 200}
	,{name = "weapon_pumpshotgun", rentPrice = 200}
	,{name = "weapon_assaultrifle", rentPrice = 250}
}

Config.Points = {
	["perfect"] = 20
	,["very_good"] = 10
	,["good"] = 5
	,["ok"] = 2
	,["notgood"] = 1
}



Config.notifications = {
	DefaultFiveM = true,
	BtwLouis = false,
	Custom = false
  }


Config.ShootingRanges = {
	{
		id = 1
		,pos = {
			{x = 13.54, y = -1097.21, z = 29.83}
			,{x = 9.34, y = -1095.84, z = 29.83}
			,{x = 11.22, y = -1096.57, z = 29.83}
			,{x = 15.90, y = -1098.27, z = 29.83}
			,{x = 17.73, y = -1098.88, z = 29.83}
		}
		,bestlistPos = {x = 6.56, y = -1100.25, z = 29.83}
		,price = 50
		,targets = {
			{x = 22.40, y = -1081.89, z = 29.79, heading = 166.0}
			,{x = 20.88, y = -1081.50, z = 29.79, heading = 166.0}
			,{x = 16.82, y = -1080.15, z = 29.79, heading = 166.0}
			,{x = 15.44, y = -1079.68, z = 29.79, heading = 166.0}
			,{x = 17.85, y = -1075.30, z = 29.79, heading = 166.0}
			,{x = 24.11, y = -1077.11, z = 29.79, heading = 166.0}
			,{x = 27.76, y = -1072.65, z = 29.79, heading = 166.0}
			,{x = 22.56, y = -1070.67, z = 29.79, heading = 166.0}
			,{x = 18.15, y = -1069.15, z = 29.79, heading = 166.0}
		}		
		,rewards = {
			{item = {name = '', label = "",amount = 10}, money = 5000}
			,{item = {name = "", label="", amount = 1}, money = 2500}
			,{item = {name = "", label="", amount = 1}, money = 1000}
		}
	}
	,{
		id = 2
		,pos = {
			{x = 821.56, y = -2163.70, z = 29.83}
		}
		,bestlistPos = {x = 827.07, y = -2158.34, z = 29.83}
		,price = 50
		,targets = {
			{x = 818.33, y = -2181.11, z = 29.61, heading = 356.0}
			,{x = 824.54, y = -2180.92, z = 29.61, heading = 356.0}
			,{x = 819.88, y = -2180.75, z = 29.61, heading = 356.0}
			,{x = 825.90, y = -2180.89, z = 29.61, heading = 356.0}
			,{x = 825.41, y = -2188.65, z = 29.61, heading = 356.0}
			,{x = 817.89, y = -2187.92, z = 29.61, heading = 356.0}
			,{x = 822.18, y = -2191.84, z = 29.61, heading = 356.0}
			,{x = 816.57, y = -2191.91, z = 29.61, heading = 356.0}
			,{x = 826.96, y = -2191.75, z = 29.61, heading = 356.0}	
		}
		,rewards = {
			{item = {name = '', label = "",amount = 10}, money = 5000}
			,{item = {name = "", label="", amount = 1}, money = 2500}
			,{item = {name = "", label="", amount = 1}, money = 1000}
		}
	}
}

Config.Difficulties = {
	{id = 'easy', Translation = "difficulty_easy" , time = 5000, pointMultifier = 1, pointsScoreboard = 1}
	,{id = 'normal', Translation = "difficulty_normal" , time = 2500, pointMultifier = 2, pointsScoreboard = 2}
	,{id = 'hard', Translation = "difficulty_hard" , time = 1250, pointMultifier = 3, pointsScoreboard = 3}
	,{id = 'harder', Translation = "difficulty_harder" , time = 1000, pointMultifier = 4, pointsScoreboard = 4}
	,{id = 'impossible', Translation = "difficulty_impossible" , time = 800, pointMultifier = 5, pointsScoreboard = 5}
}

Config.TargetCounts = {
	10
	,12
	,14
	,16
	,18
	,20
}



Translations = {
	["de"] = {
		["shooting_range"] = "Schießstand"
		,["start"] = "Starten"
		,["runrangestart"] = "Los!"
		,["difficulty_easy"] = "Einfach"
		,["difficulty_normal"] = "Normal"
		,["difficulty_hard"] = "Schwer"
		,["difficulty_harder"] = "Schwerer"
		,["difficulty_impossible"] = "Unmöglich"
		,["difficulty"] = "Schwierigkeit"
		,["targetcount"] = "Anzahl Ziele"
		,["weaponlist"] = "Waffe"
		,["notification_openmenu"] = "Drücke ~INPUT_CONTEXT~ um an den ~y~Schießstand~s~ zu gehen."
		,["notification_openmenu_bestlist"] = "Drücke ~INPUT_CONTEXT~ um an die ~y~Bestenliste~s~ zu öffnen."
		,["left_zone"] = "Schusszone verlassen.~n~Schussübung beendet!"
		,["left_zone_others"] = " hat Schusszone verlassen.~n~Schussübung beendet!"

		,["points"] = "Punkte"
		,["new_hightscore"] = "Neuer persönlicher Rekord.~n~Score: "
		,["hightscore_not_beaten"] = "Persönlichen Rekord nicht überboten.~n~Scores (Alt/Neu): "
		,["cannot_pay"] = "Du hast zu wenig Geld"
		,["score_result_others"] = " hat folgenden Score erzielt: "
		,["scoreis0"] = "Keinen Score erzielt"
		,["others_noscore"] = " hat keinen Score erzielt"
		,["new_position"] = "Du bist jetzt auf Platz "
		,["youwonreward"] = "Du hast gewonnen:"
		,["newline"] = "~n~"
	}
	,["en"] = {
		["shooting_range"] = "Shooting range"
		,["start"] = "Start"
		,["runrangestart"] = "Go!"
		,["difficulty_easy"] = "~g~Easy"
		,["difficulty_normal"] = "~y~Normal"
		,["difficulty_hard"] = "~o~Hard"
		,["difficulty_harder"] = "~r~Harder"
		,["difficulty_impossible"] = "~p~Impossible"
		,["difficulty"] = "Difficulty"
		,["targetcount"] = "Number of targets"
		,["weaponlist"] = "Weapon"
		,["notification_openmenu"] = "Press ~INPUT_CONTEXT~ to go to the ~y~shooting range~s~."
		,["notification_openmenu_bestlist"] = "Press ~INPUT_CONTEXT~ to open the ~y~leaderboard~s~."
		,["left_zone"] = "Exit shooting zone.~n~Shooting exercise stopped!"
		,["left_zone_others"] = " has left the shooting zone.~n~Shooting exercise stopped!"
		,["points"] = "Points"
		,["new_hightscore"] = "New personal record.~n~~y~Score~s~: "
		,["hightscore_not_beaten"] = "Personal record not beaten. ~n~Scores (Old/New): "
		,["cannot_pay"] = "You don't have enough money"
		,["score_result_others"] = " has achieved the following score: "
		,["scoreis0"] = "No score achieved"
		,["others_noscore"] = " has no score achieved"
		,["new_position"] = "You are now on place ~h~"
		,["newline"] = "~n~"
		,["youwonreward"] = "You won:"
	}
}