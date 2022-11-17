function MakeItRainAnimation()
    local player = PlayerPedId()
    local model = lib.LoadModel("prop_anim_cash_note_b")
    local pos = GetPedBoneCoords(player, 28422, 0.0, 0.0, 0.0)
    local cash = {}
    for i = 1, 3 do
        cash[i] = CreateObject(model.model, pos, true, false, false)
    end

    local scene = NetworkCreateSynchronisedScene(GetEntityCoords(player), 0.0, 0.0, GetEntityHeading(player), 0, false, false, 1065353216, 0, 1065353216)
    NetworkAddPedToSynchronisedScene(player, scene, LoadDict("mini@strip_club@leaning@toss_many"), "toss_many_player", 8.0, -2.0, 8, 0, 1148846080, 0)
    for i, obj in pairs(cash) do 
        NetworkAddEntityToSynchronisedScene(obj, scene, LoadDict("mini@strip_club@leaning@toss_many"), "toss_many_note_0" .. i, 8.0, -2.0, 137)
    end   

    NetworkStartSynchronisedScene(scene)

    while not IsSynchronizedSceneRunning(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) do
        Wait(0)
    end
    while IsSynchronizedSceneRunning(NetworkConvertSynchronisedSceneToSynchronizedScene(scene)) do
        Wait(0)
    end

    NetworkStopSynchronisedScene(scene)
    
    for _, obj in pairs(cash) do 
        DeleteEntity(obj) 
    end    

    ClearPedTasks(player)
end

function TossAnimation()
    local player = PlayerPedId()
    local female = GetEntityModel(player) == `mp_f_freemode_01` and "_female" or ""
    local model = lib.LoadModel("prop_anim_cash_note_b")
    local pos = GetPedBoneCoords(player, 28422, 0.0, 0.0, 0.0)

    local cash = CreateObject(model.model, pos, true, false, false)
    SetEntityVisible(cash, false)
    AttachEntityToEntity(cash, player, GetPedBoneIndex(player, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)

    TaskPlayAnim(player, LoadDict("mini@strip_club@leaning@toss"), "toss"..female, 8.0, -8.0, -1, 2, 0, false, false, false)
    Wait(100)
    SetEntityVisible(cash, true)
    
    Wait(1000)
    DeleteEntity(cash)
end

function PlayMixAnimation(coords)
    local player = PlayerPedId()
    SetEntityCoordsNoOffset(player, coords.xyz)
    SetEntityHeading(player, coords.w)
    TaskPlayAnim(player, LoadDict("mini@drinking"), "shots_barman_b", 8.0, -8.0, -1, 1, 0, false, false, false)
    Wait(7000)
    ClearPedTasks(player)
end