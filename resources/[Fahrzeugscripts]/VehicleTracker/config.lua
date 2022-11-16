
Config = {}

-- set this to true if you need debug messages
Config.isDebug = false

-- at which rate the blips should update (in ms) (lower numbers can affect network performance)
Config.syncInterval = 2500

-- time (in ms) in which to move the blips
Config.lerpTime = 250

-- set this to true if you are using ESX
Config.useESX = true

-- change this if you want another command (useESX needs to be set to true)
Config.menuCommand	= "track"
-- the button to open the menu (set to nil to not use it) (https://docs.fivem.net/docs/game-references/controls/)
Config.menuButton	= nil

Config.Strings = {
	trackerMenuTitle	= "Tracker Menu",
	trackerMenuDesc		= "Track your vehicles!",

	activeTrackersTitle	= "Active trackers",
	activeTrackersDesc	= "Shows a list of all active trackers.",

	ownedVehiclesTitle	= "Owned vehicles",
	ownedVehiclesDesc	= "Shows a list of all owned vehicles.",

	stopTrackerDesc		= "Stop tracking this vehicle.",
	startTrackerDesc	= "Start tracking this vehicle.",

	stopTrackerNotif	= "Stopped tracking %s",
	startTrackerNotif	= "Started tracking %s",
	trackingFailedNotif	= "Could not start tracking %s",

	noActiveTrackerNotif	= "There is no active tracker on %s"
}
