Config, Locales = {}, {}

Config.Debug = false -- This help find the source of a problem 

Config.OnlyUnpaidCityInvoices = false

Config.OnlyUnpaidSocietyInvoices = false

Config.EventPrefix = 'okokBilling'

Config.Locale = 'de'

Config.DatabaseTable = 'okokbilling'

Config.OpenMenuKey = 56 -- Default 168 (F7)

Config.OpenMenuCommand = 'invoices' -- Command to open the menu

Config.InvoiceDistance = 15

Config.AllowPlayersInvoice = false -- if players can create Player to Player invoices

Config.okokRequests = false -- Player to Player invoices only, to avoid abuse

Config.AuthorReceivesAPercentage = false -- When sending a society invoice

Config.AuthorPercentage = 10 -- Percentage that the invoice author receives

Config.VATPercentage = 5

Config.SocietyReceivesLessWithVAT = false

Config.AddonAccount = true -- If set to true it will use the addon_account_data table in the database, if set to false it will use the okokBanking tables

Config.SocietyHasSocietyPrefix = true -- *Do not touch this if the resource is working correctly* If set to true it'll search for `society_police` (example) when paying a society invoice

-- Autopay

Config.UseAutoPay = true

Config.DefaultLimitDate = 7 -- Days for limit pay date

Config.CheckForUnpaidInvoicesEvery = 30 -- minutes

Config.FeeAfterEachDay = true

Config.FeeAfterEachDayPercentage = 5

-- Autopay

Config.JobsWithCityInvoices = { -- Which jobs have City Invoices (They will be allowed to delete any invoice) | Admins will have access by default
	'doj'
}

Config.CityInvoicesAccessRanks = { -- Which jobs have City Invoices (They will be allowed to delete any invoice)
	'boss' -- All of them have access
}

Config.AllowedSocieties = { -- Which societies can access the Society Invoices
	'police',
	'ambulance',--Ambulance rank zu boss
	'bauamt',
	'casino',
	'fib',
	'hookahlounge',
	'kurant',--Ambulance rank zu boss
	'lssd',
	'wein',
	'mechanic',
	'club',
	'unicorn',
	'doj',
	--Gangs
	'18th',
	'saints',
	'lcn',
	'sinaloa',
	'soa',
	'outlaws',
	'tribunal',
	'che'

}

Config.InspectCitizenSocieties = { -- Which societies can access the Society Invoices
	'police',
	'fib',
	'lssd'
}

Config.SocietyAccessRanks = { -- Which ranks of the society have access to Society Invoices and City Invoices
	'boss',
	'chief',

}

