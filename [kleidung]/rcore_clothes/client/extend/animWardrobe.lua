function playWardrobeAnimation()
    local ped = PlayerPedId()
    local dict, anim = "mp_clothing@female@shirt", "try_shirt_positive_a"


    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(33)
    end

    TaskPlayAnim(ped, dict, anim, 8.0, 1.0, -1, 48, 0.0, false, false, false)
end