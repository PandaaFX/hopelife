Config = {}

-- Format for the time when displaying log entries
Config.timeFormat = "%Y-%m-%dT%H:%M:%S"

-- Customize which server-side standard events to log
Config.events = {
	baseevents = {
		onPlayerDied = false,
		onPlayerKilled = false,
		onPlayerWasted = false,
		enteringVehicle = false,
		enteringAborted = false,
		enteredVehicle = false,
		leftVehicle = false
	},
	chat = {
		chatMessage = false
	},
	core = {
		playerConnecting = false,
		playerDropped = false
	}
}

-- Whether to store logs in the SQL database, which also enables console commands and the web UI
Config.enableDb = true

-- Discord webhook to post log messages to
--Config.webhook = ""

-- Include log timestamps in Discord messages
Config.includeTimestampInWebhookMessage = true

-- Realm or user list for HTTP handler authorization
Config.authorization = "realm1"
