Config = {}

Config.Locale = 'de'

-- 'de' or 'us' time format
-- de: DD.MM.YYYY | hh:mm
-- us: MM/DD/YYYY | hh:mm
Config.dateFormat = 'de' 

Config.UseKMH = true -- otherwise you will use mph

-- this job can set up the speedcams
Config.policeJob = 'police'
Config.policeJob2 = 'lssd'
Config.sendCopDispatch = false -- send a dispatch when a speedcam flashes somebody. 

-- jobs which are not effected by speedcams
Config.JobsToIgnore = {
  "police"
  ,"ambulance"
  ,"fib"
  ,"lssd"
}

-- where should the money being removed from, using direct payments instead of billing.
-- bank, money or black_money
Config.moneyAccount = "money"

-- should the /speedcams command open the speedcam stats
Config.useSpeedcamCommand = true
Config.bossMenuRestricted = true
Config.bossMenuGradeRequired = '16'
Config.bossMenuGradeRequired2 = '17'
Config.bossMenuGradeRequired3 = '18'
Config.bossMenuGradeRequired4 = 'boss'
--[[
  SET Config.FlashJobsIfSirenOff = true when a entry in Config.JobsToIgnore should be caught. Execpt for moments where Siren is on. Otherwise they have to pay.. 
  If Config.FlashJobsIfSirenOff = false then the entries in Config.JobsToIgnore will never get caught
]]--

Config.FlashJobsIfSirenOff = false 

Config.Prop = 'prop_cctv_pole_01a'
Config.PropCorrectZAxis = 6.2       -- change for Z-Axis of radar 
Config.PropCorrectHeading = 110.0   --do not change if default prop 'prop_cctv_pole_01a'


Config.Billing = {
    okokBilling = false
    ,myBilling = true
    ,default = false
    ,Custom = false
}

Config.notifications = {
    DefaultFiveM = true,
    BtwLouis = false,
    Custom = false
}

Config.UseFlashingScreen = true


--[[
  Config.prices example

  {limitFrom = 5, limitTo = 10, price = 20} -> 5-9 above limit = $20
  {limitFrom = 10, limitTo = 15, price = 40} -> 10-14 above limit = $40
  {limitFrom = 15, limitTo = 20, price = 60} -> 15-19 above limit = $60

]]--

Config.toleranceRate = 0.10 -- you can exceed the speed limit about 10%

Config.Ranges = {
  5.0,
  10.0,
  15.0,
  20.0,
  25.0,
  30.0,
}

Config.prices = {
  {limitFrom = 5, limitTo = 10, price = 20}
  ,{limitFrom = 10, limitTo = 15, price = 40}
  ,{limitFrom = 15, limitTo = 20, price = 60}
  ,{limitFrom = 20, limitTo = 25, price = 100}
  ,{limitFrom = 26, limitTo = 30, price = 150}
  ,{limitFrom = 30, limitTo = 40, price = 200}
  ,{limitFrom = 40, limitTo = 50, price = 320}
  ,{limitFrom = 50, limitTo = 60, price = 480}
  ,{limitFrom = 60, limitTo = 70, price = 600}
  ,{limitFrom = 70, limitTo = nil, price = 700}
}

Config.defaultSociety = 'society_police'

Config.RadarControls = {
  {
    name = "Pillbox-Hill MD Radar"
    , society = 'society_police'
    , maxSpeed = 50 
    , pos = {x = 257.51, y = -590.14, z = 43.20}
    , propPos = {
        {x = 243.42, y = -587.54, z = 43.10, heading = 320.49}
        ,{x = 273.36, y = -597.56, z = 43.10, heading = 138.45}
    }
    , flashDistance = 20.0,
  },
  {
    name = "Mission Row PD"
    , society = 'society_police'
    , maxSpeed = 50 
    , pos = {x = 399.83, y = -967.82, z = 29.39}
    , propPos = {
        {x = 407.19, y = -969.10, z = 29.43, heading = 164.79}
        ,{x = 393.35, y = -971.32, z = 29.43, heading = 340.20}
    }
    , flashDistance = 20.0,
  },
  {
    name = "Los Santos International Airport"
    , society = 'society_police'
    , maxSpeed = 50 
    , pos = {x = -1060.99, y = -2708.97, z = 20.20}
    , propPos = {
        {x = -1065.87, y = -2714.35, z = 20.16, heading = 30.79}
        ---1065.8732, -2714.3567, 20.1693, 30.7956
    }
    , flashDistance = 20.0,
  },
  {
    name = "Paleto Boulevard"
    , society = 'society_police'
    , maxSpeed = 50 
    , pos = {x = -235.16, y = 6299.33, z = 31.50}
    , propPos = {
        {x = -241.40, y = 6304.73, z = 31.45, heading = 304.82}
        ,{x = -228.15, y = 6294.37, z = 31.45, heading = 123.45}
        
    }
    , flashDistance = 20.0,
  }
}


