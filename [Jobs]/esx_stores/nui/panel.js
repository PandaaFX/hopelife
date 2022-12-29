let lang;
let config;
let role = 0;
window.addEventListener('message', function (event) {
	var item = event.data;
	if (item.notification) {
		if (item.notification_type == "sucesso") {
			vt.successo(item.notification,{
				position: "top-right",
				duration: 8000
			});
		} else if (item.notification_type == "importante") {
			vt.importante(item.notification,{
				position: "top-right",
				duration: 8000
			});
		} else if (item.notification_type == "negado") {
			vt.erro(item.notification,{
				position: "top-right",
				duration: 8000
			});
		}
	} else if (item.price){
		$('#modal-p').empty();
		$('#modal-p').append(Lang[item.lang]['confirm_buy_store'].format(new Intl.NumberFormat(item.format.location, { style: 'currency', currency: item.format.currency }).format(item.price)));
		$('#modal-cancel-buy').text(Lang[item.lang]['cancel_button_modal']);
		$('#modal-confirm').text(Lang[item.lang]['confirm_buy_button_modal']);
		$('#modal-confirm-title').text(Lang[item.lang]['modal_title']);

		$("body").css("display", "");
		$(".main").css("display", "none");
		$(document).ready(function(){
			$("#buyModal").modal({show: true});
		});
	} else if (item.showmenu){
		config = item.dados.config;
		role = item.dados.role;
		lang = config.lang
		var store_jobs = item.dados.store_jobs;
		var store_business = item.dados.store_business;
		var store_balance = item.dados.store_balance;
		let store_employees = item.dados.store_employees;
		let players = item.dados.players;
		
		var arr_stock = JSON.parse(store_business.stock);
		var arr_stock_prices = JSON.parse(store_business.stock_prices);

		if (arr_stock_prices == false) {
			arr_stock_prices = {};
		}

		if (item.isMarket) {
			/*
			* SIDEBAR
			*/
			if(item.update != true){
				$('#nav-bar').empty();
				$('.market-pages').remove();
				for (const key in config.market_types.pagination) {
					$('.container-pages').append(`
						<div class="pages market-pages ${key}-page">
							<div class="container-fluid">
								<section id="minimal-statistics-main">
									<div class="row">
										<div class="col-9 mt-3 mb-1">
											<h4 class="text-uppercase">${config.market_types.pagination[key].page_name}</h4>
											<p>${config.market_types.pagination[key].page_desc}</p>
										</div>
									</div>
									<div class="market-list-container">
										<div id="market-products${key}" class="row">
											
										</div>
										<div class="filter-card">
											<div id="filter-items${key}" class="filters-container">
												
											</div>
											<div id="button-filter-items${key}" class="filters-container" style="align-self: end;">
												<button onclick="filterItems(${key})" class="btn btn-blue btn-darken-2 white btn-block">${Lang[lang]['filters_filter_btn']}</button>
											</div>
										</div>
									</div>
								</section>
							</div>
						</div>
					`);

					$('#nav-bar').append(`
						<li id="sidebar-${key}" onclick="openPage(${key})">
							${config.market_types.pagination[key].page_icon}
							<span class="tooltip">${config.market_types.pagination[key].page_name}</span>
						</li>
					`);
				}
				$('#nav-bar').append(`
					<li onclick="closeUI()">
						<i class="fas fa-times"></i>
						<span class="tooltip">${Lang[lang]['navbar_close_btn']}</span>
					</li>
				`);
				
				$("#imgcard").attr("src",config.market_locations.account.item[0].icon);
				$("#imgcash").attr("src",config.market_locations.account.item[1].icon);

				$(".pages").css("display", "none");
				$("#payments").css("display", "");
				$(".main").css("display", "");
				$(".market-page").css("display", "block");
				$('.sidebar-navigation ul li').removeClass('active');
				$('#sidebar-0').addClass('active');
				openPage(0);
			}

			for (const key in config.market_types.pagination) {
				$('#market-products'+key).empty();
			}

			/*
			* MARKET PAGE
			*/
			let min_price = {}
			let max_price = {}
			for (const key in config.market_types.pagination) {
				min_price[key] = -1
				max_price[key] = 0
			}

			for (const key in config.market_types.market_items) {
				var fkey = key.replace("|", "-x-");
				var item = config.market_types.market_items[key];

				if (store_business.stock === false) {
					stock_value = Lang[lang]['market_items_stock_full'];
				} else if(store_business.stock === true) {	
					stock_value = new Intl.NumberFormat(config.format.location).format(0);
				} else if(arr_stock[key] == undefined) {
					stock_value = new Intl.NumberFormat(config.format.location).format(0);
				} else {
					stock_value = new Intl.NumberFormat(config.format.location).format(arr_stock[key]);
				}
				if(arr_stock_prices[key] == undefined) {
					arr_stock_prices[key] = item.price_to_customer;
				}

				// Market itens
				$('#market-products'+item.page).append(`
					<div class="item-card col-6" data-price="${arr_stock_prices[key]}" data-stock="${stock_value}" data-name="${item.name}">
						<div class="card overflow-hidden w-auto">
							<div class="card-content">
								<div class="card-body cleartfix">
									<div class="media align-items-stretch">
										<div class="align-self-center">
											<img class="font-large-2 mr-2 " src="img/${item.img}" width="60">
										</div>
										<div class="media-body">
											<div>
												<h4 style="margin: 0;">${item.name}</h4>
												<h4 style="margin: 0;"><small>${Lang[lang]['market_items_stock']} (${stock_value})</small></h4>
											</div>
											<div class="market-item-content">
												<input id="input-${fkey}" type="number" min="1" max="${stock_value}" placeholder="${Lang[lang]['jobs_page_amount']}" name="amount" required="required">
												<h1 style="font-size: 2rem;">${new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency, maximumFractionDigits: 0, minimumFractionDigits: 0 }).format(arr_stock_prices[key]) }</h1>
											</div>
											<div>
												<button onclick="buyItem('${fkey}')" class="btn btn-blue btn-darken-2 white btn-block deposit-money-btn">${Lang[lang]['market_items_buy_item']}</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				`);

				if (min_price[item.page] == -1 || min_price[item.page] > parseInt(arr_stock_prices[key])) {
					min_price[item.page] = parseInt(arr_stock_prices[key]);
					min_price[item.page] = Math.floor(min_price[item.page]/1000)*1000;
				}
				if (max_price[item.page] < parseInt(arr_stock_prices[key])) {
					max_price[item.page] = parseInt(arr_stock_prices[key]);
					max_price[item.page] = Math.ceil(max_price[item.page]/1000)*1000;
				}

				for (const key in config.market_types.pagination) {
					$('#filter-items'+key).empty();
					$('#filter-items'+key).append(
						`<h2 style="border-bottom: 2px solid #00000033;"><b>${Lang[lang]['filters_title']}</b></h2>
						<div style="margin: 20px 0px;">
							<h4 style="margin-bottom: 5px;"><b>${Lang[lang]['filters_name']}</b></h4> 
							<input id="filter-name${key}" class="filter-name-input" type="text" placeholder="${Lang[lang]['filters_name_placeholder']}">
						</div>
						<label style="margin: 0px 0px 10px;" for="filter-stock${key}">
							<div>
								<h4 for="filter-stock${key}" style="margin-bottom: 5px;"><b>${Lang[lang]['filters_has_stock']}</b></h4> 
								<input id="filter-stock${key}" class="filter-name-input" type="checkbox">
							</div>
						</label>
						<div>
							<h4 style="border-top: 2px solid #00000033;margin-top: 10px;padding-top: 20px;"><b>${Lang[lang]['filters_price']}</b></h4> 
							<h4 style="margin: 20px 0px;">${Lang[lang]['filters_min']}</h4> 
							<div class="range-slider" style='--min:${min_price[key]}; --max:${max_price[key]}; --step:1000; --value:${min_price[key]}; --text-value:"${min_price[key]}"; --prefix:"${getCurrencySymbol(config.format.location, config.format.currency)} ";'>
								<input id="filter-min${key}" type="range" min="${min_price[key]}" max="${max_price[key]}" step="1000" value="${min_price[key]}" oninput="this.parentNode.style.setProperty('--value',this.value); this.parentNode.style.setProperty('--text-value', JSON.stringify(this.value))">
								<output></output>
								<div class='range-slider__progress'></div>
							</div>
							<h4 style="margin: 20px 0px;margin-top: 0;">${Lang[lang]['filters_max']}</h4> 
							<div class="range-slider" style='--min:${min_price[key]}; --max:${max_price[key]}; --step:1000; --value:${max_price[key]}; --text-value:"${max_price[key]}"; --prefix:"${getCurrencySymbol(config.format.location, config.format.currency)} ";'>
								<input id="filter-max${key}" type="range" min="${min_price[key]}" max="${max_price[key]}" step="1000" value="${max_price[key]}" oninput="this.parentNode.style.setProperty('--value',this.value); this.parentNode.style.setProperty('--text-value', JSON.stringify(this.value))">
								<output></output>
								<div class='range-slider__progress'></div>
							</div>
						</div>`
					);
				}
			}
		} else {
			/*
			* SIDEBAR
			*/
			if(item.update != true){
				$('#nav-bar').empty();
				$('#nav-bar').append(`
					<li id="sidebar-main" onclick="openPage('main')">
						<i class="fas fa-store-alt"></i>
						<span class="tooltip">${Lang[lang]['navbar_main_page']}</span>
					</li>
					<li id="sidebar-goods" onclick="openPage('goods')">
						<i class="fas fa-pallet"></i>
						<span class="tooltip">${Lang[lang]['navbar_goods_page']}</span>
					</li>
					<li id="sidebar-hire" onclick="openPage('hire')">
						<i class="fas fa-users"></i>
						<span class="tooltip">${Lang[lang]['navbar_hire_page']}</span>
					</li>
					<li id="sidebar-employee" onclick="openPage('employee')">
						<i class="fas fa-user-tie"></i>
						<span class="tooltip">${Lang[lang]['navbar_employee_page']}</span>
					</li>
					<li id="sidebar-upgrades" onclick="openPage('upgrades')">
						<i class="fas fa-chart-line"></i>
						<span class="tooltip">${Lang[lang]['navbar_upgrades_page']}</span>
					</li>
					<li id="sidebar-bank" onclick="openPage('bank')">
						<i class="fas fa-cash-register"></i>
						<span class="tooltip">${Lang[lang]['navbar_bank_page']}</span>
					</li>
					<li href="#myModal" data-toggle="modal" >
						<i class="fas fa-times"></i>
						<span class="tooltip">${Lang[lang]['navbar_sell_btn']}</span>
					</li>
				`);
				
				$(".pages").css("display", "none");
				$("#payments").css("display", "none");
				$(".main").css("display", "");
				$(".main-page").css("display", "block");
				$('.sidebar-navigation ul li').removeClass('active');
				$('#sidebar-main').addClass('active');
				openPage('main');

				for (const page in config.roles_permissions) {
					if (role < config.roles_permissions[page]){
						$("#sidebar-"+page).css("display", "none");
					} else {
						$("#sidebar-"+page).css("display", "");
					}
				}
			}

			/*
			* STATISTICS PAGE
			*/
			$('#store-name').empty();
			if (store_business.market_name) {
				$('#store-name').append(Lang[lang]['str_rename_store'] + ' <small>(' + store_business.market_name + ')</small>');
			} else {
				$('#store-name').append(Lang[lang]['str_rename_store']);
			}

			$('#profile-money-earned').empty();
			$('#profile-money-earned').append(new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency }).format(store_business.total_money_earned));
			$('#profile-money-spent').empty();
			$('#profile-money-spent').append(new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency }).format(store_business.total_money_spent));
			$('#profile-goods').empty();
			$('#profile-goods').append(new Intl.NumberFormat(config.format.location).format(store_business.goods_bought));
			$('#profile-distance-traveled').empty();
			$('#profile-distance-traveled').append(new Intl.NumberFormat(config.format.location).format(store_business.distance_traveled) + 'km');
			$('#profile-total-visits').empty();
			$('#profile-total-visits').append(new Intl.NumberFormat(config.format.location).format(store_business.total_visits));
			$('#profile-customers').empty();
			$('#profile-customers').append(new Intl.NumberFormat(config.format.location).format(store_business.customers));
			var stock_capacity = config.market_types.stock_capacity + config.market_types.upgrades.stock.level_reward[store_business.stock_upgrade];
			var stock_capacity_percent = ((store_business.stock_amount * 100)/stock_capacity).toFixed(1);
			$('#profile-stock-1').empty();
			var str_low_stock = '';
			if(config.warning == 1){
				str_low_stock = '<small class="red"><b>' + Lang[lang]['statistics_page_low_stock'] + '</b></small>';
			}else if(config.warning == 2){
				str_low_stock = '<small class="red"><b>' + Lang[lang]['statistics_page_low_stock_2'] + '</b></small>';
			}
			$('#profile-stock-1').append(stock_capacity_percent + '% ' + str_low_stock);
			$('#profile-stock-2').empty();
			$('#profile-stock-2').append(Lang[lang]['statistics_page_stock'].format(stock_capacity));
			$('#profile-stock-3').empty();
			$('#profile-stock-3').append('<div class="progress-bar bg-amber accent-4" role="progressbar" style="width: ' + stock_capacity_percent + '%" aria-valuenow="' + stock_capacity_percent + '" aria-valuemin="0" aria-valuemax="100"></div>');
			$('#stock-amount').empty();
			$('#stock-amount').append(`
				<h4 class="text-uppercase">${Lang[lang]['statistics_page_stock_title']} <small>(${store_business.stock_amount})</small> </h4>
				<p>${Lang[lang]['statistics_page_stock_desc']}</p>
			`);
			$('#stock-products').empty();

			/*
			* JOBS PAGE
			*/
			$('#job-page-list').empty();
			$('#hire-page-form').empty();
			$('#hire-page-form').append(`
				<div class="col-4">
					<input id="form_name" type="text" name="name" class="form-control" placeholder="${Lang[lang]['hire_page_form_job_name']}" required="required" oninput="InvalidMsg(this);" oninvalid="InvalidMsg(this);"> 
				</div>
				<div class="col-2">
					<input id="form_reward" type="number" min="1" name="reward" class="form-control" placeholder="${Lang[lang]['hire_page_form_reward']}" required="required" oninput="InvalidMsg(this,1);" oninvalid="InvalidMsg(this,1);"> 
				</div>
				<div class="col-2">
					<select id="form_product" name="product" class="form-control" required="required" onchange="setMaxAmount(this.options[this.selectedIndex].getAttribute('item_id'),this.options[this.selectedIndex].getAttribute('amount'));" oninput="InvalidMsg(this);" oninvalid="InvalidMsg(this);">
						<option value="" selected disabled>${Lang[lang]['jobs_page_select_product']}</option>
					</select> 
				</div>
				<div class="col-2" id="form_amount">
					<input type="number" min="1" name="amount" class="form-control" placeholder="${Lang[lang]['hire_page_form_amount']}" required="required"> 
				</div>
				<div class="col-2"> 
					<button class="btn btn-blue btn-darken-2 btn-send btn-block white">${Lang[lang]['hire_page_form']}</button>
				</div>
			`);

			/*
			* CONTRACTS PAGE
			*/
			$('#contracts-page-list').empty();
			for (const store_job of store_jobs) {
				var price = (config.market_types.market_items[store_job.product].price_to_owner * store_job.amount)
				var discount = Math.floor((price * config.market_types.upgrades.relationship.level_reward[store_business.relationship_upgrade])/100);
				var total_cost = store_job.reward + price-discount
				$('#contracts-page-list').append(`
					<li class="d-flex justify-content-between">
						<div class="d-flex flex-row align-items-center"><img class="font-large-2 mr-2 " src="img/${config.market_types.market_items[store_job.product].img}" width="30">
							<div class="ml-2">
								<h6 class="mb-0">${store_job.name}</h6>
								<div class="d-flex flex-row mt-1 text-black-50 small">
									<div><i class="fas fa-coins"></i><span class="ml-2">${Lang[lang]['contracts_page_reward']}: ${new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency }).format(store_job.reward)}</span></div>
									<div class="ml-3"><i class="fas fa-coins"></i><span class="ml-2">${Lang[lang]['contracts_page_cost']}: ${new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency }).format(total_cost)}</span></div>
									<div class="ml-3"><i class="fas fa-dolly-flatbed"></i><span class="ml-2">${Lang[lang]['contracts_page_item']}: ${config.market_types.market_items[store_job.product].name}</span></div>
									<div class="ml-3"><i class="fas fa-boxes"></i><span class="ml-2">${Lang[lang]['contracts_page_amount']}: ${store_job.amount}</span></div>
								</div>
							</div>
						</div>
						<div class="d-flex flex-row align-items-center">
							<button onclick="deleteJob(${store_job.id})" class="btn btn-red btn-accent-4 white">${Lang[lang]['contracts_page_delete']}</button>
						</div>
					</li>
				`);
			}

			/*
			* EMPLOYEES PAGE
			*/
			if (item.update != true) {
				$('#input-hire-player').empty();
				$('#input-hire-player').append(`<option value="" selected disabled>${Lang[lang]['select_employee']}</option>`);
				for (const player of players) {
					$('#input-hire-player').append(`<option value="${player.identifier}">${player.name}</option>`);
				}
			}

			$('#hired-players-list').empty();
			for (const user of store_employees) {
				let roles = {};
				roles[user.role] = 'selected';
				$('#hired-players-list').append(`
					<li class="d-flex justify-content-between">
						<div class="d-flex flex-row align-items-center"><img class="font-large-2 mr-2 " src="img/man.png" width="30">
							<div class="ml-2">
								<h6 class="mb-0">${user.name}</h6>
								<div class="d-flex flex-row mt-1 text-black-50 small">
									<div><i class="fas fa-truck-loading"></i><span class="ml-2">${Lang[lang]['jobs_done']} ${user.jobs_done}</span></div>
									<div class="ml-3"><i class="fas fa-calendar-alt"></i><span class="ml-2">${Lang[lang]['hired_date']} ${timeConverter(user.timer,config.format.location)}</span></div>
								</div>
							</div>
						</div>
						<div class="d-flex align-self-center">
							<div>
								<select id="change_role" name="role" class="form-control" required="required">
									<option user="${user.user_id}" role="1" ${roles[1]??''}>${Lang[lang]['basic_access']}</option>
									<option user="${user.user_id}" role="2" ${roles[2]??''}>${Lang[lang]['advanced_access']}</option>
									<option user="${user.user_id}" role="3" ${roles[3]??''}>${Lang[lang]['full_access']}</option>
								</select>
							</div>
							<div class="d-flex flex-row align-items-center">
								<input style="width: 160px; padding: 0px 0px 0px 5px" id="input-give-comission-${user.user_id}" class="input-give-comission form-control ml-3" type="number" min="1" max="9999999" placeholder="${Lang[lang]['input_give_comission']}">
								<button onclick="giveComission('${user.user_id}')" class="btn btn-blue btn-darken-2 white ml-3">${Lang[lang]['button_give_comission']}</button>
							</div>
							<div class="d-flex flex-row align-items-center">
								<button onclick="firePlayer('${user.user_id}')" class="btn btn-red btn-accent-4 white ml-3">${Lang[lang]['button_fire_employee']}</button>
							</div>
						<div>
					</li>
				`);
			}

			/*
			* UPGRADES PAGE
			*/
			$('#upgrades-page').empty();
			$('#upgrades-page').append(`
				<div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
					<div class="card rounded shadow-sm border-0">
						<div class="card-body p-4"><img src="https://cdn.discordapp.com/attachments/533398980428693550/804898333192880128/shop.png" alt="" class="img-fluid d-block mx-auto mb-3">
							<h5> <a href="#" class="text-dark">${Lang[lang]['upgrade_page_stock']}</a></h5>
							<p style="height: 65px;" class="small text-muted font-italic">${Lang[lang]['upgrade_page_stock_desc']}</p>
							<ul class="small text-muted font-italic">
								<li> ${Lang[lang]['upgrade_page_level']} 1: +${config.market_types.upgrades.stock.level_reward[1]} ${Lang[lang]['upgrade_page_units']}.</li>
								<li> ${Lang[lang]['upgrade_page_level']} 2: +${config.market_types.upgrades.stock.level_reward[2]} ${Lang[lang]['upgrade_page_units']}. </li>
								<li> ${Lang[lang]['upgrade_page_level']} 3: +${config.market_types.upgrades.stock.level_reward[3]} ${Lang[lang]['upgrade_page_units']}. </li>
								<li> ${Lang[lang]['upgrade_page_level']} 4: +${config.market_types.upgrades.stock.level_reward[4]} ${Lang[lang]['upgrade_page_units']}. </li>
								<li> ${Lang[lang]['upgrade_page_level']} 5: +${config.market_types.upgrades.stock.level_reward[5]} ${Lang[lang]['upgrade_page_units']}. </li>
							</ul>
							<ul class="justify-content-center d-flex list-inline small">
								${getStarsHTML(store_business.stock_upgrade)}
							</ul>
							<button onclick="buyUpgrade('stock')" class="btn btn-blue btn-darken-2 white btn-block">${Lang[lang]['upgrade_page_buy_upgrade']} ${new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency, maximumFractionDigits: 0, minimumFractionDigits: 0 }).format(config.market_types.upgrades.stock.price)}</button>
						</div>
					</div>
				</div>
				
				<div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
					<div class="card rounded shadow-sm border-0">
						<div class="card-body p-4"><img src="https://cdn.discordapp.com/attachments/533398980428693550/804898331159298078/delivery-truck.png" alt="" class="img-fluid d-block mx-auto mb-3">
							<h5> <a href="#" class="text-dark">${Lang[lang]['upgrade_page_truck']}</a></h5>
							<p style="height: 65px;" class="small text-muted font-italic">${Lang[lang]['upgrade_page_truck_desc']}</p>
							<ul class="small text-muted font-italic">
								<li> ${Lang[lang]['upgrade_page_level']} 1: +${config.market_types.upgrades.truck.level_reward[1]}% ${Lang[lang]['upgrade_page_capacity']}.</li>
								<li> ${Lang[lang]['upgrade_page_level']} 2: +${config.market_types.upgrades.truck.level_reward[2]}% ${Lang[lang]['upgrade_page_capacity']}. </li>
								<li> ${Lang[lang]['upgrade_page_level']} 3: +${config.market_types.upgrades.truck.level_reward[3]}% ${Lang[lang]['upgrade_page_capacity']}. </li>
								<li> ${Lang[lang]['upgrade_page_level']} 4: +${config.market_types.upgrades.truck.level_reward[4]}% ${Lang[lang]['upgrade_page_capacity']}. </li>
								<li> ${Lang[lang]['upgrade_page_level']} 5: +${config.market_types.upgrades.truck.level_reward[5]}% ${Lang[lang]['upgrade_page_capacity']}. </li>
							</ul>
							<ul class="justify-content-center d-flex list-inline small">
								${getStarsHTML(store_business.truck_upgrade)}
							</ul>
							<button onclick="buyUpgrade('truck')" class="btn btn-blue btn-darken-2 white btn-block">${Lang[lang]['upgrade_page_buy_upgrade']} ${new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency, maximumFractionDigits: 0, minimumFractionDigits: 0 }).format(config.market_types.upgrades.truck.price)}</button>
						</div>
					</div>
				</div>
				
				<div class="col-lg-4 col-md-6 mb-4 mb-lg-0">
					<div class="card rounded shadow-sm border-0">
						<div class="card-body p-4"><img src="https://cdn.discordapp.com/attachments/533398980428693550/804898332371189780/manager.png" alt="" class="img-fluid d-block mx-auto mb-3">
							<h5> <a href="#" class="text-dark">${Lang[lang]['upgrade_page_relationship']}</a></h5>
							<p style="height: 65px;" class="small text-muted font-italic">${Lang[lang]['upgrade_page_relationship_desc']}</p>
							<ul class="small text-muted font-italic">
								<li> ${Lang[lang]['upgrade_page_level']} 1: ${config.market_types.upgrades.relationship.level_reward[1]}% ${Lang[lang]['upgrade_page_discount']}. </li>
								<li> ${Lang[lang]['upgrade_page_level']} 2: ${config.market_types.upgrades.relationship.level_reward[2]}% ${Lang[lang]['upgrade_page_discount']}. </li>
								<li> ${Lang[lang]['upgrade_page_level']} 3: ${config.market_types.upgrades.relationship.level_reward[3]}% ${Lang[lang]['upgrade_page_discount']}. </li>
								<li> ${Lang[lang]['upgrade_page_level']} 4: ${config.market_types.upgrades.relationship.level_reward[4]}% ${Lang[lang]['upgrade_page_discount']}. </li>
								<li> ${Lang[lang]['upgrade_page_level']} 5: ${config.market_types.upgrades.relationship.level_reward[5]}% ${Lang[lang]['upgrade_page_discount']}. </li>
							</ul>
							<ul class="justify-content-center d-flex list-inline small">
								${getStarsHTML(store_business.relationship_upgrade)}
							</ul>
							<button onclick="buyUpgrade('relationship')" class="btn btn-blue btn-darken-2 white btn-block">${Lang[lang]['upgrade_page_buy_upgrade']} ${new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency, maximumFractionDigits: 0, minimumFractionDigits: 0 }).format(config.market_types.upgrades.relationship.price)}</button>
						</div>
					</div>
				</div>
			`);

			/*
			* BANK PAGE
			*/
			$('#bank-page-total-money').empty();
			$('#bank-page-total-money').append(Lang[lang]['bank_page_total_money'] +' <span class="success darken-1">' + new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency }).format(store_business.money) + '</span>');
			$('#balance-list').empty();
			for (const balance of store_balance) {
				let tstyle = ''
				let tclass = ''
				let tbutton = `<i onclick="hideBalance(${balance.id})" class="fas fa-circle-xmark redicon hide-balance-icon"></i>`
				if (balance.hidden == 1) {
					if (!$('#show-hidden-balance').is(":checked")) {
						tstyle = 'style="display: none !important;"';
					}
					tclass = 'hidden-balance';
					tbutton = `<i onclick="showBalance(${balance.id})" class="fas fa-plus-circle blueicon hide-balance-icon"></i>`
				}
				let ticon = '<i style="font-size:15px;" class="fas fa-minus-circle redicon"></i>'
				if(balance.income == 0){
					ticon = '<i style="font-size:15px;" class="fas fa-plus-circle checkicon"></i>'
				}
				$('#balance-list').append(`
					<li class="d-flex justify-content-between ${tclass}" ${tstyle}>
						<div class="d-flex flex-row align-items-center w-100">${ticon}
							<div class="d-flex justify-content-between align-items-center w-100">
								<div class="ml-2">
									<h6 class="mb-0">${balance.title}</h6>
									<div class="d-flex flex-row mt-1 text-black-50 small">
										<div><i class="fas fa-coins"></i></i><span class="ml-2">${Lang[lang]['bank_page_price']}: ${new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency }).format(balance.amount)}</span></div>
										<div class="ml-3"><i class="fas fa-calendar-alt"></i></i><span class="ml-2">${Lang[lang]['bank_page_date']}: ${timeConverter(balance.date,config.format.location)}</span></div>
									</div>
								</div>
								${tbutton}
							</div>
						</div>
					</li>
				`);
			}

			/*
			* ITEMS LISTS
			*/
			for (const key in config.market_types.market_items) {
				var fkey = key.replace("|", "-x-");
				var market_item = config.market_types.market_items[key];
				var amount = (market_item.amount_to_owner + Math.floor(market_item.amount_to_owner*(config.market_types.upgrades.truck.level_reward[store_business.truck_upgrade]/100)));
				var price = market_item.price_to_owner
				var discount = Math.floor((price * config.market_types.upgrades.relationship.level_reward[store_business.relationship_upgrade])/100);
				$('#job-page-list').append(`
					<li class="d-flex justify-content-between">
						<div class="d-flex flex-row align-items-center"><img class="font-large-2 mr-2 " src="img/${market_item.img}" width="30">
							<div class="ml-2">
								<h6 class="mb-0">${market_item.name}</h6>
								<div class="d-flex flex-row mt-1 text-black-50 small">
									<div><i class="fas fa-coins"></i><span class="ml-2">${Lang[lang]['jobs_page_cost']}: ${new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency }).format(price-discount)}</span></div>
									<div class="ml-3"><i class="fas fa-boxes"></i><span class="ml-2">${Lang[lang]['jobs_page_max_amount']}: ${amount}</span></div>
								</div>
							</div>
						</div>
						<form class="mb-0 mt-1" id="jobs-form" role="form">
							<div class="d-flex flex-row">
								<input id="input-job-${fkey}" class="job-amount mr-3" min="1" max="${amount}" type="number" name="amount" required="required" placeholder="${Lang[lang]['jobs_page_amount']}" oninput="InvalidMsg(this,1,${amount});" oninvalid="InvalidMsg(this,1,${amount});">
								<button onclick="startJob('${fkey}')" class="btn btn-blue btn-darken-2 white mr-3">${Lang[lang]['jobs_page_start']}</button>
								<button onclick="storeProduct('${fkey}')" class="btn btn-blue btn-darken-2 white mr-3">${Lang[lang]['jobs_page_store_item']}</button>
							</div>
						</form>
					</li>
				`);

				// Select box (contracts page)
				$('#form_product').append(`
					<option item_id="${key}" amount="${market_item.amount_to_delivery}" >${market_item.name}</option>
				`);

				if(arr_stock[key] == undefined) {
					stock_value = new Intl.NumberFormat(config.format.location).format(0);
				} else {
					stock_value = new Intl.NumberFormat(config.format.location).format(arr_stock[key]);
				}
				if(arr_stock_prices[key] == undefined) {
					arr_stock_prices[key] = market_item.price_to_customer;
				}
				
				// Stock amount (statistics page)
				$('#stock-products').append(`
					<div class="col-12">
						<div class="card overflow-hidden w-auto">
							<div class="card-content">
								<div class="card-body cleartfix">
									<div class="media align-items-stretch">
										<div class="align-self-center">
											<img class="font-large-2 mr-2 " src="img/${market_item.img}" width="60">
										</div>
										<div class="media-body">
											<h4>${market_item.name}</h4>
											<span class="text-black-50 small"><i class="fas fa-coins"></i> ${Lang[lang]['statistics_page_price']}: ${new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency }).format((arr_stock_prices[key])) }</span>
											<span class="text-black-50 small ml-3"><i class="fas fa-coins"></i> ${Lang[lang]['statistics_page_export_price']}: ${new Intl.NumberFormat(config.format.location, { style: 'currency', currency: config.format.currency }).format((market_item.price_to_export)) }</span>
										</div>
										<div class="d-flex align-self-center">
										<h1 class="h1-center mb-0 ml-3">${stock_value}</h1>
											<span class="textbox ml-3"> 
												${getCurrencySymbol (config.format.location, config.format.currency)}
												<input id="input-price-${fkey}" min="1" type="number" name="amount" required="required" placeholder="${Lang[lang]['statistics_page_price']}"/>
											</span>
											<button onclick="setPrice('${fkey}')" class="stock-btn btn btn-blue btn-darken-2 white ml-3 mt-0">${Lang[lang]['statistics_page_set_price']}</button>
											<button onclick="startJob2('${fkey}')" class="stock-btn btn btn-blue btn-darken-2 white ml-3 mt-0">${Lang[lang]['statistics_page_export']}</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				`);
			}

			if(item.update != true){
				// Statistics page
				$('#store-name-desc').empty();
				$('#store-name-desc').append(Lang[lang]['str_rename_store_desc']);
				$('#form_blip_color').empty();
				$('#form_blip_color').append(Lang[lang]['html_select_colors']);
				$('#form_blip_id').empty();
				$('#form_blip_id').append(Lang[lang]['html_select_type']);
				$('#apply-rename').empty();
				$('#apply-rename').append(Lang[lang]['btn_apply_rename']);
				$('#text-rename').empty();
				$('#text-rename').append(`<input id="form_name" type="text" name="name" class="form-control" placeholder="${Lang[lang]['str_rename_store_name']}" required="required" oninput="InvalidMsg(this);" oninvalid="InvalidMsg(this);"> `);
				$('#main-page-title').empty();
				$('#main-page-title').append(Lang[lang]['statistics_page_title']);
				$('#main-page-desc').empty();
				$('#main-page-desc').append(Lang[lang]['statistics_page_desc']);
				$('#profile-money-earned-2').empty();
				$('#profile-money-earned-2').append(Lang[lang]['statistics_page_money_earned']);
				$('#profile-money-spent-2').empty();
				$('#profile-money-spent-2').append(Lang[lang]['statistics_page_money_spent']);
				$('#profile-goods-2').empty();
				$('#profile-goods-2').append(Lang[lang]['statistics_page_goods']);
				$('#profile-distance-traveled-2').empty();
				$('#profile-distance-traveled-2').append(Lang[lang]['statistics_page_distance_traveled']);
				$('#profile-total-visits-2').empty();
				$('#profile-total-visits-2').append(Lang[lang]['statistics_page_total_visits']);
				$('#profile-customers-2').empty();
				$('#profile-customers-2').append(Lang[lang]['statistics_page_customers']);
	
				// Goods page
				$('#goods-page-title').empty();
				$('#goods-page-title').append(Lang[lang]['goods_page_title']);
				$('#goods-page-desc').empty();
				$('#goods-page-desc').append(Lang[lang]['goods_page_desc']);
	
				// Hire page
				$('#hire-page-title').empty();
				$('#hire-page-title').append(Lang[lang]['hire_page_title']);
				$('#hire-page-desc').empty();
				$('#hire-page-desc').append(Lang[lang]['hire_page_desc']);
				
				// Upgrades page
				$('#upgrades-page-title').empty();
				$('#upgrades-page-title').append(Lang[lang]['upgrades_page_title']);
				$('#upgrades-page-desc').empty();
				$('#upgrades-page-desc').append(Lang[lang]['upgrades_page_desc']);
	
				// Employees page
				$('#employees-title').text(Lang[lang]['employees_title']);
				$('#employees-page-desc').text(Lang[lang]['employees_desc']);
				$('#button-hire-player').text(Lang[lang]['button_employee']);
	
				// Bank page
				$('#bank-page-title').empty();
				$('#bank-page-title').append(Lang[lang]['bank_page_title']);
				$('#bank-page-desc').empty();
				$('#bank-page-desc').append(Lang[lang]['bank_page_desc']);
				$('#income-expenses-p').empty();
				$('#income-expenses-p').append(Lang[lang]['bank_page_income_expenses']);
				$('#bank-page-show-hidden').empty();
				$('#bank-page-show-hidden').append(Lang[lang]['bank_page_hidden_balance']);
				$('#bank-page-withdraw').empty();
				$('#bank-page-withdraw').append(Lang[lang]['bank_page_withdraw']);
				$('#bank-page-deposit').empty();
				$('#bank-page-deposit').append(`
					<input id="input-deposit-money" class="deposit-money" type="number" placeholder="` + Lang[lang]['bank_page_amount'] + `">
					<button onclick="depositMoney()" class="btn btn-blue btn-darken-2 white deposit-money-btn">` + Lang[lang]['bank_page_deposit'] + `</button>
				`);
	
				// Sell modal
				$('#modal-confirm-title-sell').text(Lang[lang]['modal_title']);
				$('#modal-cancel-sell').text(Lang[lang]['cancel_button_modal']);
				$('#modal-confirm-sell').text(Lang[lang]['confirm_sell_button_modal']);
				$('#modal-p-sell').text(Lang[lang]['confirm_sell_store']);
	
				$('#payment-method-title').text(Lang[lang]['payment_method_title']);
			}
		}

		$("form").submit(function(e){
			e.preventDefault();
		});

		$('.sidebar-navigation ul li').on('click', function() {
			$('li').removeClass('active');
			$(this).addClass('active');
		});

		$('#change_role').change(function() {
			changeRole($('option:selected', this).attr('user'),$('option:selected', this).attr('role'))
		});
	}
	if (item.hidemenu){
		$(".main").css("display", "none");
	}
});

