if type(Framework) == "table" then
    if Framework.ESX then
        Framework = "1"
    elseif Framework.QBCore then
        Framework = "2"
    end
end

if type(SkinChanger) == "table" then
    if SkinChanger.skinchanger or SkinChanger.cui_character then
        SkinChanger = "1"
    elseif SkinChanger.qb_clothing then
        SkinChanger = "3"
    elseif SkinChanger.fivem_appearance then
        SkinChanger = "4"
    end
end

if SkinChanger == "1" or SkinChanger == "2" then
    ----------
    function LoadPlayerSkin(data)
        TriggerEvent(Config.ESXCallbacks['skinchanger:loadSkin'], data)
    end

    function LoadPlayerClothes(skin, data)
        TriggerEvent(Config.ESXCallbacks['skinchanger:loadClothes'], skin, data)
    end

    function GetPlayerSkin(cb)
        TriggerEvent(Config.ESXCallbacks['skinchanger:getSkin'], cb)
    end

    ----------
    function SavePlayerSkin(skin)
        TriggerServerEvent(Config.ESXCallbacks['esx_skin:save'], skin)
    end

    function SetPlayerLastSkin(skin)
        TriggerEvent(Config.ESXCallbacks['esx_skin:setLastSkin'], skin)
    end

    ----------
end

