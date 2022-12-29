config = {}

config.Marker = {type = 2, r = 0, g = 153, b = 0, a = 155}

config.Ped = {
    pedModel = 's_m_y_xmech_01',
    vehicleSpeed = 20.0,
    repairTime = 10
}

config.Commands = {
    command = 'repair',
    chatSuggestion = '/repair',
    labelSuggestion = 'Call Mechanic'
}

--Ho much engine health you want to give to car, if player chose half repair. Number 100.0 - 1000.0
config.EngineHealth = 600.0

config.Price = {
    fullRepair = 60000,
    halfRepair = 20000
}

--always number must be same, rotationRight and rotationLeft and npWaitTime!!
config.RotationCar = {
    rotationRight = 10,
    rotationLeft = -10, --must be '-' on the number or will it not work!! and must be same as all numbers here
    npcWaitTime = 10
}

--vehicle for npc, with this vehicle npc come to repair
config.VehicleNpcSpawn = {
    carModel = 'Towtruck2',
}

config.Blip = {
    sprite = 58,
    display = 4,
    colour = 2,
    scale = 0.7,
    name = 'Mechanic'
}

config.Notification = 'esx' -- you can put [esx, mythic_old, mythic_new, other]

Notification = function (typeNotify, message)
	if typeNotify and message then
		if config.Notification == 'esx' then
    		ESX.ShowNotification(message)
		elseif config.Notification == 'mythic_old' then
			if typeNotify == 1 then
                exports['mythic_notify']:DoCustomHudText('success', message, 10000)
            elseif typeNotify == 2 then
                exports['mythic_notify']:DoCustomHudText('error', message, 10000)
            end
		elseif config.Notification == 'mythic_new' then
			if typeNotify == 1 then
                exports['mythic_notify']:SendAlert('success', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            elseif typeNotify == 2 then
                exports['mythic_notify']:SendAlert('error', message, { ['background-color'] = '#ffffff', ['color'] = '#000000' })
            end
		elseif config.Notification == 'other' then
			-- You can add here your own notification.
		end
	end
end

Lang = {
    ['mechanic_comming'] = 'Der Mechaniker kommt zu Ihnen! Warten Sie!',
    ['cant_use_command'] = 'Das Fahrzeug ist noch fahrbereit! Gehen Sie so schnell wie möglich zum Mechaniker!',
    ['vehicle_missing'] = 'Sie befinden sich in keinem Fahrzeug',
    ['title_menu'] = 'Fahrzeug reparieren',
    ['full_repair'] = 'Vollständige Reparatur, Preis: 85 000 $',
    ['half_repair'] = 'Halbe Reparatur, Preis: 40 000 $',
    ['start_repair'] = '~r~[~w~E~r~]~w~ Reperatur starten',
    ['checkVehicle'] = 'Na, hast du gut gemacht!',
    ['checkHood'] = 'Nun, lassen Sie uns die Motorhaube anheben und sehen, wie es darunter aussieht',
    ['tryingRepair'] = 'Nun, es sieht nicht sehr gut aus, mal sehen, was getan werden kann',
    ['doneRepair'] = 'Okay, es wird eine Weile fahrbar sein, aber gehen Sie unbedingt sofort zu einem Mechaniker! Tschüss',
    ['checkFullRepair'] = 'Nun, das ist insgesamt, was hast du gemacht?',
    ['carjackRepair'] = 'Kein Problem, ich hole den Wagenheber und schaue mir das Auto an',
    ['underVehicleLeft'] = 'Hmmm, schön, ich muss auf die andere Seite schauen',
    ['underVehicleRight'] = 'Okay, ich habe repariert, was am Chassis benötigt wurde, ich werde mir den Motor ansehen',
    ['engineRepair'] = 'Es sieht überhaupt nicht gut aus, ich werde versuchen, es irgendwie zu beheben'
}