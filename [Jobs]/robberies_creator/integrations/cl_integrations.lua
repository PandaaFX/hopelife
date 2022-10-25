EXTERNAL_EVENTS_NAMES = {
    ["esx:getSharedObject"] = nil, -- This is nil because it will be found automatically, change it to your one ONLY in the case it can't be found
}

-- Ped models that WON'T be used for NPC mugging
BLACKLISTED_PEDS_MODELS = {
    --[[
        Some examples:
        
        [ GetHashKey("a_m_o_tramp_01") ] = true,
        [ GetHashKey("csb_rashcosvki") ] = true,
        [ GetHashKey("csb_stripper_02") ] = true,
    ]]
}

INTERACTION_POINTS_REFRESH = 1000

-- Key used to mug a NPC (you probably also want to change it in the locales files translation)
KEY_TO_MUG = 47

-- Key used to make an NPC to follow or to stay (you probably also want to change it in the locales files translation)
KEY_TO_FOLLOW = 74

-- Key used to make an NPC to go away in NPC mugging
KEY_TO_GO_AWAY = 20

-- Seconds the blip of police alert will remain in the map
BLIP_TIME_AFTER_POLICE_ALERT = 40

-- Seconds each time the gas will damage the player
GAS_INTERVAL_SECONDS = 1