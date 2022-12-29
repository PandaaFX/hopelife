Citizen.CreateThread(function()
    print("Script is waiting 10 seconds before starting")
    Citizen.Wait(10000)
    print("Starting scripts...")
    for k,v in pairs(Config.Scripts) do
        if v.anticheat == false then
            if v.name ~= "" then
                print("Starting: " .. v.name)
                func_startres(v.name)
                Citizen.Wait(2000)
            end
        end
    end
    Citizen.Wait(2000)
    print("Starting anticheats...")
    for k,v in pairs(Config.Scripts) do
        if v.anticheat == true then
            if v.name ~= "" then
                print("Starting: " .. v.name)
                func_startres(v.name)
                Citizen.Wait(2000)
            end
        end
    end
end)


function func_startres(resname)
    print(resname)
    StartResource(resname)
end