if SkinChanger == "3" then
    local SkinMetaData = {
        ["arms"] = { name = "arms", item = 0 },
        ["eye_color"] = { name = "eye_color", item = 0 },
        ["tshirt_1"] = { name = "t-shirt", item = 1, },
        ["tshirt_2"] = { name = "t-shirt", texture = 0, },
        ["torso_1"] = { name = "torso2", item = 1, },
        ["torso_2"] = { name = "torso2", texture = 0, },
        ["pants_1"] = { name = "pants", item = 0 },
        ["pants_2"] = { name = "pants", texture = 0 },
        ["shoes_1"] = { name = "shoes", item = 0 },
        ["shoes_2"] = { name = "shoes", texture = 0 },
        ["face_1"] = { name = "face", item = 0 },
        ["face_2"] = { name = "face", texture = 0 },
        ["skin"] = { name = "face", texture = 0 },
        ["bproof_1"] = { name = "vest", item = 0 },
        ["bproof_2"] = { name = "vest", texture = 0 },
        ["chain_1"] = { name = "accessory", item = 0 },
        ["chain_2"] = { name = "accessory", texture = 0 },
        ["decals_1"] = { name = "decals", item = 0 },
        ["decals_2"] = { name = "decals", texture = 0 },
        ["bags_1"] = { name = "bag", item = 0 },
        ["bags_2"] = { name = "bag", texture = 0 },
        ["ears_1"] = { name = "ear", item = 0 },
        ["ears_2"] = { name = "ear", texture = 0 },
        ["glasses_1"] = { name = "glass", item = 0 },
        ["glasses_2"] = { name = "glass", texture = 0 },
        ["age_1"] = { name = "ageing", item = 0 },
        ["age_2"] = { name = "ageing", texture = 0 },
        ["watches_1"] = { name = "watch", item = 0 },
        ["watches_2"] = { name = "watch", texture = 0 },
        ["mask_1"] = { name = "mask", item = 0 },
        ["mask_2"] = { name = "mask", texture = 0 },
        ["helmet_1"] = { name = "hat", item = 0 },
        ["helmet_2"] = { name = "hat", texture = 0 },
        ["nose_0"] = { name = "nose_0", item = 0 },
        ["nose_1"] = { name = "nose_1", item = 0 },
        ["nose_2"] = { name = "nose_2", item = 0 },
        ["nose_3"] = { name = "nose_3", item = 0 },
        ["nose_4"] = { name = "nose_4", item = 0 },
        ["nose_5"] = { name = "nose_5", item = 0 },
        ["moles_1"] = { name = "moles", item = 0 },
        ["moles_2"] = { name = "moles", texture = 0 },
        ["hair_1"] = { name = "hair", item = 0 },
        ["hair_2"] = { name = "hair", texture = 0 },
        ["eyebrows_1"] = { name = "eyebrows", item = 0, },
        ["eyebrows_2"] = { name = "eyebrows", texture = 0, },
        ["beard_1"] = { name = "beard", item = 0, },
        ["beard_2"] = { name = "beard", texture = 0, },
        ["eye_opening"] = { name = "nose", item = 0, id = 1 },
        ["jaw_bone_width"] = { name = "jaw_bone_width", item = 0, },
        ["jaw_bone_back_lenght"] = { name = "jaw_bone_back_lenght", item = 0, },
        ["lips_thickness_1"] = { name = "lips_thickness", item = 0, },
        ["lips_thickness_2"] = { name = "lips_thickness", texture = 0 },
        ["cheek_1"] = { name = "cheek_1", item = 0, },
        ["cheek_2"] = { name = "cheek_2", item = 0, },
        ["cheek_3"] = { name = "cheek_3", item = 0, },
        ["eyebrown_high"] = { name = "eyebrown_high", item = 0, },
        ["eyebrown_forward"] = { name = "eyebrown_forward", item = 0, },
        ["chimp_bone_lowering"] = { name = "chimp_bone_lowering", item = 0, },
        ["chimp_bone_lenght"] = { name = "chimp_bone_lenght", item = 0, },
        ["chimp_bone_width"] = { name = "chimp_bone_width", item = 0, },
        ["chimp_hole"] = { name = "chimp_hole", item = 0, },
        ["neck_thikness"] = { name = "neck_thikness", item = 0, },

        ["blush_1"] = { name = "blush", item = 0, },
        ["blush_2"] = { name = "blush", texture = 0 },
        ["lipstick_1"] = { name = "lipstick", item = 0, },
        ["lipstick_2"] = { name = "lipstick", texture = 0 },
        ["makeup_1"] = { name = "makeup", item = 0, },
        ["makeup_2"] = { name = "makeup", texture = 0 },
        ["bracelets_1"] = { name = "bracelet", item = 0, },
        ["bracelets_2"] = { name = "bracelet", texture = 0 },
    }

    SkinDataForQBCore = {}

    function ConvertSkinToQB(skin, cb)
        TriggerEvent(Config.ESXCallbacks['skinchanger:getSkin'], function(pSkin)
            local SkinDataQB = deepCopy(SkinDataForQBCore)
            for k, v in pairs(skin) do
                local SkinMetaData = SkinMetaData[k]
                if SkinMetaData then
                    if not SkinDataQB[SkinMetaData.name] then
                        SkinDataQB[SkinMetaData.name] = {
                            item = 1,
                            texture = 0,
                            defaultItem = 0,
                            defaultTexture = 0,
                            id = 1,
                        }
                    end
                    local data = SkinDataQB[SkinMetaData.name]

                    if SkinMetaData.id then
                        data.id = v
                    end

                    if SkinMetaData.item then
                        data.item = v
                        --data.texture = 0
                    end
                    if SkinMetaData.texture then
                        data.texture = v
                    end
                end
            end

            for k, v in pairs(pSkin) do
                if not SkinDataQB[k] then
                    SkinDataQB[k] = v
                end
            end

            SkinDataForQBCore = SkinDataQB
            cb(SkinDataForQBCore)
        end)
    end

    function ConvertSkinToSkinChanger(pSkin, cb)
        local newPlayerSkin = {}
        for k, v in pairs(SkinMetaData) do
            if pSkin[v.name] then
                local skinValue = pSkin[v.name]

                if v.item then
                    newPlayerSkin[k] = skinValue.item
                end
                if v.texture then
                    newPlayerSkin[k] = skinValue.texture
                end
            end
        end

        if cb then
            newPlayerSkin.sex = GetEntityModel(PlayerPedId()) == GetHashKey("mp_m_freemode_01") and 0 or 1

            cb(newPlayerSkin)
        end
    end

    ----------
    function LoadPlayerSkin(data)
        ConvertSkinToQB(data, function(skin)
            TriggerEvent("qb-clothing:client:loadPlayerClothing", skin)
        end)
    end

    function LoadPlayerClothes(skin, data)
        ConvertSkinToQB(skin, function(skin)
            TriggerEvent("qb-clothing:client:loadPlayerClothing", skin)
        end)
    end

    function GetPlayerSkin(cb)
        TriggerEvent(Config.ESXCallbacks['skinchanger:getSkin'], function(pSkin)
            ConvertSkinToSkinChanger(pSkin, cb)
        end)
    end

    ----------
    function SavePlayerSkin(skin)
        local model = GetEntityModel(PlayerPedId())
        ConvertSkinToQB(skin, function(skin)
            TriggerServerEvent("qb-clothing:saveSkin", model, json.encode(skin))
        end)
    end

    function SetPlayerLastSkin(skin)
        TriggerEvent(Config.ESXCallbacks['esx_skin:setLastSkin'], skin)
    end

    ----------
end

