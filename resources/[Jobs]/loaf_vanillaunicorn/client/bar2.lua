Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

    AddTextEntry('FMMC_KEY_TIP1', TextEntry) 
    
    blockinput = true 
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "Somme", ExampleText, "", "", "", MaxStringLenght) 
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do 
        Citizen.Wait(0)
    end 
         
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500) 
        blockinput = false
        return result 
    else
        Citizen.Wait(500) 
        blockinput = false 
        return nil 
    end
end

--- MENU ---

local open = false 
local mainMenu = RageUI.CreateMenu('Einkauf', 'Unicorn') 
mainMenu.Display.Header = true 
mainMenu.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

local open2 = false 
local mainMenu2 = RageUI.CreateMenu('Einkauf', 'Unicorn') 
mainMenu2.Display.Header = true 
mainMenu2.Closed = function()
  open = false
  nomprenom = nil
  numero = nil
  heurerdv = nil
  rdvmotif = nil
end

--- FUNCTION OPENMENU ---

function OpenMenuAccueilUnicorn() 
    if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(mainMenu, function()

        RageUI.Button("~r~Unicorn~s~ x10 Wodka", nil, {RightLabel = "200$"}, not codesCooldown5 , {
			onSelected = function()
			TriggerServerEvent('unicorn:Buyvodka', "wodka", 10, 200)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
       end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Cointreau", nil, {RightLabel = "100$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buycointreau', "cointreau", 10 , 100)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Cranberrysaft", nil, {RightLabel = "80$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buycranberry_juice', "cranberry_juice", 10, 80)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Bier", nil, {RightLabel = "70$"}, not codesCooldown5 , {
			onSelected = function()
			TriggerServerEvent('unicorn:Buybeer', "beer", 10, 70)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
       end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Champagner", nil, {RightLabel = "370$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buychamp', "champagne", 10 , 370)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        --RageUI.Button("~r~Unicorn~s~ x10 Sekt", nil, {RightLabel = "270$"}, not codesCooldown5 , {
        --onSelected = function()
        --TriggerServerEvent('unicorn:Buysekt', "sekt", 10, 270)	
        --Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        --end 
        --})

        RageUI.Button("~r~Unicorn~s~ x10 Wasser", nil, {RightLabel = "70$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent("unicorn:BuyEau", "water", 10, 70)
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Fertige Mischung", nil, {RightLabel = "120$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buyfresh_mix', "fresh_mix", 10, 120)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Minze", nil, {RightLabel = "60$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buymint', "mint", 10, 60)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Limette", nil, {RightLabel = "70$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buylime', "lime", 10, 70)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Zucker", nil, {RightLabel = "100$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buysugar', "sugar", 10, 100)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Eis", nil, {RightLabel = "20$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buyice', "ice", 10, 20)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Weißer Rum", nil, {RightLabel = "100$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buywhite_rum', "white_rum", 10, 100)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Club Soda", nil, {RightLabel = "150$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buyclub_soda', "club_soda", 10, 150)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Leichter Rum", nil, {RightLabel = "115$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buylight_rum', "light_rum", 10, 115)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Brauner Rum", nil, {RightLabel = "170$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buydark_rum', "dark_rum", 10, 170)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Gold Rum", nil, {RightLabel = "200$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buygold_rum', "gold_rum", 10, 200)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Curacao", nil, {RightLabel = "75$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buycuracao', "curacao", 10, 75)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Sirup", nil, {RightLabel = "20$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buysyrup', "syrup", 10, 20)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })


        RageUI.Button("~r~Unicorn~s~ x10 Bourbon", nil, {RightLabel = "105$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buybourbon', "bourbon", 10, 105)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Cachaca", nil, {RightLabel = "120$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buycachaca', "cachaca", 10, 120)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Limeade", nil, {RightLabel = "75$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buylimeade', "limeade", 10, 75)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Tequila", nil, {RightLabel = "155$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buytequila', "tequila", 10, 155)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Triple Sec", nil, {RightLabel = "120$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buytriple_sec', "triple_sec", 10, 120)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Kokosmilch", nil, {RightLabel = "40$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buycoconut_milk', "coconut_milk", 10, 40)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Ananassaft", nil, {RightLabel = "60$"}, not codesCooldown5 , {
        onSelected = function()
        TriggerServerEvent('unicorn:Buypineapple_juice', "pineapple_juice", 10, 60)	
        Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Coca Cola", nil, {RightLabel = "300$"}, not codesCooldown5 , {
            onSelected = function()
            TriggerServerEvent('unicorn:Buycoca_cola', "cola", 10, 300)	
            Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Red Bull", nil, {RightLabel = "300$"}, not codesCooldown5 , {
            onSelected = function()
            TriggerServerEvent('unicorn:Buyred_bull', "red_bull", 10, 300)	
            Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })

        RageUI.Button("~r~Unicorn~s~ x10 Kaffee", nil, {RightLabel = "150$"}, not codesCooldown5 , {
            onSelected = function()
            TriggerServerEvent('unicorn:Buycoffee', "coffee", 10, 150)	
            Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
        end 
        })


		end)			
		Wait(0)
	   end
	end)
 end
end

function OpenMenuAccueilTabak() 
    if open then 
		open = false
		RageUI.Visible(mainMenu2, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu2, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(mainMenu2, function()
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'lafam' then 
            RageUI.Button("~r~Tabakhändler~s~ x1 Cohiba", nil, {RightLabel = "20000$"}, not codesCooldown5 , {
			    onSelected = function()
			    TriggerServerEvent('tabak:Buycohiba', "cohiba", 1, 20000)	
            Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
            end 
            })

            RageUI.Button("~r~Tabakhändler~s~ x1 Montecristo", nil, {RightLabel = "15000$"}, not codesCooldown5 , {
                onSelected = function()
                TriggerServerEvent('tabak:Buymontecristo', "montecristo", 1 , 15000)	
            Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
            end 
            })
        else
            RageUI.Button("~r~Tabakhändler~s~ x1 Cohiba", nil, {RightLabel = "40000$"}, not codesCooldown5 , {
			    onSelected = function()
			    TriggerServerEvent('tabak:Buycohiba', "cohiba", 1, 40000)	
            Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
            end 
            })

            RageUI.Button("~r~Tabakhändler~s~ x1 Montecristo", nil, {RightLabel = "25000$"}, not codesCooldown5 , {
                onSelected = function()
                TriggerServerEvent('tabak:Buymontecristo', "montecristo", 1 , 25000)	
            Citizen.SetTimeout(5000, function() codesCooldown5 = false end)
            end 
            })
        end

		end)			
		Wait(0)
	   end
	end)
 end
end

local position = {
    {x = 980.89, y = -1705.84, z = 31.12}
}
local position2 = {
    {x = 5006.347168,y = -5196.830566, z = 2.505493}
}

local npc = {
    {hash="a_m_y_business_02", x = 980.89, y = -1705.84, z = 31.12, a = 81.84},
    {hash="a_m_y_business_02", x = 5006.347168, y =  -5196.830566, z = 2.505493, a = 308.976379},
}

Citizen.CreateThread(function()
    for _, item2 in pairs(npc) do
        local hash = GetHashKey(item2.hash)
        while not HasModelLoaded(hash) do
        RequestModel(hash)
        Wait(20)
        end
        ped2 = CreatePed("PED_TYPE_CIVFEMALE", item2.hash, item2.x, item2.y, item2.z-0.92, item2.a, false, true)
        SetBlockingOfNonTemporaryEvents(ped2, true)
        FreezeEntityPosition(ped2, true)
        SetEntityInvincible(ped2, true)
    end
 end)  

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'lafam' then 
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 15.0 then
            wait = 0
            DrawMarker(36, 980.89, -1705.84, 31.12, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 59, 255, true, true, p19, true)  
            
        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Drücken Sie ~b~[E]~s~, um mit dem Verkäufer zu Sprechen", 1) 
                if IsControlJustPressed(1,51) then
                    OpenMenuAccueilUnicorn()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position2) do 
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position2[k].x, position2[k].y, position2[k].z)

            if dist <= 15.0 then
                wait = 0 
                DrawMarker(36, 5006.347168, -5196.830566, 2.505493, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 255, 255, 59, 255, true, true, p19, true)  
            
        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Drücken Sie ~b~[E]~s~, um mit dem Verkäufer zu Sprechen", 1) 
                if IsControlJustPressed(1,51) then
                    OpenMenuAccueilTabak()
            end
        end
    end
    Citizen.Wait(wait)
    end
end
end)

