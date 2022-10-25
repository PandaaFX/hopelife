Config = {}

Config.debug = false


--- SETTINGS FOR ESX
Config.esxSettings = {
    enabled = true,
}

--- SETTINGS FOR QBCORE
Config.qbSettings = {
    enabled = false,
    useNewQBExport = true, -- Make sure to uncomment the old export inside fxmanifest.lua if you're still using it
    -- Time between each refresh of dead players (in ms)
    deadPlayerRefreshTime = 15000,
}


-- Set a whitelist to only allow specific jobs to use the detective tools
Config.whitelist = {
    enabled = true,
    jobs = {
        'police',
        'ambulance',
        'fib',
        'lssd',
    }
}

Config.target = {
    enabled = false,
    system = 'qtarget' -- 'qtarget' or 'qb-target'  (Other systems might work as well)
}

-- Keybinds
Config.keybinds = {
    investigate = 'E'
}


-- Animations used while investigating
Config.animation = {
    enabled = true,
    dict = 'amb@medic@standing@tendtodead@idle_a',
    anim = 'idle_a',
}