Config.BillsList = {
	['police'] = {
		{'§2.1 Mord', 500000},
		{'§2.1.1 Versuchter Mord', 300000},
		{'§2.2 Totschlag', 250000},
		{'§2.2.1 Versuchter Totschlag', 200000},
		{'§2.3 Körperverletzung', 80000},
		{'§2.4 Gefährliche Körperverletzung', 120000},
		{'§2.6 Unterlassene Hilfeleistung', 30000},
		{'§3 Freiheitsberaubung', 50000},
		{'§3.1 Beamten Beleidigung', 40000},
		{'§3.1.1 Mehrfache Beamten Beleidigung ', 90000},
		{'§3.2 Erpressung', 90000},
		{'§3.3 Beleidigung', 25000},
		{'§3.4 Bedrohung', 60000},
		{'§3.5 Geiselnahme', 120000},
		{'§3.6 Nötigung', 30000},
		{'§3.7 Meineid', 130000},
		{'§4.1 Belästigung', 40000},
		{'§4.2 Sexuelle Belästigung', 90000},
		{'§4.3 Erregung öffentlichen Ärgernisses', 35000},
		{'§5.1 Diebstahl KFZ und Alg.', 50000},
		{'§5.2 Raub', 80000},
		{'§5.3 Schwerer Raub', 120000},
		{'§5.4 Betrug', 40000},
		{'§6.1 Leichte Sachbeschädigung', 35000},
		{'§6.1.1 Schwere Sachbeschädigung', 45000},
		{'§6.2 Widerstand gegen die Staatsgewalt', 45000},
		{'§6.3 Amtsanmaßung', 100000},
		{'§6.5 Tragen einer Vermummung', 20000},
		{'§6.6 Verweigerung der Identitätsfeststellung', 30000},
		{'§6.7 Betreten einer Sperrzone', 50000},
		{'§6.7.1 Durchbrechen von Absperrungen', 30000},
		{'§6.8 Verstoß gegen Auflagen', 80000},
		{'§7.1 Terroristischer Akt', 450000},
		{'§7.2 Gefangenenbefreiung', 80000},
		{'§7.3 Durchbrechen von PKW Absperrungen', 50000},
		{'§8.1 Besitz von Schwarzgeld', 60000},
		{'§8.2 Verkauf von Schwarzgeld', 120000},
		{'§8.3 Vortäuschen einer Straftat', 50000},
		{'§9 Sachbeschädigung an Städtischen Objekten ', 50000},
		{'§10.1 Herrstellen von Betäubungsmitteln', 70000},
		{'§10.2 Ankauf/Verkauf von Betäubungsmitteln', 50000},
		{'§10.3 Besitz von Betäubungsmitteln Menge -200', 35000},
		{'§10.4 Besitz von Betäubungsmitteln Menge +200', 65000},
		{'§11.1 unerlaubter Waffenbesitz', 50000},
		{'§11.2 Benutzung unerlaubter Waffen', 80000},
		{'§11.3 Verkauf unerlaubter Waffen', 75000},
		{'§13.1 Fahren ohne Fahrerlaubnis', 25000},
		{'§13.2 Schwerer Eingriff in den Straßenverkehr', 25000},
		{'§13.3 Geschwindigkeitsüberschreitung 50-100', 15000},
		{'§13.4 Geschwindigkeitsüberschreitung 100+', 25000},
		{'§13.5 Falsch Parken', 15000},
		{'Custom'}, -- If set without a price it'll let the players create a custom invoice (custom price)
	},
	['fib'] = {
		{'§2.1 Mord', 500000},
		{'§2.1.1 Versuchter Mord', 300000},
		{'§2.2 Totschlag', 250000},
		{'§2.2.1 Versuchter Totschlag', 200000},
		{'§2.3 Körperverletzung', 80000},
		{'§2.4 Gefährliche Körperverletzung', 120000},
		{'§2.6 Unterlassene Hilfeleistung', 30000},
		{'§3 Freiheitsberaubung', 50000},
		{'§3.1 Beamten Beleidigung', 40000},
		{'§3.1.1 Mehrfache Beamten Beleidigung ', 90000},
		{'§3.2 Erpressung', 90000},
		{'§3.3 Beleidigung', 25000},
		{'§3.4 Bedrohung', 60000},
		{'§3.5 Geiselnahme', 120000},
		{'§3.6 Nötigung', 30000},
		{'§3.7 Meineid', 130000},
		{'§4.1 Belästigung', 40000},
		{'§4.2 Sexuelle Belästigung', 90000},
		{'§4.3 Erregung öffentlichen Ärgernisses', 35000},
		{'§5.1 Diebstahl KFZ und Alg.', 50000},
		{'§5.2 Raub', 80000},
		{'§5.3 Schwerer Raub', 120000},
		{'§5.4 Betrug', 40000},
		{'§6.1 Leichte Sachbeschädigung', 35000},
		{'§6.1.1 Schwere Sachbeschädigung', 45000},
		{'§6.2 Widerstand gegen die Staatsgewalt', 45000},
		{'§6.3 Amtsanmaßung', 100000},
		{'§6.5 Tragen einer Vermummung', 20000},
		{'§6.6 Verweigerung der Identitätsfeststellung', 30000},
		{'§6.7 Betreten einer Sperrzone', 50000},
		{'§6.7.1 Durchbrechen von Absperrungen', 30000},
		{'§6.8 Verstoß gegen Auflagen', 80000},
		{'§7.1 Terroristischer Akt', 450000},
		{'§7.2 Gefangenenbefreiung', 80000},
		{'§7.3 Durchbrechen von PKW Absperrungen', 50000},
		{'§8.1 Besitz von Schwarzgeld', 60000},
		{'§8.2 Verkauf von Schwarzgeld', 120000},
		{'§8.3 Vortäuschen einer Straftat', 50000},
		{'§9 Sachbeschädigung an Städtischen Objekten ', 50000},
		{'§10.1 Herrstellen von Betäubungsmitteln', 70000},
		{'§10.2 Ankauf/Verkauf von Betäubungsmitteln', 50000},
		{'§10.3 Besitz von Betäubungsmitteln Menge -200', 35000},
		{'§10.4 Besitz von Betäubungsmitteln Menge +200', 65000},
		{'§11.1 unerlaubter Waffenbesitz', 50000},
		{'§11.2 Benutzung unerlaubter Waffen', 80000},
		{'§11.3 Verkauf unerlaubter Waffen', 75000},
		{'§13.1 Fahren ohne Fahrerlaubnis', 25000},
		{'§13.2 Schwerer Eingriff in den Straßenverkehr', 25000},
		{'§13.3 Geschwindigkeitsüberschreitung 50-100', 15000},
		{'§13.4 Geschwindigkeitsüberschreitung 100+', 25000},
		{'§13.5 Falsch Parken', 15000},
		{'Custom'}, -- If set without a price it'll let the players create a custom invoice (custom price)
	},
	['lssd'] = {
		{'§2.1 Mord', 500000},
		{'§2.1.1 Versuchter Mord', 300000},
		{'§2.2 Totschlag', 250000},
		{'§2.2.1 Versuchter Totschlag', 200000},
		{'§2.3 Körperverletzung', 80000},
		{'§2.4 Gefährliche Körperverletzung', 120000},
		{'§2.6 Unterlassene Hilfeleistung', 30000},
		{'§3 Freiheitsberaubung', 50000},
		{'§3.1 Beamten Beleidigung', 40000},
		{'§3.1.1 Mehrfache Beamten Beleidigung ', 90000},
		{'§3.2 Erpressung', 90000},
		{'§3.3 Beleidigung', 25000},
		{'§3.4 Bedrohung', 60000},
		{'§3.5 Geiselnahme', 120000},
		{'§3.6 Nötigung', 30000},
		{'§3.7 Meineid', 130000},
		{'§4.1 Belästigung', 40000},
		{'§4.2 Sexuelle Belästigung', 90000},
		{'§4.3 Erregung öffentlichen Ärgernisses', 35000},
		{'§5.1 Diebstahl KFZ und Alg.', 50000},
		{'§5.2 Raub', 80000},
		{'§5.3 Schwerer Raub', 120000},
		{'§5.4 Betrug', 40000},
		{'§6.1 Leichte Sachbeschädigung', 35000},
		{'§6.1.1 Schwere Sachbeschädigung', 45000},
		{'§6.2 Widerstand gegen die Staatsgewalt', 45000},
		{'§6.3 Amtsanmaßung', 100000},
		{'§6.5 Tragen einer Vermummung', 20000},
		{'§6.6 Verweigerung der Identitätsfeststellung', 30000},
		{'§6.7 Betreten einer Sperrzone', 50000},
		{'§6.7.1 Durchbrechen von Absperrungen', 30000},
		{'§6.8 Verstoß gegen Auflagen', 80000},
		{'§7.1 Terroristischer Akt', 450000},
		{'§7.2 Gefangenenbefreiung', 80000},
		{'§7.3 Durchbrechen von PKW Absperrungen', 50000},
		{'§8.1 Besitz von Schwarzgeld', 60000},
		{'§8.2 Verkauf von Schwarzgeld', 120000},
		{'§8.3 Vortäuschen einer Straftat', 50000},
		{'§9 Sachbeschädigung an Städtischen Objekten ', 50000},
		{'§10.1 Herrstellen von Betäubungsmitteln', 70000},
		{'§10.2 Ankauf/Verkauf von Betäubungsmitteln', 50000},
		{'§10.3 Besitz von Betäubungsmitteln Menge -200', 35000},
		{'§10.4 Besitz von Betäubungsmitteln Menge +200', 65000},
		{'§11.1 unerlaubter Waffenbesitz', 50000},
		{'§11.2 Benutzung unerlaubter Waffen', 80000},
		{'§11.3 Verkauf unerlaubter Waffen', 75000},
		{'§13.1 Fahren ohne Fahrerlaubnis', 25000},
		{'§13.2 Schwerer Eingriff in den Straßenverkehr', 25000},
		{'§13.3 Geschwindigkeitsüberschreitung 50-100', 15000},
		{'§13.4 Geschwindigkeitsüberschreitung 100+', 25000},
		{'§13.5 Falsch Parken', 15000},
		{'Custom'}, -- If set without a price it'll let the players create a custom invoice (custom price)
	},
	['ambulance'] = {
		{'Anfahrt innerhalb der Stadt', 10000},
		{'Anfahrt außerhalb der Stadt', 20000},
		{'Anfahrt Cayo', 40000},
		{'Luftrettung', 50000},
		{'Wiederbelebung', 2000},
		{'Kleine Behandlung vor Ort', 10000},
		{'große Behandlung vor Ort', 16000},
		{'Röntgen', 20000},
		{'MRT', 20000},
		{'OP (Klein)', 60000},
		{'OP (Groß)', 90000},
		{'Custom'},
	},
	['doj'] = {
		{'Custom'}
	},
	['unicorn'] = {
		{'Custom'}
	},
	['club'] = {
		{'Custom'}
	},
	['mechanic'] = {
		{'Custom'}
	},
	['wein'] = {
		{'Custom'}
	},
	['kurant'] = {
		{'Custom'}
	},
	['hookahlounge'] = {
		{'Custom'}
	},
	['bauamt'] = {
		{'Custom'}
	},
	['18th'] = {
		{'Custom'}
	},
	['saints'] = {
		{'Custom'}
	},
	['lcn'] = {
		{'Custom'}
	},
	['sinaloa'] = {
		{'Custom'}
	},
	['soa'] = {
		{'Custom'}
	},
	['outlaws'] = {
		{'Custom'}
	},
	['tribunal'] = {
		{'Custom'}
	},
	['che'] = {
		{'Custom'}
	},
}

Config.AdminGroups = {
	'admin',
	'dev'
}

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to sv_utils.lua, line 5

Config.BotName = 'Finanzamt' -- Write the desired bot name

Config.ServerName = 'Hopelife' -- Write your server's name

Config.IconURL = '' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.CreatePersonalInvoiceWebhookColor = '65535'

Config.CreateJobInvoiceWebhookColor = '16776960'

Config.CancelInvoiceWebhookColor = '16711680'

Config.PayInvoiceWebhookColor = '65280'

-------------------------- LOCALES (DON'T TOUCH)

function _L(id) 
	if Locales[Config.Locale][id] then 
		return Locales[Config.Locale][id] 
	else 
		print('Locale '..id..' doesn\'t exist') 
	end 
end