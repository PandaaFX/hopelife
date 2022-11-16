Config = {}

Config.Framework = 'ESX' -- ESX / QB / STANDALONE

Config.UseNewStaffCheckMethod = false -- **QBCORE and ESX ONLY** true = will check if a player is staff in another way (this could fix problems with /repots command)

Config.QBPermissionsUpdate = false -- **QBCORE ONLY** - set it to true if you have the latest Permissions update

Config.ReportCommand = 'report' -- command for players to create a report

Config.AdminReportCommand = 'reports' -- command for admins to check the reports

Config.NotificationToggleCommand = 'rn' -- command to toggle the notifications

Config.UseSteamNames = true -- Uses the steam names insted of game names

Config.SaveRespondedReports = false -- This will save how many reports the admins complete in the database (for this you need to use the sql file and set your sql script in the fxmanifest.lua)

Config.Database = 'oxmysql' -- mysql-async / oxmysql / ghmattimysql (Used if Config.SaveRespondedReports is set to true)

Config.NoAdminAssistingText = 'None'

Config.TeleportBackAfterConcluding = true

Config.NewReportNotifyType = 'STANDALONE' -- QB or STANDALONE

Config.ReportCategoriesTranslation = { -- Translate report categories
	player = "REPORT PLAYER",
	bug = "BUG",
	question = "QUESTION"
}

Config.AdminGroups = { -- Used for ESX and QB
	'superadmin',
	'admin',
	'dev',
	'mod'
}

-- Used to set the admins when using the STANDALONE version
-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.StandaloneStaffIdentifiers = { 
	--'license:9asg8d9812g3989as8dy8912398123y89123y221', -- Example, change this
	--'license:09asyhhdh8912h389asgdhh912g389asgd98y123' -- Example, change this
}

Config.Notifications = {
	['success_rep'] = {title = 'REPORT', text = 'You successfully created a report', time = 5000, type = 'success'},
	['adm_answered'] = {title = 'REPORT', text = 'An admin answered you', time = 5000, type = 'info'},
	['player_answered'] = {title = 'REPORT', text = '#${id} - ${name}  answered you', time = 5000, type = 'info'},
	['adm_assist'] = {title = 'REPORT', text = 'An admin is assisting you', time = 5000, type = 'info'},
	['rep_concluded'] = {title = 'REPORT', text = 'Your report has been concluded', time = 5000, type = 'success'},
	['rep_canceled'] = {title = 'REPORT', text = 'You have canceled your report', time = 5000, type = 'error'},
	['adm_rep_concluded'] = {title = 'REPORT', text = 'Report #${id} has been concluded', time = 5000, type = 'success'},
	['new_rep'] = {title = 'REPORT', text = 'There is a new report', time = 5000, type = 'info'},
	['rep_not_on'] = {title = 'REPORT', text = 'You have turned report notifications ON!', time = 5000, type = 'success'},
	['rep_not_off'] = {title = 'REPORT', text = 'You have turned report notifications OFF!', time = 5000, type = 'error'},
	['rep_not_exist'] = {title = 'REPORT', text = 'This report does not exist!', time = 5000, type = 'error'},
}

Config.CommandSuggestions = {
	['report'] = {text = 'Command to create or check your report'},
	['adm_report'] = {text = 'Command to check opened reports'},
	['adm_notifications'] = {text = 'Command to activate/deactivate new reports notification'},
}

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to webhook.lua, line 1

Config.BotName = 'Reportbot-Hopelife' -- Write the desired bot name

Config.ServerName = 'Hopelife' -- Write your server's name

Config.IconURL = '' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

Config.ReportTitle = 'REPORT'

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.playerReportWebhookColor = '65280'

Config.bugReportWebhookColor = '16711680'

Config.questionReportWebhookColor = '49151'

Config.playerWebhookColor = '255'

Config.adminWebhookColor = '16746240'

Config.WebhookMessages = {
	-- Player
	['player_report'] = {action = 'Ticket geöffnet'},
	['bug_report'] = {action = 'Ticket wurde geöffnet!'},
	['question_report'] = {action = 'Ticket geöffnet'},
	['p_cancel_report'] = {action = 'Ticket abgebrochen', type = 'Report #${id}'},
	['p_answer_report'] = {action = 'Spieler hat im Ticket beantwortet', type = 'Ticket #${id}'},

	-- Admin
	['a_answer_report'] = {action = 'Admin hat im Ticket beantwortet', type = 'Ticket #${id}'},
	['a_bring_report'] = {action = 'Admin bringt den Spieler', type = 'Ticket #${id}'},
	['a_goto_report'] = {action = 'Admin teleportiert sich zum Spieler', type = 'Ticket #${id}'},
	['a_closed_report'] = {action = 'Admin hat das Ticket geschlossen', type = 'Ticket #${id}'},
}