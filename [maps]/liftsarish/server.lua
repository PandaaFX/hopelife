local liftData = {
	["789456"] = {
		code = "789456",
		
		InteriorId = 3330, --GetInteriorFromEntity(ped)
		
		controlup = {x=-1074.7889404297,y=-252.78123474121,z=44.021064758301}, --(Inter de control murale pour appeler la cabine)
		controldown = {x=-1074.7200927734,y=-252.8878326416,z=37.763286590576}, 
		
		up = {x=-1074.8277587891,y=-254.590279099609,z=42.99}, --(position cabine)
		down = {x=-1074.8277587891,y=-254.590279099609,z=36.73},
		
		controlCabineUp = {x=-1075.8618164063,y=-254.42388916016,z=44.02}, --(Inter de control dans la cabine)
		controlCabineDown = {x=-1075.8618164063,y=-254.42388916016,z=37.734912872314},
		
		downRoomId = -1711658181, --Gestion des portal (useless now)
		upRoomId = -266971274,
		
		
		Zelevate=42.99-36.73, --Hauteur d'élévation Zmax - Zmin (flemme de calculer)
		
		isUp = false,
		
		isInUse = false,
		
		currentCoords = {x=-1074.8277587891,y=-254.590279099609,z=36.73}, --useless
		
		elevateProps = "patoche_elevator", --Cabine props
		rotation = {a=0.0,b=0.0,c=0.0},
		elevateHeading = 27.649951934814, --Heading de l'ascenceur (World relative)
		elevateID = 0, -- ID du props spawn
		
		
		downDoorIsOpen = false,
		
		doorDownL = "v_ilev_fib_doore_l",
		doorDownLCoords = {x=-1075.2545,y=-253.5753,z=36.7732},
		doorDownLOpenCoords = {x=-1074.701, y=-253.2831, z=36.7732},
		doorDownLHeading = 27.649951934814,
		doorDownLID = 0, -- ID du props spawn
		
		doorDownR = "v_ilev_fib_doore_r",
		doorDownRCoords = {x=-1075.2634,y=-253.5800,z=36.7732},
		doorDownROpenCoords = {x=-1075.817, y=-253.8722, z=36.7732},
		doorDownRHeading = 27.649951934814,
		doorDownRID = 0, -- ID du props spawn
		
		
		
		upDoorIsOpen = false,
		
		doorUpL = "v_ilev_fib_doore_l",
		doorUpLCoords = {x=-1075.2545,y=-253.5753,z=43.025},
		doorUpLOpenCoords = {x=-1074.701, y=-253.2831, z=43.025},
		doorUpLHeading = 27.649951934814,
		doorUpLID = 0,-- ID du props spawn
		
		doorUpR = "v_ilev_fib_doore_r",
		doorUpRCoords = {x=-1075.2634,y=-253.5800,z=43.025},
		doorUpROpenCoords = {x=-1075.817, y=-253.8722, z=43.025},
		doorUpRHeading = 27.649951934814,
		doorUpRID = 0,-- ID du props spawn
		
	}
}

RegisterServerEvent('lift:liftup') --Monter (depuis l'intérieur)
AddEventHandler('lift:liftup', function(code)
	Citizen.CreateThread(function()
		if not liftData[code].isInUse then
			liftData[code].isInUse = true
			TriggerClientEvent("lift:closeDoorDown",-1,code) --ferme porte du bas
			Wait(3950)
			
			for i=1,3 do
				print("lift up")
				TriggerClientEvent("lift:StepUp",-1,code)
				Wait(3000)
				print("waitEnded")
			end
			TriggerClientEvent("lift:StepUpAndDoor",-1,code) -- et monte puis ouvre les portes

			liftData[code].isUp = true
			liftData[code].isInUse = false
			Wait(35000)
			TriggerClientEvent("lift:closeDoorUpIfnotBusy",-1,code)
		end
	end)
end)

RegisterServerEvent('lift:liftdown') --Descendre (depuis l'intérieur)
AddEventHandler('lift:liftdown', function(code)
	Citizen.CreateThread(function()
		if not liftData[code].isInUse then
			liftData[code].isInUse = true
			TriggerClientEvent("lift:closeDoorUp",-1,code)--ferme porte du haut
			Wait(3950)
			for i=1,3 do
				print("lift up")
				TriggerClientEvent("lift:StepDown",-1,code)
				Wait(3000)
				print("waitEnded")
			end
			
			TriggerClientEvent("lift:StepDownAndDoor",-1,code)-- et descend puis ouvre les portes
			liftData[code].isUp = false
			liftData[code].isInUse = false
			Wait(35000)
			TriggerClientEvent("lift:closeDoorDownIfnotBusy",-1,code)
		end
	end)
end)

RegisterServerEvent('lift:askUp')
AddEventHandler('lift:askUp', function(code)
	Citizen.CreateThread(function()
		if not liftData[code].isUp then -- si en bas monte et ouvre porte
			if not liftData[code].isInUse then
				liftData[code].isInUse = true
				TriggerClientEvent("lift:upAndDoor",-1,code)
				liftData[code].isUp = true
				liftData[code].isInUse = false
			end
		else -- déja en haut juste ouvre porte
			TriggerClientEvent("lift:openDoorUp",-1,code)
		end
	end)
end)

RegisterServerEvent('lift:askDown')
AddEventHandler('lift:askDown', function(code)
	Citizen.CreateThread(function()
		if liftData[code].isUp then -- si en haut descend et ouvre porte
			if not liftData[code].isInUse then
				liftData[code].isInUse = true
				TriggerClientEvent("lift:downAndDoor",-1,code)
				liftData[code].isUp = false
				liftData[code].isInUse = false
			end
		else -- déja en bas juste ouvre porte
			TriggerClientEvent("lift:openDoorDown",-1,code)
		end
	end)
end)

RegisterServerEvent('lift:GetStatus')
AddEventHandler('lift:GetStatus', function()
	local player = source
	TriggerClientEvent("lift:sendStatus",player,liftData)
end)