/*=================
	FUNCTIONS
=================*/

$('#show-hidden-balance').change(function() {
	if($(this).is(":checked")) {
		$('.hidden-balance').css("display", "");
		$('.hidden-balance').addClass("d-flex");
	} else {
		$('.hidden-balance').css("display", "none");
		$('.hidden-balance').removeClass("d-flex");
	}
});

function filterItems(page) {
	let name = document.getElementById('filter-name'+page).value;
	let stock = document.getElementById('filter-stock'+page).checked;
	let min = document.getElementById('filter-min'+page).value;
	let max = document.getElementById('filter-max'+page).value;
	let list = document.getElementById("market-products"+page).getElementsByClassName("item-card");
	if (list && list.length > 0) {
		for (const cards of list) {
			cards.style.display = "";
			if (name != "" && !cards.dataset.name.toLowerCase().includes(name.toLowerCase())) {
				cards.style.display = "none";
			}
			if (stock && cards.dataset.stock == 0) {
				cards.style.display = "none";
			}
			if (parseInt(cards.dataset.price) < parseInt(min) || parseInt(cards.dataset.price) > parseInt(max)) {
				cards.style.display = "none";
			}
		}
	}
}

function openPage(pageN){
	if (config.roles_permissions[pageN] == undefined || role >= config.roles_permissions[pageN]){
		$(".pages").css("display", "none");
		$("."+pageN+"-page").css("display", "block");
	}
}


