ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    TriggerServerEvent( "souki_pedmenu:checkadmin")
end)
local statIndexPedAmbientfemale = 1
local IndexPedAmbientfemale = {
"ivy",
"hope_hoody",
"hope_pd",
"hope_gang",
"child_m",
"babygirl02",
"babyboy1",
"legoblackpanter",
"darksirenhead",
"fatcop",
"bumblebee",
"hope_biene",
"hope_halloween"
}

local statIndexPedanimals = 1
local IndexPedanimals = {
"a_c_boar",
"a_c_cat_01",
"a_c_chickenhawk",
"a_c_chimp",
"a_c_chop",
"a_c_cormorant",
"a_c_cow",
"a_c_coyote",
"a_c_crow",
"a_c_deer",
"a_c_dolphin",
"a_c_fish",
"a_c_humpback",
"a_c_husky",
"a_c_killerwhale",
"a_c_mtlion",
"a_c_pig",
"a_c_pigeon",
"a_c_poodle",
"a_c_pug",
"a_c_rabbit_01",
"a_c_rat",
"a_c_retriever",
"a_c_rhesus",
"a_c_rottweiler",
"a_c_seagull",
"a_c_sharkhammer",
"a_c_sharktiger",
"a_c_shepherd",
"a_c_stingray",
"a_c_westy"
}

function Keyboardput(TextEntry, ExampleText, MaxStringLength)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
	blockinput = true

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
RegisterNetEvent('souki_pedmenu:checkid')
AddEventHandler('souki_pedmenu:checkid', function()
    admindetect = true
end)
--RegisterKeyMapping('+pedmenu', 'Menu Ped', 'keyboard', 'F9')
RegisterNetEvent('souki_pedmenu:pedmenu')
AddEventHandler('souki_pedmenu:pedmenu', function()
   -- if admindetect == true then
        pedmenu()
   -- end
end)

--RegisterCommand('+pedmenu', function()
--	if admindetect == true then
 --   pedmenu()
 --   end
--end)
function pedmenu()
    local soukimenuped = RageUI.CreateMenu("Ped Menu", "Categories")
    local soukimenupedSub = RageUI.CreateSubMenu(soukimenuped, "Menu Ped", "Categories")
    RageUI.Visible(soukimenuped, not RageUI.Visible(soukimenuped))
    while soukimenuped do
        Wait(0)
            RageUI.IsVisible(soukimenuped, true, true, true, function()
                RageUI.ButtonWithStyle("Zurücksetzen", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                        local isMale = skin.sex == 0
                        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                        TriggerEvent('skinchanger:loadSkin', skin)
                        TriggerEvent('esx:restoreLoadout')
                        ESX.ShowNotification("~g~You come to recover your appearance")
                        end)
                        end)
                        end)
                    end     
                end)
                RageUI.ButtonWithStyle("Suche per Name", nil, {RightLabel = nil}, true, function(Hovered, Active, Selected)
                    if (Selected) then
                        local newped = Keyboardput('Enter the name of your Ped', '', 45)
                        putinped(newped)
                    end
                end)
                RageUI.List("Hope", IndexPedAmbientfemale, statIndexPedAmbientfemale, nil, {}, true, function(Hovered, Active, Selected, i) statIndexPedAmbientfemale = i
                    if (Selected) then
                        putinped(IndexPedAmbientfemale[statIndexPedAmbientfemale])
                    end
                end)
                RageUI.List("Tiere", IndexPedanimals, statIndexPedanimals, nil, {}, true, function(Hovered, Active, Selected, i) statIndexPedanimals = i
                    if (Selected) then
                        putinped(IndexPedanimals[statIndexPedanimals])
                    end
                end)
			end, function()
			end)
              if not RageUI.Visible(soukimenuped) and not RageUI.Visible(soukimenupedSub) then
              soukimenuped = RMenu:DeleteType("soukimenuped", true)
        end
    end
end
function putinped(ped)
    local j1 = PlayerId()
    local p1 = ped
    --print(ped)
        RequestModel(p1)
            while not HasModelLoaded(p1) do
                Wait(100)
            end
        SetPlayerModel(j1, p1)
        SetModelAsNoLongerNeeded(p1)
        ESX.ShowNotification("~g~You have just put yourself in ped")
end