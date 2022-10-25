Config = {}

Config.Language = "Germany"

Config.DefaultKeyBindAccept = "y"

Config.DefaultKeyBindDecline = "n"

Config.CarryViaCommand = false -- You can trigger carry via event from some menu for example TriggerEvent("rtx_carry:Carry") for trigger carry with certain type selected for example TriggerEvent("rtx_carry:Carry", "1") Types 1-3

Config.CarryCommand = "carry"

Config.CarryMarker = true -- carry marker to requested player

Config.CarryLine = true -- carry line to requested player

Config.CarryInterfaceWhileCarryed = true -- interface when player is carryed

Config.CarryDistance = 5.0 -- maximum distance from player for carry

Config.CarryDistanceDraw = 5.0 --maximum distance of draw line and marker

Config.RequestDuration = 60 -- in seconds

Config.DisablePlayerKeyboard = false -- if you want disable player keyboard when is carryed

Config.AutoAcceptWhileDeath = true -- auto accept carry when player is death

Config.CarryDisabledInZones = false -- players cannot use carry in config zones if this is enabled

Config.CarryedPlayerCanStopCarry = true -- if carryed player can use /carry from stopping to be carryed

Config.PedTaskCancelImmediately  = true -- if you want use Immediately cancel

Config.StopCarryViaEvent = true -- enable if you want stop carry via event, for example for hospital respawn -- TriggerEvent("rtx_carry:StopCarryViaEvent") -- example trigger that event when player respawn

Config.CarryDisabledZones = {
	{coords = vector3(0.0, 0.0, 0.0), radius = 100.0},
}

-- EVENTS

function Notify(text)
	exports["mythic_notify"]:SendAlert("inform", text, 5000)
end