function setMaxAmount(item_id,amount){
	$('#form_amount').empty();
	$('#form_amount').append(`
		<input type="number" min="1" max="${amount}" name="amount" class="form-control" placeholder="${Lang[lang]['hire_page_form_amount']}" required="required" oninput="InvalidMsg(this,1,${amount});" oninvalid="InvalidMsg(this,1,${amount});"> 
	`);
}

function getStarsHTML(value){
	var html = "";
	for (var i = 1; i <= 5; i++) {
		if(i <= value){
			html += '<li class="list-inline-item m-1"><i class="fas fa-star amber font-large-1"></i></li>';
		}else{
			html += '<li class="list-inline-item m-1"><i class="fa fa-star-o amber font-large-1"></i></li>';
		}
	}
	return html;
}

function getPagination(pagination){
	var html = "";
	for (var i = 0; i <= 5; i++) {
		if(pagination[i] == undefined){
			return html;
		}
		html +=`
		<li id="sidebar-${i}" onclick="openPage(${i})">
			<i class="fas fa-store"></i>
			<span class="tooltip">${pagination[i]}</span>
		</li>`;
	}
	return html;
}

document.onkeyup = function(data){
	if (data.which == 27){
		if ($(".main").is(":visible")){
			$("#buyModal").modal('hide');
			$("#myModal").modal('hide');
			post("close","")
		}
	}
};

