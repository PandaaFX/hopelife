Config = {}

--[[
 __          _______ _____ _    _ _______ _____ _____   _ _ _ _ _ _ _ 
 \ \        / /_   _/ ____| |  | |__   __|_   _/ ____| | | | | | | | |
  \ \  /\  / /  | || |    | |__| |  | |    | || |  __  | | | | | | | |
   \ \/  \/ /   | || |    |  __  |  | |    | || | |_ | | | | | | | | |
    \  /\  /   _| || |____| |  | |  | |   _| || |__| | |_|_|_|_|_|_|_|
     \/  \/   |_____\_____|_|  |_|  |_|  |_____\_____| (_|_|_|_|_|_|_)                                        
 
Solltet Ihr in der Config eine Funktion deaktivieren wollen (falls möglich),
müsst Ihr den Wert nil OHNE Anführungszeichen eintragen!
Solltet Ihr "nil" oder 'nil' schreiben, hat diese Einstellung keine Funktion und führt zu Fehlern!
 __          _______ _____ _    _ _______ _____ _____   _ _ _ _ _ _ _ 
 \ \        / /_   _/ ____| |  | |__   __|_   _/ ____| | | | | | | | |
  \ \  /\  / /  | || |    | |__| |  | |    | || |  __  | | | | | | | |
   \ \/  \/ /   | || |    |  __  |  | |    | || | |_ | | | | | | | | |
    \  /\  /   _| || |____| |  | |  | |   _| || |__| | |_|_|_|_|_|_|_|
     \/  \/   |_____\_____|_|  |_|  |_|  |_____\_____| (_|_|_|_|_|_|_)                                        
 
]]


--[[

          _    _  _____ _    _  __          _______ _____ _    _ _______ _____ _____ _ _ _ _ _ _ _ 
     /\  | |  | |/ ____| |  | | \ \        / /_   _/ ____| |  | |__   __|_   _/ ____| | | | | | | |
    /  \ | |  | | |    | |__| |  \ \  /\  / /  | || |    | |__| |  | |    | || |  __| | | | | | | |
   / /\ \| |  | | |    |  __  |   \ \/  \/ /   | || |    |  __  |  | |    | || | |_ | | | | | | | |
  / ____ \ |__| | |____| |  | |    \  /\  /   _| || |____| |  | |  | |   _| || |__| |_|_|_|_|_|_|_|
 /_/    \_\____/ \_____|_|  |_|     \/  \/   |_____\_____|_|  |_|  |_|  |_____\_____(_|_|_|_|_|_|_)
                                                                                                   

Solltet Ihr einen Fehler bezüglich MySQL erhalten, so müsst Ihr in der fxmanifest Datei die '@mysql-async/lib/MySQL.lua' aktivereien.
Weiteres in der fxmanifest Datei!

          _    _  _____ _    _  __          _______ _____ _    _ _______ _____ _____ _ _ _ _ _ _ _ 
     /\  | |  | |/ ____| |  | | \ \        / /_   _/ ____| |  | |__   __|_   _/ ____| | | | | | | |
    /  \ | |  | | |    | |__| |  \ \  /\  / /  | || |    | |__| |  | |    | || |  __| | | | | | | |
   / /\ \| |  | | |    |  __  |   \ \/  \/ /   | || |    |  __  |  | |    | || | |_ | | | | | | | |
  / ____ \ |__| | |____| |  | |    \  /\  /   _| || |____| |  | |  | |   _| || |__| |_|_|_|_|_|_|_|
 /_/    \_\____/ \_____|_|  |_|     \/  \/   |_____\_____|_|  |_|  |_|  |_____\_____(_|_|_|_|_|_|_)
                                                                                                   

]]





--[[
    Welches Framework besitzt dein Server?
    ESX = 'ESX'
    ESX 1.8.5 = 'ESX185'
    QBCore = 'QB'
]]
Config.Framework = 'ESX'
-- Hier könnt Ihr die richtigen Trigger setzen (NUR ESX) Falls ihr ESX1.8.5 habt tragt hier den Namen der Ressource ein. (Z.b es_extended)
Config.FrameworkTrigger = 'esx:getSharedObject'


--[[
    Welcher Job, soll welches VPCNet aufrufen?
    z. B. Soll das CopNET von Polizei und Zoll aufgerufen werden. 
    In diesem Fall ist anzugeben Config.CopNetJob = {'polizei','zoll'}
]]
-- Für das CopNet:
Config.CopNetJob = {'police','fib','lssd','ambulance'}
-- Für das MedicNet:
Config.MedicNetJob = {'ambulance'}
-- Für das CarNet:
Config.CarNetJob = {'mechanic'}


