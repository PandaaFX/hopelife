 ESX = nil

_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Coffee Shop", "Coffee Menu")
_menuPool:Add(mainMenu)

function coffeeMenu(menu)
  local click = NativeUI.CreateItem(Config.umBMenu["item1"]["header"], Config.umBMenu["item1"]["text"])
  menu:AddItem(click)
  local click2 = NativeUI.CreateItem(Config.umBMenu["item2"]["header"], Config.umBMenu["item2"]["text"])
  menu:AddItem(click2)
  local click3 = NativeUI.CreateItem(Config.umBMenu["item3"]["header"], Config.umBMenu["item3"]["text"])
  menu:AddItem(click3)
  local exit = NativeUI.CreateItem('Exit', 'Exit the Coffee Shop')
  menu:AddItem(exit)
  menu.OnItemSelect = function(sender, item, index)
    if item == click then
      TriggerEvent('um-bm:client:order', Config.umBMenu["item1"]["price"])
      -- TriggerEvent('hopelife:notify', 1, '#4E3524', 'Coffee Shop', 'Du hast erfolgreich '.. Config.umBMenu["item1"]["header"] .. ' für '.. Config.umBMenu["item1"]["text"] .. ' gekauft!', 5500)
    end
    if item == click2 then
      TriggerEvent('um-bm:client:order', Config.umBMenu["item2"]["price"])
      -- TriggerEvent('hopelife:notify', 1, '#4E3524', 'Coffee Shop', 'Du hast erfolgreich '.. Config.umBMenu["item2"]["header"] .. ' für '.. Config.umBMenu["item2"]["text"] .. ' gekauft!', 5500)
    end
    if item == click3 then
      TriggerEvent('um-bm:client:order', Config.umBMenu["item3"]["price"])
      -- TriggerEvent('hopelife:notify', 1, '#4E3524', 'Coffee Shop', 'Du hast erfolgreich '.. Config.umBMenu["item3"]["header"] .. ' für '.. Config.umBMenu["item3"]["text"] .. ' gekauft!', 5500)
    end
    if item == exit then
      TriggerEvent('um-bm:client:exit')
    end
  end
end

coffeeMenu(mainMenu)
_menuPool:RefreshIndex()
_menuPool:MouseControlsEnabled(false)
_menuPool:MouseEdgeEnabled(false)
_menuPool:ControlDisablingEnabled(false)





 Citizen.CreateThread(function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(0)
        end
    end)
      local coffee,npc = false,false
      Citizen.CreateThread(function()
        while true do
          local sleep = 5000
          local PlayerPed = PlayerPedId()
          local PlayerPos = GetEntityCoords(PlayerPed)
          local npcdist = #(PlayerPos - 
          vector3(Config.umBM["loc"].x,Config.umBM["loc"].y,Config.umBM["loc"].z))
          if npcdist < 2 and not coffee then
          -- if npcdist < 2 then
            sleep = 5
            DrawText3Ds(Config.umBM["loc"].x,Config.umBM["loc"].y,Config.umBM["loc"].z + 1.35, 
            '~c~E~w~ - Coffee Order')
              if IsControlJustPressed(0, 38) then
              -- TriggerEvent('um-bm:client:menu')
                DisableControlAction(0, 194, true)
                DisableControlAction(0, 199, true)
                DisableControlAction(0, 322, true)
                mainMenu:Visible(not mainMenu:Visible())
              end
            end
          Citizen.Wait(sleep)
          _menuPool:ProcessMenus()
        end
    end)
	
