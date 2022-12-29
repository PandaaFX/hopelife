// To add a new lang file you must declare the file on the last lines of index.html like: <script src="lang/en.js" type="text/javascript"></script>
if (Lang == undefined) {
	var Lang = [];
}
Lang['de'] = {
	confirm_buy_store: 'Wollen Sie diesen Laden wirklich kaufen? Preis: {0} ',
	confirm_sell_store: 'Wollen Sie Ihr Geschäft wirklich verkaufen? Alles wird gelöscht und dieser Vorgang kann nicht rückgängig gemacht werden.',
	modal_title: 'Sind Sie sich sicher?',
	confirm_buy_button_modal: 'Kaufen',
	confirm_sell_button_modal: 'Verkaufen',
	cancel_button_modal: 'Abbrechen',

	navbar_main_page: 'Ihr Geschäft',
	navbar_goods_page: 'Waren kaufen',
	navbar_hire_page: 'Zusteller anheuern',
	navbar_employee_page: 'Mitarbeiter',
	navbar_upgrades_page: 'Upgrades',
	navbar_bank_page: 'Kassierer',
	navbar_sell_btn: 'Geschäft verkaufen',
	navbar_close_btn: 'Schliessen',

	statistics_page_low_stock: 'Wenn Sie bei NIEDRIGEN Lagerbeständen bleiben, werden Sie Ihr Geschäft verlieren!',
	statistics_page_low_stock_2: 'Sie müssen die PRODUKTVARIETÄT Ihres Geschäfts erhöhen, sonst verlieren Sie es.!',
	statistics_page_stock: 'Lagerkapazität (Max: {0})',
	statistics_page_price: 'Preis',
	statistics_page_export_price: 'Exportpreis',
	statistics_page_set_price: 'Setpreis',
	statistics_page_export: 'Alle exportieren',
	statistics_page_title: "Statistik",
	statistics_page_desc: "Marktstatistik",
	statistics_page_money_earned: "Verdientes Geld insgesamt",
	statistics_page_money_spent: "Gesamtbetrag der Ausgaben",
	statistics_page_goods: "Waren gekauft",
	statistics_page_distance_traveled: "Zurückgelegte Strecke",
	statistics_page_total_visits: "Totale Besuche",
	statistics_page_customers: "Kunden",
	statistics_page_stock_title: 'Produkte auf Lager',
	statistics_page_stock_desc: 'Anzahl der Produkte in Ihrem Geschäft',

	goods_page_title: 'Waren kaufen',
	goods_page_desc: 'Hier kannst du Waren kaufen, um die Bestände deines Geschäftes aufzufüllen.',

	hire_page_title: 'Zusteller anheuern',
	hire_page_desc: 'Hier können Sie Jobs für Zusteller schaffen, die Waren zu Ihrem Markt bringen. Es ist wichtig, ein hohes Gehalt zu bieten, um die Leute zu ermutigen, den Job anzunehmen.',
	hire_page_form_job_name: "Jobname",
	hire_page_form_reward: "Gehalt",
	hire_page_form_amount: "Summe",
	hire_page_form: "Job erstellen",

	upgrades_page_title: "Upgrades",
	upgrades_page_desc: "Verwenden Sie Ihr Geld, um Ihren Rang zu verbessern und mehr Gewinn zu erzielen",

	jobs_page_select_product: 'Wählen Sie das Produkt',
	jobs_page_max_amount: 'Maximale Menge',
	jobs_page_cost: 'Kosten pro Stück',
	jobs_page_amount: 'Menge',
	jobs_page_start: 'Job ausführen',
	jobs_page_store_item: 'Aus dem Inventar speichern',

	market_items_stock: 'Lagerbestand',
	market_items_stock_full: 'Voll',
	market_items_buy_item: 'Artikel kaufen',
	filters_title: 'Filter',
	filters_name_placeholder: 'Filter per Artikelname',
	filters_name: 'Name:',
	filters_has_stock: 'Hat Lagerbestad:',
	filters_price: 'Preis:',
	filters_min: 'Min:',
	filters_max: 'Max:',
	filters_filter_btn: 'Filter',
	payment_method_title: 'Bezahlmethode',

	hire_page_stock_title: 'Produktmenge',

	contracts_page_reward: 'Belohnung',
	contracts_page_cost: 'Kosten total',
	contracts_page_item: 'Item',
	contracts_page_amount: 'Höhe',
	contracts_page_delete: 'Vertrag löschen',

	employees_title: 'Mitarbeiter',
	employees_desc: 'Einstellung von Mitarbeitern für Ihr Unternehmen',
	button_employee: 'Mitarbeiter einstellen',
	button_fire_employee: 'Mitarbeiter entlassen',
	button_give_comission: 'Provision geben',
	input_give_comission: 'Höhe der Provision',
	hired_date: 'Angeheuert am:',
	jobs_done: 'Erledigte Aufträge:',
	select_employee: 'Wähle einen Mitarbeiter',
	basic_access: 'Grundlegender Zugang',
	advanced_access: 'Fortgeschrittener Zugang',
	full_access: 'Vollständiger Zugang',

	upgrade_page_stock: 'Kapazität der Lagerbestände',
	upgrade_page_stock_desc: 'Erweitern Sie Ihre Lagerkapazität, um mehr Platz für Ihre Produkte zu erhalten. Ihre Produkte werden nur verkauft, wenn jemand in Ihr Geschäft kommt.',
	upgrade_page_truck: 'LKW Kapazität',
	upgrade_page_truck_desc: 'Rüsten Sie Ihre LKW-Kapazität auf, um einen besseren LKW für den Transport einer größeren Menge an Produkten zu erhalten. Du bekommst diesen Bonusbetrag, wenn du die Lieferung abgeschlossen hast.',
	upgrade_page_relationship: 'Beziehung',
	upgrade_page_relationship_desc: 'Je besser Ihre Beziehung zu den Lieferanten ist, desto besser werden die Einkaufspreise sein. Sie erhalten den Preisnachlass, wenn Sie einen neuen Auftrag beginnen.',
	upgrade_page_level: 'Level',
	upgrade_page_units: 'Einheiten',
	upgrade_page_capacity: 'Kapaizätät',
	upgrade_page_discount: 'Rabatt',
	upgrade_page_buy_upgrade: 'Upgrade',

	bank_page_title: "Kassierer",
	bank_page_desc: "Hier sehen Sie Ihren gesamten Geldfluss. Sie können Ihr Geld einzahlen und abheben",
	bank_page_price: 'Wert',
	bank_page_date: 'Datum',
	bank_page_hidden_balance: "Versteckte Bilanz anzeigen",
	bank_page_income_expenses: "Einnahmen / Ausgaben:",
	bank_page_total_money: "Geld insgesamt:",
	bank_page_withdraw: "Zum Zurückziehen klicken",
	bank_page_deposit: "Geld einzahlen",
	bank_page_amount: "Betrag",

	str_fill_field: "Füllen Sie dieses Feld aus",
	str_invalid_value: "Ungültiger Wert",
	str_more_than: "Muss größer oder gleich sein als {0}",
	str_less_than: "Muss kleiner oder gleich sein als {0}",

	str_rename_store:"Geschäft umbenennen",
	str_rename_store_desc:"Wählen Sie hier den Namen Ihres Geschäftse",
	btn_apply_rename:"Bestätigen",
	str_rename_store_name:"Name des Geschäfts",
	html_select_colors:`
		<option value="" selected disabled>Wähle eine Farbe</option>
		<option color_id="1">Rot</option>
		<option color_id="3">Blau</option>
		<option color_id="4">Weiß (Standart)</option>
		<option color_id="5">Gelb</option>
		<option color_id="7">Violet</option>
		<option color_id="8">Pink</option>
		<option color_id="15">Cyan</option>
		<option color_id="22">Grau</option>
		<option color_id="29">Dunkelblau</option>
		<option color_id="30">Dunkles Cyan</option>
		<option color_id="32">Hellblau</option>
		<option color_id="40">Dunkles Grau</option>
		<option color_id="46">Gold</option>
		<option color_id="47">Orange</option>
		<option color_id="83">Lila</option>
	`, // Change only the color names

	html_select_type:`
		<option value="" selected disabled>Wählen Sie einen Typ</option>
		<option blip_id="40">Haus</option>
		<option blip_id="50">Garage</option>
		<option blip_id="51">Drogen</option>
		<option blip_id="52">Markt (Standart)</option>
		<option blip_id="68">Abschleppwagen</option>
		<option blip_id="71">Barbier</option>
		<option blip_id="135">Kino</option>
		<option blip_id="226">Fahrrad</option>
		<option blip_id="227">Auto</option>
		<option blip_id="251">Flugzeug</option>
		<option blip_id="273">Hundeknochen</option>
		<option blip_id="361">Benzinkanister</option>
		<option blip_id="357">Dock</option>
	` // Change only the location names
};