-- Soll beim öffnen vom VPC dein IC-Char ein Tablet in die Hand nehmen?
-- Ja = true   -    nein = false
Config.Animation = true


--[[
Soll ein Item benötigt werden (wen ja Item Name eintragen), um das VPC öffnen zu können?
Wenn nein nil eintragen.
]]
Config.ItemTab = nil


--Welche Items sollen nutzbar sein (inventar) um ins VPC zu gelangen
--Wenn nicht gewünscht nil eintragen
--> Nutzbare Items sind mit Job erkennung
Config.UseableItem = nil


--[[
Soll die Livemap / Livemap Spieler Snny aktiv sein?
Diese Einstellung bennötigt die beiligende Tabelle in der Datenbank!
Wenn ja = true, wenn nein = false
]]
Config.LivemapAktive = true


--[[
Soll ein Item benötigt werden (wen ja Item Name eintragen), um auf der Livemap angezeigt zu werden?
Wenn nein nil eintragen.
]]
Config.ItemMap = nil


-- Soll das VPC nur in einem Auto aufgemacht werden können?
-- Ja = true   -    nein = false
Config.OnlyInVehicle = false


-- Soll das VPC nur in Einsatzfahrzeugen aufgemacht werden können?
-- Ja = true   -    nein = false
Config.InEmergencyVehicle = false


--[[
    Soll das Tab mit einer Taste aufgemacht werden können?
    Wenn nein nil eintragen.
    --> Dieser Hotkey ist mit Job erkennung
]]
Config.OpenTabHotkey = nil


--[[
    Soll das Tab mit einem Befehl aufgemacht werden können?
    Wenn nein nil eintragen.
    --> Dieser Command ist mit Job erkennung!
]]
Config.OpenCommand = 'vpc'


--[[
    Soll das Tab mit einem Befehl aufgemacht werden können?
    Wenn nein nil eintragen.
    --> Dieser Command ruft das CopNET auf, egal welcher Job gesetzt ist
]]
Config.OpenCopNetCommand = nil


--[[
    Soll das Tab mit einem Befehl aufgemacht werden können?
    Wenn nein nil eintragen.
    --> Dieser Command ruft das CarNET auf, egal welcher Job gesetzt ist
]]
Config.OpenCarNetCommand = nil


--[[
    Soll das Tab mit einem Befehl aufgemacht werden können?
    Wenn nein nil eintragen.
    --> Dieser Command ruft das MedicNET auf, egal welcher Job gesetzt ist
]]
Config.OpenMedicNetCommand = 'medicnet'


Config.Zones = {

    {
        Coords = vector3(624.395630, -29.432964, 90.495239),
        Info = 'Drücke E um den PC zu nutzen.',
        Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
        -- cop, medic oder car
        VPCNET = 'cop',
        -- pc , bewerben oder shop
        Type = 'pc',
        -- Job der benötigt wird um den PC zu nutzen
        NeedJob = 'police',
        -- Im Folgenden Radius soll der PC nutzbar sein
        Radius = 2
    },

    --[[
    {
        Coords = vector3(427.29, -597.218, 43.2821),
        Info = 'Drücke E um den PC zu nutzen.',
        VPCNET = 'medic',
        Type = 'pc',
        NeedJob = 'police',
        Radius = 4
    },

        Besp. Für einen CarNet - Shop 
    {
        Coords = vector3(312.9, -1447, 29.69),
        Info = 'Drücke E um den Shop zu nutzen.',
        Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
        Type = 'shop',
        Radius = 4,
        PublicID = '' -- <--Deine PublicID vom Shop hier einfügen
    },
    
    ]]

    
     --[[  Beispiel für ein Bewerbungsformular
    {
        Coords = vector3(427.5, -985.6, 30.71),
        Info = 'Drücke E um das Bewerbungsformular zu nutzen.',
        Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
        VPCNET = 'cop',
        Type = 'bewerben',
        Radius = 4,
        PublicID = '' -- <--Deine PublicID vom PC hier einfügen
    },
    
    ]]

         --[[  Beispiel für einen Punkt für das Strafgesetzbuch
    {
        Coords = vector3(427.29, -597.218, 28.6),
        Info = 'Drücke E um in das Strafgesetzbuch zu schauen.',
        Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
        VPCNET = 'cop',
        Type = 'stgb',
        Radius = 4,
        PublicID = '' -- <--Deine PublicID vom PC hier einfügen
    },
    
    ]]
}






-- 45617374657265676720676566756e64656e203b292068747470733a2f2f7777772e796f75747562652e636f6d2f77617463683f763d79364e5364474c38637a77

