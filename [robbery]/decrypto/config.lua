Config = {}
Translation = {}
Config.Locale = 'de'
Config.MinWithdrawl = 40000 -- $ received minimum for successful hack
Config.MaxWithdrawal = 55000 -- $ received maximum for successful hack
Config.Account = "black_money" -- money | black_money | bank
Config.MingameBase = 10 -- 10 for decimal or 16 for hexadecimal
Config.MinigameTimeLimit = 300 -- time limit in seconds
Config.MingameAttemptLimit = 50 -- number of guesses allowed
Config.AddStress = 5 --% stress gain from hacking
Config.Options = {
    ATM = true   
}

Config.ATMModels = {
    `prop_atm_01`, -- 20 on map
    `prop_atm_02`, -- 37 on map
    `prop_atm_03`, -- 30 on map
    `prop_fleeca_atm` -- 4 on map
}

Config.ATMModelsString = {
    "prop_atm_01", -- 20 on map
    "prop_atm_02", -- 37 on map
    "prop_atm_03", -- 30 on map
    "prop_fleeca_atm" -- 4 on map
}

Config.Chance = 0.10 -- Chance of police alert on successful hack. Note: police are always alerted on failed hack.
Config.AlarmTime = 60
Config.useSound = true 
Translation = {
    ['de'] = {
        ['blip_text'] = 'ATM überfallen',
        ['infobar_start'] = 'Drücke ~r~G~s~, um den Bankautomaten zu überfallen',
        ['recently_robbed'] = '~r~Du hast den Automaten kürzlich erst ausgeraubt!',
        ['step_1'] = 'Du beginnst das Gehäuse des Automaten kaputt zu schlagen',
        ['step_2'] = 'Entferne nun die Kabel der Alarmanlage',
        ['step_3'] = 'Die Alarmanlage ist deaktiviert! Nun nur noch die Farbkassette abklemmen.',
        ['step_4'] = 'Die Geldkasette ist geknackt. Geld wird aus dem Automaten entnommen.',
        ['got_money'] = '~y~Geld entnommen: ~g~',
        ['got_money2'] = '$~s~ Die Kasette ist ~r~leer~s~. Nun bloß schnell weg!',
        ['got_money3'] = '$~s~ Bleib dran, um mehr zu erhalten...',
        ['rob_aborted'] = 'Raub wurde ~r~abgebrochen~s~! Du hast ~g~',
        ['rob_aborted2'] = '$ ~s~erhalten!',
        ['rob_aborted_nothing'] = 'Der Raub wurde ~r~ohne Beute ~s~abgebrochen...',
        ['cop_notify'] = '~r~Stiller Alarm ~s~an einem Geldautomaten in ~y~',
        ['cop_notify2'] = ' ~s~ausgelöst. GPS übermittelt!',
        ['cop_atm'] = 'ATM Security',
        ['cop_heading'] = 'Stiller Alarm',
        ['rob_aborted_chat'] = 'Der Raub wurde ~r~abgebrochen~s~!',
        ['rob_abort_title'] = 'Raub abgebrochen',
        ['not_enough_cops'] = 'Es sind nicht genügend ~d~Polizisten ~s~im Dienst!',
        ['timeout'] = '~r~Dieser ATM wurde kürzlich ausgeraubt',
        ['no_lockpick'] = '~r~Du hast kein Werkzeug dabei!',
    },

    ['en'] = {
        ['blip_text'] = 'Rob ATM',
        ['infobar_start'] = 'Press ~r~G~s~, to rob the ATM',
        ['recently_robbed'] = '~r~This ATM was recently robbed!',
        ['step_1'] = 'You start to break the case of this ATM',
        ['step_2'] = 'Now remove the cables from the alarm system',
        ['step_3'] = 'The alarm system is deactivated! Now just clamp off the ink cassette',
        ['step_4'] = 'The cash box is cracked. You start taking money from the ATM',
        ['got_money'] = '~y~Money taken away: ~g~',
        ['got_money2'] = '$~s~ The ATM is ~r~empty~s~. Now RUN!',
        ['got_money3'] = '$~s~ Stay here to take more money...',
        ['rob_aborted'] = 'Rob was ~r~aborted~s~! You got ~g~',
        ['rob_aborted2'] = '$',
        ['rob_aborted_nothing'] = 'The robbery was aborted without ~r~loot~s~...',
        ['cop_notify'] = '~r~Silent Alarm ~s~at an ATM in ~y~',
        ['cop_notify2'] = '~s~. GPS was sent!',
        ['cop_atm'] = 'ATM Security',
        ['cop_heading'] = 'Silent Alarm',
        ['rob_aborted_chat'] = 'The robbery was ~r~aborted~s~!',
        ['rob_abort_title'] = 'Robbery aborted',
        ['not_enough_cops'] = 'There are not enough ~d~Cops ~s~on duty!',
        ['timeout'] = '~r~This ATM was recently robbed!',
        ['no_lockpick'] = '~r~You do not have a lockpick!',
    }

}