function timeConverter(UNIX_timestamp,locale){
	var a = new Date(UNIX_timestamp * 1000);
	var time = a.toLocaleString(locale);
	return time;
}

function getCurrencySymbol (locale, currency) {
	return (0).toLocaleString(
	  locale,
	  {
		style: 'currency',
		currency: currency,
		minimumFractionDigits: 0,
		maximumFractionDigits: 0
	  }
	).replace(/\d/g, '').trim()
}

function InvalidMsg(textbox,min,max) {
	
	if (textbox.value == '') {
		textbox.setCustomValidity(Lang[lang]['str_fill_field']);
	}
	else if(textbox.validity.typeMismatch){
		textbox.setCustomValidity(Lang[lang]['str_invalid_value']);
	}
	else if(textbox.validity.rangeUnderflow){
		textbox.setCustomValidity(Lang[lang]['str_more_than'].format(min));
	}
	else if(textbox.validity.rangeOverflow){
		textbox.setCustomValidity(Lang[lang]['str_less_than'].format(max));
	}
	else {
		textbox.setCustomValidity('');
	}
	return true;
}

if (!String.prototype.format) {
    String.prototype.format = function() {
        var args = arguments;
        return this.replace(/{(\d+)}/g, function(match, number) { 
        return typeof args[number] != 'undefined'
            ? args[number]
            : match
        ;
        });
    };
}

