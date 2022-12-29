// To add a new lang file you must declare the file on the last lines of index.html like: <script src="lang/en.js" type="text/javascript"></script>
if (Lang == undefined) {
	var Lang = [];
}
Lang['en'] = {
	confirm_buy_store: 'Do you really want to buy this store? Price: {0} ',
	confirm_sell_store: 'Do you really want to sell your store? Everything will be deleted and this process cannot be undone.',
	modal_title: 'Are you sure?',
	confirm_buy_button_modal: 'Buy',
	confirm_sell_button_modal: 'Sell',
	cancel_button_modal: 'Cancel',

	navbar_main_page: 'Your Store',
	navbar_goods_page: 'Buy goods',
	navbar_hire_page: 'Hire deliveryman',
	navbar_employee_page: 'Employees',
	navbar_upgrades_page: 'Upgrades',
	navbar_bank_page: 'Cashier',
	navbar_sell_btn: 'Sell store',
	navbar_close_btn: 'Close',

	statistics_page_low_stock: 'Staying with LOW STOCK will make you lose your store!',
	statistics_page_low_stock_2: 'You need to increase your store\'s PRODUCT VARIETY or you will lose it!',
	statistics_page_stock: 'Stock Capacity (Max: {0})',
	statistics_page_price: 'Price',
	statistics_page_export_price: 'Export price',
	statistics_page_set_price: 'Set Price',
	statistics_page_export: 'Export All',
	statistics_page_title: "Statistics",
	statistics_page_desc: "Market statistics",
	statistics_page_money_earned: "Total money earned",
	statistics_page_money_spent: "Total money spent",
	statistics_page_goods: "Goods bought",
	statistics_page_distance_traveled: "Distance traveled",
	statistics_page_total_visits: "Total visits",
	statistics_page_customers: "Customers",
	statistics_page_stock_title: 'Products in stock',
	statistics_page_stock_desc: 'Amount of products your store has',

	goods_page_title: 'Buy goods',
	goods_page_desc: 'Here you can buy goods to supply the stock of your market',

	hire_page_title: 'Hire deliveryman',
	hire_page_desc: 'Here you can create jobs for deliveryman to bring goods to your market. It is important to put a high salary to encourage people to accept jobs.',
	hire_page_form_job_name: "Job name",
	hire_page_form_reward: "Reward",
	hire_page_form_amount: "Amount",
	hire_page_form: "Create job",

	upgrades_page_title: "Upgrades",
	upgrades_page_desc: "Use your money to improve your rank and get more profit",

	jobs_page_select_product: 'Select the product',
	jobs_page_max_amount: 'Max amount',
	jobs_page_cost: 'Unit cost',
	jobs_page_amount: 'Amount',
	jobs_page_start: 'Start Job',
	jobs_page_store_item: 'Store from inventory',

	market_items_stock: 'Stock',
	market_items_stock_full: 'Full',
	market_items_buy_item: 'Buy Item',
	filters_title: 'Filters',
	filters_name_placeholder: 'Filter by name',
	filters_name: 'Name:',
	filters_has_stock: 'Has stock:',
	filters_price: 'Price:',
	filters_min: 'Min:',
	filters_max: 'Max:',
	filters_filter_btn: 'Filter',
	payment_method_title: 'Payment method',

	hire_page_stock_title: 'Product Amount',

	contracts_page_reward: 'Reward',
	contracts_page_cost: 'Total cost',
	contracts_page_item: 'Item',
	contracts_page_amount: 'Amount',
	contracts_page_delete: 'Delete Contract',

	employees_title: 'Employees',
	employees_desc: 'Hire employees to work on your company',
	button_employee: 'Hire employee',
	button_fire_employee: 'Fire employee',
	button_give_comission: 'Give comission',
	input_give_comission: 'Comission amount',
	hired_date: 'Hired on:',
	jobs_done: 'Jobs done:',
	select_employee: 'Select a player',
	basic_access: 'Basic Access',
	advanced_access: 'Advanced Access',
	full_access: 'Full Access',

	upgrade_page_stock: 'Stock capacity',
	upgrade_page_stock_desc: 'Upgrade your stock capacity to get more room to store your products. Your products will be sold only when someone comes to your store.',
	upgrade_page_truck: 'Truck capacity',
	upgrade_page_truck_desc: 'Upgrade your truck capacity to get a better truck to transport a larger amount of products. You\'ll get this bonus amount when you finish the delivery.',
	upgrade_page_relationship: 'Relationship',
	upgrade_page_relationship_desc: 'The better is your relationship with suppliers the better will be the purchase prices. You\'ll get the dicount when you start a new job.',
	upgrade_page_level: 'Level',
	upgrade_page_units: 'units',
	upgrade_page_capacity: 'capacity',
	upgrade_page_discount: 'discount',
	upgrade_page_buy_upgrade: 'Upgrade',

	bank_page_title: "Cashier",
	bank_page_desc: "See all your cash flow here. You can deposit and withdraw your money",
	bank_page_price: 'Value',
	bank_page_date: 'Date',
	bank_page_hidden_balance: "Show Hidden Balance",
	bank_page_income_expenses: "Income / Expenses:",
	bank_page_total_money: "Total money:",
	bank_page_withdraw: "Click to withdraw",
	bank_page_deposit: "Deposit money",
	bank_page_amount: "Amount",

	str_fill_field: "Fill this field",
	str_invalid_value: "Invalid value",
	str_more_than: "Must be greater than or equal to {0}",
	str_less_than: "Must be less than or equal to {0}",

	str_rename_store:"Rename store",
	str_rename_store_desc:"Choose here the name of your store",
	btn_apply_rename:"Apply",
	str_rename_store_name:"Store name",
	html_select_colors:`
		<option value="" selected disabled>Pick a color</option>
		<option color_id="1">Red</option>
		<option color_id="3">Blue</option>
		<option color_id="4">White (Default)</option>
		<option color_id="5">Yellow</option>
		<option color_id="7">Violet</option>
		<option color_id="8">Pink</option>
		<option color_id="15">Cyan</option>
		<option color_id="22">Grey</option>
		<option color_id="29">Dark Blue</option>
		<option color_id="30">Dark Cyan</option>
		<option color_id="32">Lught Blue</option>
		<option color_id="40">Dark Grey</option>
		<option color_id="46">Gold</option>
		<option color_id="47">Orange</option>
		<option color_id="83">Purple</option>
	`, // Change only the color names

	html_select_type:`
		<option value="" selected disabled>Pick a type</option>
		<option blip_id="40">Safe House</option>
		<option blip_id="50">Garage</option>
		<option blip_id="51">Drugs</option>
		<option blip_id="52">Market (Default)</option>
		<option blip_id="68">Tow truck</option>
		<option blip_id="71">Barber</option>
		<option blip_id="135">Cinema</option>
		<option blip_id="226">Bike</option>
		<option blip_id="227">Car</option>
		<option blip_id="251">Plane</option>
		<option blip_id="273">Dog bone</option>
		<option blip_id="361">Jerry can</option>
		<option blip_id="357">Dock</option>
	` // Change only the location names
};