-- RegisterNetEvent("um-bm:client:menu", function()
--         TriggerEvent("nh-context:createMenu",{
--                 {
--                     header = "Coffee Menu",
--                     context = ""
--                 },
--                 {
--                     header = Config.umBMenu["item1"]["header"],
--                     context = Config.umBMenu["item1"]["text"],
--                     event = "um-bm:client:order",
--                     args = {
--                          Config.umBMenu["item1"]["price"]
--                 },
--             },
--                 {
--                     header = Config.umBMenu["item2"]["header"],
--                     context = Config.umBMenu["item2"]["text"],
--                         event = "um-bm:client:order",
--                         args = {
--                             Config.umBMenu["item2"]["price"]
--                         }
--                 },
--                 {
--                     header = Config.umBMenu["item3"]["header"],
--                     context = Config.umBMenu["item3"]["text"],
--                         event = "um-bm:client:order",
--                         args = {
--                             Config.umBMenu["item3"]["price"]
--                 },
                
--             },
--                 {
--                     header = "< Exit Menu",
--                     context = "",
--                         event = "um-bm:client:exit"
--                 }
--             }
--         )
-- end)


    RegisterNetEvent(
    "um-bm:client:order",
    function(price)
      coffee = true
        if price == Config.umBMenu["item1"]["price"] then
            checkprop = Config.umBMenu["item1"]["prop"]
            item = Config.umBMenu["item1"]["item"]
        elseif price ==  Config.umBMenu["item2"]["price"] then
            checkprop = Config.umBMenu["item2"]["prop"]
            item = Config.umBMenu["item2"]["item"]
        elseif price ==  Config.umBMenu["item3"]["price"] then
            checkprop = Config.umBMenu["item3"]["prop"]
            item = Config.umBMenu["item3"]["item"]
        end
      ESX.TriggerServerCallback('um-bm:server:money', function(money)
      if money >= price then 
        npc = true
        TriggerEvent('um-bm:client:exit')
        TriggerServerEvent('um-bm:server:paid', price)
    else
      TriggerEvent('hopelife:notify', 1, '#b60000', 'Fehler', 'Du hast nicht genügend Geld!', 5500)
      coffee = false
    end
      end)
  end)

  Citizen.CreateThread(function()
    local modelHash = GetHashKey(Config.umBM["ped"])
    RequestModel(modelHash)
      while not HasModelLoaded(modelHash) do
        Wait(1)
      end
    local ped = CreatePed(4, 
    modelHash, Config.umBM["loc"].x,Config.umBM["loc"].y,Config.umBM["loc"].z, 
    10.2, false, false)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    TaskStartScenarioInPlace(ped, Config.umBM["pedanim"], 0, 0)
    local AnimDict = "anim@heists@humane_labs@finale@keycards"
    RequestAnimDict(AnimDict)
    while not HasAnimDictLoaded(AnimDict) do
        Citizen.Wait(10)
    end
    while true do
    local sleep = 5000
    if npc == true then
    sleep = 5000
    local boneIndex = GetPedBoneIndex(ped, 18905)
    FreezeEntityPosition(PlayerPed, true)
    FreezeEntityPosition(ped, false)
    ClearPedTasks(ped) 
    TaskPedSlideToCoord(ped, 
    279.6640, -974.504, 29.421, 150.42, 10.0)
    Wait(4500)
    prop = CreateObject(GetHashKey(checkprop), true, true, true)
    AttachEntityToEntity(prop, ped, 
    boneIndex, 0.12, 0.008, 0.03, 240.0, -60.0, 0.0, true, true, false, true, 1, true)
    TaskPlayAnim(ped, AnimDict, "ped_a_enter_loop", 5.0, -1, -1, 50, 0, false, false, false)
    TaskPedSlideToCoord(ped, 
    Config.umBM["loc"].x,Config.umBM["loc"].y,Config.umBM["loc"].z, 10.0)
    Wait(3000)
    TriggerServerEvent('um-bm:server:item',item)
    FreezeEntityPosition(PlayerPed, false)
    ClearPedTasks(ped) 
    DeleteEntity(prop) 
    FreezeEntityPosition(ped, true)
    npc,bean,mug,donut,coffee = false,false,false,false,false
  end
  Citizen.Wait(sleep)
end
end)

  function DrawText3Ds(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
  end

  RegisterNetEvent('um-bm:client:exit', function(data)
    mainMenu:Visible(not mainMenu:Visible())
    EnableControlAction(0, 194, true)
    EnableControlAction(0, 199, true)
    EnableControlAction(0, 322, true)
    coffee = false
  end)

CreateThread(function()
  if Config.umBM["blip"] then
      local umblip = AddBlipForCoord(Config.umBM["loc"].x, Config.umBM["loc"].y, Config.umBM["loc"].z) 
      SetBlipSprite(umblip, 106)
      SetBlipDisplay(umblip, 4)
      SetBlipScale(umblip, 0.6)
      SetBlipColour(umblip, 21)
      SetBlipAsShortRange(umblip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(Config.umBM["blipname"])
      EndTextCommandSetBlipName(umblip)
  end
end)