$('#buyModal').on('hidden.bs.modal', function () {
	closeUI();
})

/*=================
	CALLBACKS
=================*/

function closeUI(){
	post("close","")
}
function startJob(item_id){
	var amount = $("#input-job-"+item_id).val();
	var item_id = item_id.replace("-x-", "|");
	post("startJob",{item_id:item_id,amount:amount})
}
function startJob2(item_id){
	var amount = $("#input-job-"+item_id).val();
	var item_id = item_id.replace("-x-", "|");
	post("startJob2",{item_id:item_id,amount:amount})
}
function storeProduct(item_id){
	var amount = $("#input-job-"+item_id).val();
	var item_id = item_id.replace("-x-", "|");
	post("storeProduct",{item_id:item_id,amount:amount})
}
function setPrice(item_id){
	var price = $("#input-price-"+item_id).val();
	var item_id = item_id.replace("-x-", "|");
	post("setPrice",{item_id:item_id,price:price})
}
$(document).ready( function() { // Submitted create job form
	$("#contact-form").on('submit', function(e){
		e.preventDefault();
		var form = $('#contact-form').serializeArray();
		var e = document.getElementById("form_product");
		var item_id = e.options[e.selectedIndex].getAttribute('item_id');
		post("createJob",{name:form[0].value,reward:form[1].value,product:item_id,amount:form[3].value})
	});

	$("#rename-form").on('submit', function(e){
		e.preventDefault();
		var form = $('#rename-form').serializeArray();
		var e = document.getElementById("form_blip_color");
		var color_id = e.options[e.selectedIndex].getAttribute('color_id');
		var e = document.getElementById("form_blip_id");
		var blip_id = e.options[e.selectedIndex].getAttribute('blip_id');
		post("renameMarket",{name:form[0].value,color:color_id,blip:blip_id})
	});
})
function buyItem(item_id){
	let paymentMethod = $('input[name=payment-method]:checked').val()
	var amount = $("#input-"+item_id).val();
	var item_id = item_id.replace("-x-", "|");
	post("buyItem",{item_id:item_id,amount:amount,paymentMethod:paymentMethod})
}
function deleteJob(job_id){
	post("deleteJob",{job_id:job_id})
}
function buyUpgrade(id){
	post("buyUpgrade",{id:id})
}
function depositMoney(){
	var amount = document.getElementById('input-deposit-money').value;
	document.getElementById('input-deposit-money').value = null;
	post("depositMoney",{amount:amount})
}
function withdrawMoney(){
	post("withdrawMoney",{})
}
function sellMarket(){
	post("sellMarket",{})
}
function buyMarket(){
	post("buyMarket",{})
}
function hirePlayer() {
	let user = document.getElementById('input-hire-player').value;
	$("#input-hire-player").val($("#input-hire-player option:first").val());
	post("hirePlayer",{user})
}
function firePlayer(user) {
	post("firePlayer",{user})
}
function giveComission(user) {
	let amount = document.getElementById('input-give-comission-'+user).value;
	document.getElementById('input-give-comission-'+user).value = null;
	post("giveComission",{user,amount})
}
function changeRole(user_id,role){
	post("changeRole",{user_id:user_id,role:role})
}
function hideBalance(balance_id){
	post("hideBalance",{balance_id:balance_id})
}
function showBalance(balance_id){
	post("showBalance",{balance_id:balance_id})
}