Config.Controls = {
  -- turn controls
  turnright = {
      name = 'INPUT_CELLPHONE_RIGHT',
      key = 175
  },
  turnleft = {
      name = 'INPUT_CELLPHONE_LEFT',
      key = 174
  },
  -- move controls
  moveright = {
      name = 'INPUT_CELLPHONE_RIGHT',
      key = 175
  },
  moveleft = {
      name = 'INPUT_CELLPHONE_LEFT',
      key = 174
  },
  moveup = {
      name = 'INPUT_FRONTEND_UP',
      key = 172
  },
  movedown = {
      name = 'INPUT_FRONTEND_DOWN',
      key = 173
  },
  movehigher = {
      name = 'INPUT_FRONTEND_UP',
      key = 172
  },
  movelower = {
      name = 'INPUT_FRONTEND_DOWN',
      key = 173
  },
  -- general controls
  fast = {
      name = 'INPUT_FRONTEND_SELECT',
      key = 217
  },
  slow = {
      name = 'INPUT_FRONTEND_LS',
      key = 209
  },
  finish = {
      name = 'INPUT_CELLPHONE_CAMERA_EXPRESSION',
      key = 186
  },
}

Translations = {
  ["de"] = {
    ["caught_title"] = "City of Los Santos",
    ["caught_subtitle"] = "Bußgeldstelle",
    ["caught01"] = "~r~Geschwindigkeitsüberschreitung",
    ["caught02"] = "~s~Geschwindigkeit: ~y~",
    ["caught03"] = "~s~Erlaubt: ~g~ ",
    ['controls'] = 'Bedienung',
    ['infobar_text'] = 'Drücke ~g~E~s~, um den Blitzer einzustellen',
    ['mobile_speedcam'] = 'Mobiler Blitzer',
    ['turn_right'] = ' ~s~um das Objekt ~b~nach rechts ~s~zu drehen',
    ['turn_left'] = ' ~s~um das Objekt ~b~nach links ~s~zu drehen',
    ['turn_fast'] = ' ~s~um das Objekt ~b~schneller ~s~zu drehen',
    ['turn_slow'] = ' ~s~um das Objekt ~b~langsamer ~s~zu drehen',
    ['move_forward'] = ' ~s~um das Objekt nach ~b~vorne ~s~zu ~b~bewegen.',
    ['move_backwards'] = ' ~s~um das Objekt nach ~b~hinten ~s~zu ~b~bewegen.',
    ['move_right'] = ' ~s~um das Objekt nach ~b~rechts ~s~zu ~b~bewegen.',
    ['move_left'] = ' ~s~um das Objekt nach ~b~links ~s~zu ~b~bewegen.',
    ['move_fast'] = ' ~s~um das Objekt ~b~schneller ~s~zu ~b~bewegen.',
    ['move_slow'] = ' ~s~um das Objekt ~b~langsamer ~s~zu ~b~bewegen.',
    ['move_lower'] = ' ~s~um das Objekt ~b~nach unten ~s~zu ~b~bewegen.',
    ['move_higher'] = ' ~s~um das Objekt ~b~nach oben ~s~zu ~b~bewegen.',
    ['back_to_menu'] = ' ~s~um zum ~b~Hauptmenu ~s~zurückzukehren.',
    ['profit_title'] = 'Blitzerauswertung',
    ['all_radars'] = 'Alle Blitzer',
    ['owner'] = 'Konto: ',
    ['max_speed'] = 'Max. Geschwindigkeit:',
    ['flash_range'] = 'Range:',
    ['location'] = 'Standort',
    ['location_desc'] = 'Klicke, um einen ~y~Wegpunkt ~s~zu setzen',
    ['analyse_title'] = 'Einnahmen der Blitzer',
    ['last'] = '~b~Zuletzt: ~s~',
    ['at'] = ' at ',
    ['name'] = 'Name:',
    ['type'] = 'Art:',
    ['type_static'] = '~o~Fester Blitzer',
    ['type_mobile'] = '~y~Mobiler Blitzer',
    ['total_profit'] = 'Gesamte Einnahmen:',
    ['last_flashed'] = 'Zuletzt ausgelöst:',
    ['last_identity'] = 'Name, Vorname:',
    ['last_fine'] = 'Bezahlte Strafe:',
    ['setup_title'] = 'Blitzer aufstellen',
    ['radius'] = 'Range:',
    ['max_speed'] = 'Max. Speed:',
    ['society'] = 'Society:',
    ['turn'] = 'Blitzer drehen',
    ['move'] = 'Blitzer bewegen',
    ['save'] = '~g~Blitzer speichern',
    ['saved'] = '~g~Blitzer wurde erfolgreich aufgestellt!',
    ['delete'] = 'Blitzer entfernen',
    ['no_access'] = '~r~Du hast keinen Zugriff hierauf.',
  }
  ,["en"] = {
    ["caught_title"] = "City of Los Santos",
    ["caught_subtitle"] = "Traffic Department",
    ["caught01"] = "~r~You were caught speeding!",
    ["caught02"] = "~s~Your speed: ~y~",
    ["caught03"] = "~s~Allowed: ~g~ ",
    ['controls'] = 'Controls',
    ['infobar_text'] = 'Press ~g~E~s~, to set up the speedcam',
    ['mobile_speedcam'] = 'LSPD Speedcam',
    ['turn_right'] = ' ~s~to ~b~turn ~s~the object ~b~right',
    ['turn_left'] = ' ~s~to ~b~turn ~s~the object ~b~left',
    ['turn_fast'] = ' ~s~to ~b~turn ~s~the object ~b~faster',
    ['turn_slow'] = ' ~s~to ~b~turn ~s~the object ~b~slower',
    ['move_forward'] = ' ~s~to ~b~move ~s~the object ~b~forward',
    ['move_backwards'] = ' ~s~to ~b~move ~s~the object ~b~backwards',
    ['move_right'] = ' ~s~to ~b~move ~s~the object ~b~right side',
    ['move_left'] = ' ~s~to ~b~move ~s~the object ~b~left side',
    ['move_fast'] = ' ~s~to ~b~move ~s~the object ~b~faster',
    ['move_slow'] = ' ~s~to ~b~move ~s~the object ~b~slower',
    ['move_higher'] = ' ~s~to ~b~move ~s~the object ~b~up',
    ['move_lower'] = ' ~s~to ~b~move ~s~the object ~b~down',
    ['back_to_menu'] = ' ~s~to go ~b~back ~s~to main menu',
    ['profit_title'] = 'Speedcam stats',
    ['all_radars'] = 'Speedcam overview',
    ['owner'] = 'Owner: ',
    ['max_speed'] = 'Max. Speed:',
    ['flash_range'] = 'Range:',
    ['location'] = 'Location:',
    ['location_desc'] = 'Click, to set a ~y~waypoint',
    ['analyse_title'] = 'Speedcam earnings',
    ['last'] = '~b~Last: ~s~',
    ['at'] = ' at ',
    ['name'] = 'Name:',
    ['type'] = 'Type:',
    ['type_static'] = '~o~Static speedcam',
    ['type_mobile'] = '~y~Transportable speedcam',
    ['total_profit'] = 'Total earnings:',
    ['last_flashed'] = 'Last triggered:',
    ['last_identity'] = 'From:',
    ['last_fine'] = 'Fine:',
    ['setup_title'] = 'Set up speedcam',
    ['radius'] = 'Range:',
    ['max_speed'] = 'Max. Speed:',
    ['society'] = 'Society:',
    ['turn'] = 'Turn speedcam',
    ['move'] = 'Move speedcam',
    ['save'] = '~g~Save speedcam',
    ['saved'] = '~g~Speedcam was successfully installed!',
    ['delete'] = '~r~Remove speedcam',
    ['no_access'] = '~r~You do not have permissions for this action.',
  }
}