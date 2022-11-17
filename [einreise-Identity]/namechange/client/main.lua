local PlayerData                = {}
ESX                             = nil

Citizen.CreateThread(function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
      Citizen.Wait(0)
      ESX.PlayerData = ESX.GetPlayerData()
    end
end)  

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)


 function OpenMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_shop_menu',
        {
            title    = 'Namensänderung',
			align   = 'bottom-right',
            elements = {
                {label = 'Vorname/Nachname ändern', value = 'namechange'},
            }
        },
        function(data, menu)
            if data.current.value == 'namechange' then
                promenaimena() 
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end


function promenaimena()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_shop_menu',
        {
            title    = 'Namensaenderung',
			align   = 'bottom-right',
            elements = {
                {label = 'Vorname <span style="color:green";>[200000$]', value = 'name'},
                {label = 'Nachname <span style="color:green";>[200000$]', value = 'lastname'},
            }
        },
        function(data, menu)
            if data.current.value == 'name' then
                ESX.UI.Menu.Open(
                    'dialog', GetCurrentResourceName(), 'menjaj_ime',
                    {
                        title = ('Dein zukünftiger Vorname?'),
                    },
                    function(data3, menu3)
                        menu3.close()
                TriggerServerEvent('promeniga1',  GetPlayerServerId(PlayerId()), data3.value)
            end,
            function(data3, menu3)
                menu3.close()
            end
        )
            elseif data.current.value == 'lastname' then                  
                ESX.UI.Menu.Open(
                    'dialog', GetCurrentResourceName(), 'menjaj_prezime',
                    {
                        title = ('Dein zukünftiger Nachname?'),
                    },
                    function(data4, menu4)
                        menu4.close()
                TriggerServerEvent('promeniga2',  GetPlayerServerId(PlayerId()), data4.value)
            end,
            function(data4, menu4)
                menu4.close()
            end
        )
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end
 
Citizen.CreateThread(function()
    while true do
	local ped = PlayerPedId()
	local distance = GetDistanceBetweenCoords(GetEntityCoords(ped))
        Citizen.Wait(1)

                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.CoordsX, Config.CoordsY, Config.CoordsZ, true) < 100 then
                    DrawMarker(0, Config.CoordsX, Config.CoordsY, Config.CoordsZ, 0, 0, 0, 0, 0, 90.0, 1.7, 1.7, 1.0, 0, 253, 110, 155, 0, 0, 2, 0, 0, 0, 0)
                        if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.CoordsX, Config.CoordsY, Config.CoordsZ, true) < 1 then
                            ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ um deinen NAMEN zu ändern')
                                if IsControlJustReleased(1, 51) then
                                   OpenMenu()
                                end
                            end                           
                        end
                        end
                    end)