function post(name,data){
	$.post("http://esx_stores/"+name,JSON.stringify(data),function(datab){
		if (datab != "ok"){
			console.log(datab);
		}
	});
}

// Notification
(() => {
	const toastPosition = {
		TopLeft: "top-left",
		TopCenter: "top-center",
		TopRight: "top-right",
		BottomLeft: "bottom-left",
		BottomCenter: "bottom-center",
		BottomRight: "bottom-right"
	}

	const toastPositionIndex = [
		[toastPosition.TopLeft, toastPosition.TopCenter, toastPosition.TopRight],
		[toastPosition.BottomLeft, toastPosition.BottomCenter, toastPosition.BottomRight]
	]

	const svgs = {
		successo: '<svg viewBox="0 0 426.667 426.667" width="18" height="18"><path d="M213.333 0C95.518 0 0 95.514 0 213.333s95.518 213.333 213.333 213.333c117.828 0 213.333-95.514 213.333-213.333S331.157 0 213.333 0zm-39.134 322.918l-93.935-93.931 31.309-31.309 62.626 62.622 140.894-140.898 31.309 31.309-172.203 172.207z" fill="#6ac259"></path></svg>',
		aviso: '<svg viewBox="0 0 310.285 310.285" width=18 height=18> <path d="M264.845 45.441C235.542 16.139 196.583 0 155.142 0 113.702 0 74.743 16.139 45.44 45.441 16.138 74.743 0 113.703 0 155.144c0 41.439 16.138 80.399 45.44 109.701 29.303 29.303 68.262 45.44 109.702 45.44s80.399-16.138 109.702-45.44c29.303-29.302 45.44-68.262 45.44-109.701.001-41.441-16.137-80.401-45.439-109.703zm-132.673 3.895a12.587 12.587 0 0 1 9.119-3.873h28.04c3.482 0 6.72 1.403 9.114 3.888 2.395 2.485 3.643 5.804 3.514 9.284l-4.634 104.895c-.263 7.102-6.26 12.933-13.368 12.933H146.33c-7.112 0-13.099-5.839-13.345-12.945L128.64 58.594c-.121-3.48 1.133-6.773 3.532-9.258zm23.306 219.444c-16.266 0-28.532-12.844-28.532-29.876 0-17.223 12.122-30.211 28.196-30.211 16.602 0 28.196 12.423 28.196 30.211.001 17.591-11.456 29.876-27.86 29.876z" fill="#FFDA44" /> </svg>',
		importante: '<svg viewBox="0 0 23.625 23.625" width=18 height=18> <path d="M11.812 0C5.289 0 0 5.289 0 11.812s5.289 11.813 11.812 11.813 11.813-5.29 11.813-11.813S18.335 0 11.812 0zm2.459 18.307c-.608.24-1.092.422-1.455.548a3.838 3.838 0 0 1-1.262.189c-.736 0-1.309-.18-1.717-.539s-.611-.814-.611-1.367c0-.215.015-.435.045-.659a8.23 8.23 0 0 1 .147-.759l.761-2.688c.067-.258.125-.503.171-.731.046-.23.068-.441.068-.633 0-.342-.071-.582-.212-.717-.143-.135-.412-.201-.813-.201-.196 0-.398.029-.605.09-.205.063-.383.12-.529.176l.201-.828c.498-.203.975-.377 1.43-.521a4.225 4.225 0 0 1 1.29-.218c.731 0 1.295.178 1.692.53.395.353.594.812.594 1.376 0 .117-.014.323-.041.617a4.129 4.129 0 0 1-.152.811l-.757 2.68a7.582 7.582 0 0 0-.167.736 3.892 3.892 0 0 0-.073.626c0 .356.079.599.239.728.158.129.435.194.827.194.185 0 .392-.033.626-.097.232-.064.4-.121.506-.17l-.203.827zm-.134-10.878a1.807 1.807 0 0 1-1.275.492c-.496 0-.924-.164-1.28-.492a1.57 1.57 0 0 1-.533-1.193c0-.465.18-.865.533-1.196a1.812 1.812 0 0 1 1.28-.497c.497 0 .923.165 1.275.497.353.331.53.731.53 1.196 0 .467-.177.865-.53 1.193z" fill="#006DF0" /> </svg>',
		erro: '<svg viewBox="0 0 51.976 51.976" width=18 height=18> <path d="M44.373 7.603c-10.137-10.137-26.632-10.138-36.77 0-10.138 10.138-10.137 26.632 0 36.77s26.632 10.138 36.77 0c10.137-10.138 10.137-26.633 0-36.77zm-8.132 28.638a2 2 0 0 1-2.828 0l-7.425-7.425-7.778 7.778a2 2 0 1 1-2.828-2.828l7.778-7.778-7.425-7.425a2 2 0 1 1 2.828-2.828l7.425 7.425 7.071-7.071a2 2 0 1 1 2.828 2.828l-7.071 7.071 7.425 7.425a2 2 0 0 1 0 2.828z" fill="#D80027" /> </svg>'
	}

	const styles = `
		.vt-container {
			position: fixed;
			width: 100%;
			height: 100vh;
			top: 0;
			left: 0;
			z-index: 9999;
			display: flex;
			flex-direction: column;
			justify-content: space-between;
			pointer-events: none;
		}

		.vt-row {
			display: flex;
			justify-content: space-between;
		}

		.vt-col {
			flex: 1;
			margin: 10px 20px;
			display: flex;
			flex-direction: column;
			align-items: center;
		}

		.vt-col.top-left,
		.vt-col.bottom-left {
			align-items: flex-start;
		}

		.vt-col.top-right,
		.vt-col.bottom-right {
			align-items: flex-end;
		}

		.vt-card {
			display: flex;
			justify-content: center;
			align-items: center;
			padding: 12px 20px;
			background-color: #fff;
			box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
			color: #000;
			border-radius: 4px;
			margin: 0px;
			transition: 0.3s all ease-in-out;
			pointer-events: all;
			border-left: 3px solid #8b8b8b;
			cursor: pointer;
		}

		.vt-card.successo {
			border-left: 3px solid #6ec05f;
		}

		.vt-card.aviso {
			border-left: 3px solid #fed953;
		}

		.vt-card.importante {
			border-left: 3px solid #1271ec;
		}

		.vt-card.erro {
			border-left: 3px solid #d60a2e;
		}

		.vt-card .text-group {
			margin-left: 15px;
		}

		.vt-card h4 {
			margin: 0;
			margin-bottom: 10px;
			font-size: 16px;
			font-weight: 500;
		}

		.vt-card p {
			margin: 0;
			font-size: 14px;
		}
	`

	const styleSheet = document.createElement("style")
	styleSheet.innerText = styles.replace((/  |\r\n|\n|\r/gm), "")
	document.head.appendChild(styleSheet)

	const vtContainer = document.createElement("div")
	vtContainer.className = "vt-container"

	for (const ri of [0, 1]) {
		const row = document.createElement("div")
		row.className = "vt-row"

		for (const ci of [0, 1, 2]) {
			const col = document.createElement("div")
			col.className = `vt-col ${toastPositionIndex[ri][ci]}`

			row.appendChild(col)
		}

		vtContainer.appendChild(row)
	}

	document.body.appendChild(vtContainer)

	window.vt = {
		options: {
			title: undefined,
			position: toastPosition.TopCenter,
			duration: 10000,
			closable: true,
			focusable: true,
			callback: undefined
		},
		successo(message, options) {
			show(message, options, "successo")
		},
		importante(message, options) {
			show(message, options, "importante")
		},
		aviso(message, options) {
			show(message, options, "aviso")
		},
		erro(message, options) {
			show(message, options, "erro")
		}
	}

	function show(message = "", options, type) {
		options = { ...window.vt.options, ...options }

		const col = document.getElementsByClassName(options.position)[0]

		const vtCard = document.createElement("div")
		vtCard.className = `vt-card ${type}`
		vtCard.innerHTML += svgs[type]
		vtCard.options = {
			...options, ...{
				message,
				type: type,
				yPos: options.position.indexOf("top") > -1 ? "top" : "bottom",
				isFocus: false
			}
		}

		setVTCardContent(vtCard)
		setVTCardIntroAnim(vtCard)
		setVTCardBindEvents(vtCard)
		autoDestroy(vtCard)

		

		col.appendChild(vtCard)
	}

	function setVTCardContent(vtCard) {
		const textGroupDiv = document.createElement("div")

		textGroupDiv.className = "text-group"

		if (vtCard.options.title) {
			textGroupDiv.innerHTML = `<h4>${vtCard.options.title}</h4>`
		}

		textGroupDiv.innerHTML += `<p>${vtCard.options.message}</p>`

		vtCard.appendChild(textGroupDiv)
	}

	function setVTCardIntroAnim(vtCard) {
		vtCard.style.setProperty(`margin-${vtCard.options.yPos}`, "-15px")
		vtCard.style.setProperty("opacity", "0")

		setTimeout(() => {
			vtCard.style.setProperty(`margin-${vtCard.options.yPos}`, "15px")
			vtCard.style.setProperty("opacity", "1")
		}, 50)
	}

	function setVTCardBindEvents(vtCard) {
		vtCard.addEventListener("click", () => {
			if (vtCard.options.closable) {
				destroy(vtCard)
			}
		})

		vtCard.addEventListener("mouseover", () => {
			vtCard.options.isFocus = vtCard.options.focusable
		})

		vtCard.addEventListener("mouseout", () => {
			vtCard.options.isFocus = false
			autoDestroy(vtCard, vtCard.options.duration)
		})
	}

	function destroy(vtCard) {
		vtCard.style.setProperty(`margin-${vtCard.options.yPos}`, `-${vtCard.offsetHeight}px`)
		vtCard.style.setProperty("opacity", "0")

		setTimeout(() => {
			if(typeof x !== "undefined"){
				vtCard.parentNode.removeChild(v)

				if (typeof vtCard.options.callback === "function") {
					vtCard.options.callback()
				}
			}
		}, 500)
	}

	function autoDestroy(vtCard) {
		if (vtCard.options.duration !== 0) {
			setTimeout(() => {
				if (!vtCard.options.isFocus) {
					destroy(vtCard)
				}
			}, vtCard.options.duration)
		}
	}
})()