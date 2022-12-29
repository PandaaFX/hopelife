// To add a new lang file you must declare the file on the last lines of index.html like: <script src="lang/en.js" type="text/javascript"></script>
if (Lang == undefined) {
	var Lang = [];
}
Lang['br'] = {
	confirm_buy_store: 'Você realmente deseja comprar essa loja? Preço: {0} ',
	confirm_sell_store: 'Você realmente deseja vender essa loja? Tudo será deletado e não poderá ser desfeito.',
	modal_title: 'Você tem certeza?',
	confirm_buy_button_modal: 'Comprar',
	confirm_sell_button_modal: 'Vender',
	cancel_button_modal: 'Cancelar',

	navbar_main_page: 'Sua Loja',
	navbar_goods_page: 'Comprar mercadorias',
	navbar_hire_page: 'Contratar entregador',
	navbar_employee_page: 'Empregados',
	navbar_upgrades_page: 'Upgrades',
	navbar_bank_page: 'Caixa',
	navbar_sell_btn: 'Vender loja',
	navbar_close_btn: 'Fechar',

	statistics_page_low_stock: 'Ficar com BAIXO ESTOQUE fará com que você perca sua loja!',
	statistics_page_low_stock_2: 'Você precisa melhorar sua loja\s VARIEDADE DE PRODUTOS ou você vai perde-la!',
	statistics_page_stock: 'Capacidade de Estoque (Max: {0})',
	statistics_page_price: 'Preço',
	statistics_page_export_price: 'Preço para exportar',
	statistics_page_set_price: 'Definir Preço',
	statistics_page_export: 'Exportar',
	statistics_page_title: "Estatísticas",
	statistics_page_desc: "Estatísticas do Mercado",
	statistics_page_money_earned: "Total de dinheiro ganho",
	statistics_page_money_spent: "Total de dinheiro gasto",
	statistics_page_goods: "Items compradas",
	statistics_page_distance_traveled: "Distância viajada",
	statistics_page_total_visits: "Total de visitas",
	statistics_page_customers: "Clientes",
	statistics_page_stock_title: 'Produtos em estoque',
	statistics_page_stock_desc: 'Quantidade de produtos da sua loja',

	goods_page_title: 'Comprar mercadorias',
	goods_page_desc: 'Aqui você pode abastecer o estoque do seu mercado',

	hire_page_title: 'Contratar entregador',
	hire_page_desc: 'Aqui você pode criar empregos para os entregadores trazerem as mercadorias para seu mercado. É importante colocar altos salários para incentivar as pessoas a aceitar o emprego.',
	hire_page_form_job_name: "Nome do emprego",
	hire_page_form_reward: "Recompensa",
	hire_page_form_amount: "Quantidade",
	hire_page_form: "Criar emprego",

	upgrades_page_title: "Melhorias",
	upgrades_page_desc: "Use seu dinheiro para melhorar o nível e obter mais lucros",

	jobs_page_select_product: 'Selecione o produto',
	jobs_page_max_amount: 'Quantidade Máxima',
	jobs_page_cost: 'Custo da unidade',
	jobs_page_amount: 'Quantidade',
	jobs_page_start: 'Começar trabalho',
	jobs_page_store_item: 'Armazenar do inventário',

	market_items_stock: 'Estoque',
	market_items_stock_full: 'Cheio',
	market_items_buy_item: 'Comprar item',
	filters_title: 'Filtros',
	filters_name_placeholder: 'Filtrar por nome',
	filters_name: 'Nome:',
	filters_has_stock: 'Tem estoque:',
	filters_price: 'Preço:',
	filters_min: 'Mínimo:',
	filters_max: 'Máximo:',
	filters_filter_btn: 'Filtrar',
	payment_method_title: 'Forma de pagamento',

	hire_page_stock_title: 'Quantidade de produtos',

	contracts_page_reward: 'Recompensas',
	contracts_page_cost: 'Custo total',
	contracts_page_item: 'Item',
	contracts_page_amount: 'Quantidade',
	contracts_page_delete: 'Deletar contrato',

	employees_title: 'Funcionários',
	employees_desc: 'Contrate funcionários para trabalhar em sua empresa',
	button_employee: 'Contratar funcionário',
	button_fire_employee: 'Demitir',
	button_give_comission: 'Dar comissão',
	input_give_comission: 'Valor da comissão',
	hired_date: 'Contratado em:',
	jobs_done: 'Trabalhos concluídos:',
	select_employee: 'Selecione um jogador',
	basic_access: 'Acesso Básico',
	advanced_access: 'Acesso Avançado',
	full_access: 'Acesso total',

	upgrade_page_stock: 'Capacidade do estoque',
	upgrade_page_stock_desc: 'Melhore a capacidade do seu estoque para obter mais espaço para armazenar seus produtos. Seus produtos serão vendidos apenas quando alguém vier a sua loja.',
	upgrade_page_truck: 'Capacidade do caminhão',
	upgrade_page_truck_desc: 'Melhore a capacidade do seu caminhão para ter um caminhão melhor para transpotar grandes quantidades de produtos. Você terá a quantidade bônus quando terminar a entrega.',
	upgrade_page_relationship: 'Relacionamento',
	upgrade_page_relationship_desc: 'Quanto melhor seu relacionamento com os fornecedores melhores serão os preços de compras. Você terá o desconto quando começar um novo trabalho.',
	upgrade_page_level: 'Nível',
	upgrade_page_units: 'unidades',
	upgrade_page_capacity: 'capacidade',
	upgrade_page_discount: 'desconto',
	upgrade_page_buy_upgrade: 'Melhorar',

	bank_page_title: "Caixa",
	bank_page_desc: "Ver todo o seu fluxo de caixa aqui. Você pode depositar ou sacar seu dinheiro",
	bank_page_price: 'Valor',
	bank_page_date: 'Data',
	bank_page_hidden_balance: "Mostrar Saldo Oculto",
	bank_page_income_expenses: "Renda / Despesas:",
	bank_page_total_money: "Total de dinheiro:",
	bank_page_withdraw: "Clique para sacar",
	bank_page_deposit: "Depositar dinheiro",
	bank_page_amount: "Quantidade",
	
	str_fill_field: "Preencha esse campo",
	str_invalid_value: "Valor invalido",
	str_more_than: "Tem que ser maior ou igual a {0}",
	str_less_than: "Tem que ser menor ou igual {0}",

	str_rename_store:"Renomear Loja",
	str_rename_store_desc:"Escolha aqui o nome da sua loja",
	btn_apply_rename:"Aplicar",
	str_rename_store_name:"Nome da loja",
	html_select_colors:`
		<option value="" selected disabled>Escolha uma cor</option>
		<option color_id="1">Vermelho</option>
		<option color_id="3">Azul</option>
		<option color_id="4">Branco (Padrão)</option>
		<option color_id="5">Amarelo</option>
		<option color_id="7">Violeta</option>
		<option color_id="8">Rosa</option>
		<option color_id="15">Ciano</option>
		<option color_id="22">Cinza</option>
		<option color_id="29">Azul Escuro</option>
		<option color_id="30">Ciano Escuro</option>
		<option color_id="32">Azul Luz</option>
		<option color_id="40">Cinza Escuro</option>
		<option color_id="46">Dourado</option>
		<option color_id="47">Laranja</option>
		<option color_id="83">Roxo</option>
	`, // Mudar apenas as cores dos nomes

	html_select_type:`
		<option value="" selected disabled>Selecione o tipo</option>
		<option blip_id="40">Esconderijo</option>
		<option blip_id="50">Garagem</option>
		<option blip_id="51">Drogas</option>
		<option blip_id="52">Mercado (Padrão)</option>
		<option blip_id="68">Caminhão de reboque</option>
		<option blip_id="71">Barbearia</option>
		<option blip_id="135">Cinema</option>
		<option blip_id="226">Bicicletas</option>
		<option blip_id="227">Carros</option>
		<option blip_id="251">Aviões</option>
		<option blip_id="273">Osso de Cachorro</option>
		<option blip_id="361">Galão de Combustivel</option>
		<option blip_id="357">Doca</option>
	` // Muda apenas o nome do local
};