if SkinChanger == "4" then
    function SetPlayerSkin(skin)
        local ped = PlayerPedId()
        local characterModel
        if skin.sex == 1 then
            characterModel = GetHashKey('mp_f_freemode_01')
        else
            characterModel = GetHashKey('mp_m_freemode_01')
        end

        if GetEntityModel(PlayerPedId()) ~= characterModel then
            exports["fivem-appearance"]:setPlayerModel(characterModel)
        end

        exports["fivem-appearance"]:setPedHeadOverlays(ped, {
            ["complexion"] = {
                ["style"] = skin.complexion_1 or 0, -- complexion_1
                ["color"] = skin.complexion_2 or 0, -- complexion_2
                ["opacity"] = skin.complexion_3 or 0, -- complexion_3
            },
            ["blemishes"] = {
                ["style"] = skin.blemishes_1 or 0, -- blemishes_1
                ["color"] = skin.blemishes_2 or 0, -- blemishes_2
                ["opacity"] = skin.blemishes_3 or 0, -- blemishes_3
            },
            ["makeUp"] = {
                ["style"] = skin.makeup_1 or 0, -- makeup_1
                ["color"] = skin.makeup_2 or 0, -- makeup_2
                ["opacity"] = skin.makeup_3 or 0, -- makeup_3
            },
            ["moleAndFreckles"] = {
                ["style"] = skin.moles_1 or 0, -- moles_1
                ["color"] = skin.moles_2 or 0, -- moles_2
                ["opacity"] = skin.moles_3 or 0, -- moles_3
            },
            ["ageing"] = {
                ["style"] = skin.age_1 or 0, -- age_1
                ["color"] = skin.age_2 or 0, -- age_2
                ["opacity"] = skin.age_3 or 0, -- age_3
            },
            ["beard"] = {
                ["style"] = skin.beard_1 or 0, -- beard_1
                ["color"] = skin.beard_2 or 0, -- beard_2
                ["opacity"] = skin.beard_3 or 0, -- beard_3
            },
            ["lipstick"] = {
                ["style"] = skin.lipstick_1 or 0, -- lipstick_1
                ["color"] = skin.lipstick_2 or 0, -- lipstick_2
                ["opacity"] = skin.lipstick_3 or 0, -- lipstick_3
            },
            ["bodyBlemishes"] = {
                ["style"] = skin.bodyb_1 or 0, -- bodyb_1
                ["color"] = skin.bodyb_2 or 0, -- bodyb_2
                ["opacity"] = skin.bodyb_3 or 0, -- bodyb_3
            },
            ["eyebrows"] = {
                ["style"] = skin.eyebrows_1 or 0, -- eyebrows_1
                ["color"] = skin.eyebrows_2 or 0, -- eyebrows_2
                ["opacity"] = skin.eyebrows_3 or 0, -- eyebrows_3
            },
            ["chestHair"] = {
                ["style"] = skin.chest_1 or 0, -- chest_1
                ["color"] = skin.chest_2 or 0, -- chest_2
                ["opacity"] = skin.chest_3 or 0, -- chest_3
            },
            ["sunDamage"] = {
                ["style"] = skin.sun_1 or 0, -- sun_1
                ["color"] = skin.sun_2 or 0, -- sun_2
                ["opacity"] = skin.sun_3 or 0, -- sun_3
            },
            ["blush"] = {
                ["style"] = skin.blush_1 or 0, -- blush_1
                ["color"] = skin.blush_2 or 0, -- blush_2
                ["opacity"] = skin.blush_3 or 0, -- blush_3
            },
        })

        exports["fivem-appearance"]:setPedHair(ped, {
            ["style"] = skin.hair_1, -- hair_1
            ["color"] = skin.hair_2, -- hair_2
            ["highlight"] = skin.hair_3, -- hair_3
        })

        exports["fivem-appearance"]:setPedProps(ped, {
            [1] = {
                ["drawable"] = skin.helmet_1 or -1, -- helmet_1
                ["texture"] = skin.helmet_2 or -1, -- helmet_2
                ["prop_id"] = 0, -- hat
            },
            [2] = {
                ["drawable"] = skin.glasses_1 or -1, -- glasses_1
                ["texture"] = skin.glasses_2 or -1, -- glasses_2
                ["prop_id"] = 1, -- glasses
            },
            [3] = {
                ["drawable"] = skin.ears_1 or -1, -- ears_1
                ["texture"] = skin.ears_2 or -1, -- ears_2
                ["prop_id"] = 2, -- ear
            },
            [4] = {
                ["drawable"] = skin.watches_1 or -1, -- watches_1
                ["texture"] = skin.watches_2 or -1, -- watches_2
                ["prop_id"] = 6, -- watch
            },
            [5] = {
                ["drawable"] = skin.bracelets_1 or -1, --bracelets_1
                ["texture"] = skin.bracelets_2 or -1, --bracelets_2
                ["prop_id"] = 7, -- Bracelet
            },
        })

        exports["fivem-appearance"]:setPedComponents(ped, {
            [1] = {
                ["component_id"] = 0, -- face
                ["texture"] = 0, -- doesnt do anything?
                ["drawable"] = 0, -- doesnt do anything?
            },
            [2] = {
                ["component_id"] = 1, -- mask
                ["texture"] = skin.mask_2, -- mask_2
                ["drawable"] = skin.mask_1, -- mask_1
            },
            [3] = {
                ["component_id"] = 2, -- hair
                ["texture"] = 0, -- doesnt do anything?
                ["drawable"] = 0, -- doesnt do anything?
            },
            [4] = {
                ["component_id"] = 3, -- arms / torso
                ["texture"] = 0, -- arms
                ["drawable"] = skin.arms, -- arms
            },
            [5] = {
                ["component_id"] = 4, -- leg / pants
                ["texture"] = skin.pants_2, -- pants_2
                ["drawable"] = skin.pants_1, -- pants_1
            },
            [6] = {
                ["component_id"] = 5, -- parachute / bags
                ["texture"] = skin.bags_2, -- bags_2
                ["drawable"] = skin.bags_1, -- bags_1
            },
            [7] = {
                ["component_id"] = 6, -- / shoes
                ["texture"] = skin.shoes_2, -- shoes_2
                ["drawable"] = skin.shoes_1, -- shoes_1
            },
            [8] = {
                ["component_id"] = 7, -- Accessory / chains
                ["texture"] = skin.chain_2, -- chain_2
                ["drawable"] = skin.chain_1, -- chain_1
            },
            [9] = {
                ["component_id"] = 8, -- Undershirt / tshirt
                ["texture"] = skin.tshirt_2, -- tshirt_2
                ["drawable"] = skin.tshirt_1, -- tshirt_1
            },
            [10] = {
                ["component_id"] = 9, -- Kevlar / bproof
                ["texture"] = skin.bproof_2, --bproof_2
                ["drawable"] = skin.bproof_1, --bproof_1
            },
            [11] = {
                ["component_id"] = 10, -- Badge / decals
                ["texture"] = skin.decals_2, -- decals_2
                ["drawable"] = skin.decals_1, -- decals_1
            },
            [12] = { -- shirt / torso
                ["component_id"] = 11, -- Torso 2 / torso
                ["texture"] = skin.torso_2, -- torso_2
                ["drawable"] = skin.torso_1, -- torso_1
            },
        })
    end

    ----------
    function LoadPlayerSkin(data)
        SetPlayerSkin(data)
    end

    function LoadPlayerClothes(skin, data)
        SetPlayerSkin(skin)
    end

    function GetPlayerSkin(cb)
        local data = exports["fivem-appearance"]:getPedAppearance(PlayerPedId())
        local convertedData = {}

        ---

        convertedData["complexion_1"] = data.headOverlays["complexion"].style or 0
        convertedData["complexion_2"] = data.headOverlays["complexion"].color or 0
        convertedData["complexion_3"] = data.headOverlays["complexion"].opacity or 0

        convertedData["blemishes_1"] = data.headOverlays["blemishes"].style or 0
        convertedData["blemishes_2"] = data.headOverlays["blemishes"].color or 0
        convertedData["blemishes_3"] = data.headOverlays["blemishes"].opacity or 0

        convertedData["makeup_1"] = data.headOverlays["makeUp"].style or 0
        convertedData["makeup_2"] = data.headOverlays["makeUp"].color or 0
        convertedData["makeup_3"] = data.headOverlays["makeUp"].opacity or 0

        convertedData["moles_1"] = data.headOverlays["moleAndFreckles"].style or 0
        convertedData["moles_2"] = data.headOverlays["moleAndFreckles"].color or 0
        convertedData["moles_3"] = data.headOverlays["moleAndFreckles"].opacity or 0

        convertedData["age_1"] = data.headOverlays["ageing"].style or 0
        convertedData["age_2"] = data.headOverlays["ageing"].color or 0
        convertedData["age_3"] = data.headOverlays["ageing"].opacity or 0

        convertedData["beard_1"] = data.headOverlays["beard"].style or 0
        convertedData["beard_2"] = data.headOverlays["beard"].color or 0
        convertedData["beard_3"] = data.headOverlays["beard"].opacity or 0

        convertedData["lipstick_1"] = data.headOverlays["lipstick"].style or 0
        convertedData["lipstick_2"] = data.headOverlays["lipstick"].color or 0
        convertedData["lipstick_3"] = data.headOverlays["lipstick"].opacity or 0

        convertedData["bodyb_1"] = data.headOverlays["bodyBlemishes"].style or 0
        convertedData["bodyb_2"] = data.headOverlays["bodyBlemishes"].color or 0
        convertedData["bodyb_3"] = data.headOverlays["bodyBlemishes"].opacity or 0

        convertedData["eyebrows_1"] = data.headOverlays["eyebrows"].style or 0
        convertedData["eyebrows_2"] = data.headOverlays["eyebrows"].color or 0
        convertedData["eyebrows_3"] = data.headOverlays["eyebrows"].opacity or 0

        convertedData["chest_1"] = data.headOverlays["chestHair"].style or 0
        convertedData["chest_2"] = data.headOverlays["chestHair"].color or 0
        convertedData["chest_3"] = data.headOverlays["chestHair"].opacity or 0

        convertedData["sun_1"] = data.headOverlays["sunDamage"].style or 0
        convertedData["sun_2"] = data.headOverlays["sunDamage"].color or 0
        convertedData["sun_3"] = data.headOverlays["sunDamage"].opacity or 0

        convertedData["blush_1"] = data.headOverlays["blush"].style or 0
        convertedData["blush_2"] = data.headOverlays["blush"].color or 0
        convertedData["blush_3"] = data.headOverlays["blush"].opacity or 0

        ---

        convertedData["model"] = data.model or "mp_m_freemode_01"
        
        convertedData["sex"] = data.model == "mp_m_freemode_01" and 0 or 1

        convertedData["hair_1"] = data.hair.style or -1
        convertedData["hair_2"] = data.hair.color or -1
        convertedData["hair_3"] = data.hair.highlight or -1

        ---

        for k, v in pairs(data.props) do
            if v.prop_id == 0 then
                convertedData["helmet_1"] = v.drawable or -1
                convertedData["helmet_2"] = v.texture or -1
            end

            if v.prop_id == 1 then
                convertedData["glasses_1"] = v.drawable or -1
                convertedData["glasses_2"] = v.texture or -1
            end

            if v.prop_id == 2 then
                convertedData["ears_1"] = v.drawable or -1
                convertedData["ears_2"] = v.texture or -1
            end

            if v.prop_id == 6 then
                convertedData["watches_1"] = v.drawable or -1
                convertedData["watches_2"] = v.texture or -1
            end

            if v.prop_id == 7 then
                convertedData["bracelets_1"] = v.drawable or -1
                convertedData["bracelets_2"] = v.texture or -1
            end
        end

        ---

        for k, v in pairs(data.components) do
            if v.component_id == 1 then
                convertedData["mask_2"] = v.texture
                convertedData["mask_1"] = v.drawable
            end

            if v.component_id == 3 then
                --convertedData["arms"] = v.texture
                convertedData["arms"] = v.drawable
            end

            if v.component_id == 4 then
                convertedData["pants_2"] = v.texture
                convertedData["pants_1"] = v.drawable
            end

            if v.component_id == 5 then
                convertedData["bags_2"] = v.texture
                convertedData["bags_1"] = v.drawable
            end

            if v.component_id == 6 then
                convertedData["shoes_2"] = v.texture
                convertedData["shoes_1"] = v.drawable
            end

            if v.component_id == 7 then
                convertedData["chain_2"] = v.texture
                convertedData["chain_1"] = v.drawable
            end

            if v.component_id == 8 then
                convertedData["tshirt_2"] = v.texture
                convertedData["tshirt_1"] = v.drawable
            end

            if v.component_id == 9 then
                convertedData["bproof_2"] = v.texture
                convertedData["bproof_1"] = v.drawable
            end

            if v.component_id == 10 then
                convertedData["decals_2"] = v.texture
                convertedData["decals_1"] = v.drawable
            end

            if v.component_id == 11 then
                convertedData["torso_2"] = v.texture
                convertedData["torso_1"] = v.drawable
            end
        end

        ---

        cb(convertedData)
    end

    ----------
    function SavePlayerSkin(skin)
        TriggerServerEvent(Config.Fivem_AppearanceSaveEvent, exports["fivem-appearance"]:getPedAppearance(PlayerPedId()))
    end

    function SetPlayerLastSkin(skin)
        --TriggerEvent(Config.ESXCallbacks['esx_skin:setLastSkin'], skin)
    end
    ----------
end

function ResetStuff()
    SkinDataForQBCore = {}
end