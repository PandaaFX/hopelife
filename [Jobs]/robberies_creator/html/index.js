const resName = GetParentResourceName();
let hasDoorsCreator = null; // editing this is useless, don't do it

/* Forms stuff */
var forms = document.querySelectorAll('.needs-validation')

// Loop over them and prevent submission
Array.prototype.slice.call(forms)
.forEach(function (form) {
	form.addEventListener('submit', function (event) {

	event.preventDefault();

	form.classList.add('was-validated')
	}, false)
})

/* Color stuff */

function componentToHex(c) {
	var hex = c.toString(16);

	return hex.length == 1 ? "0" + hex : hex;
  }
  
function rgbToHex(r, g, b) {
	return "#" + componentToHex(r) + componentToHex(g) + componentToHex(b);
}  

function hexToRgb(hex) {
	var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);

	return result ? {
	  r: parseInt(result[1], 16),
	  g: parseInt(result[2], 16),
	  b: parseInt(result[3], 16)
	} : null;
}

/* Language stuff */
let TRANSLATIONS = {};
let ENGLISH_TRANSLATIONS = {};

function translateEverything() {
	$("body").find("[data-translation-id], [data-bs-toggle='tooltip']").each(function() {
		let translationId = $(this).data("translationId")

		if( $(this).data("bsToggle") == "tooltip" ) {
			$(this).prop("title", getLocalizedText(translationId));
			$(this).tooltip();
		} else {
			$(this).prop("innerHTML", getLocalizedText(translationId));
		}

	})
} 

function refreshTranslations(locale) {
	$.ajax({
		url: `menu_translations/en.json`,
		success: function (translationsJSON) {
			ENGLISH_TRANSLATIONS = JSON.parse(translationsJSON);

			$.ajax({
				url: `menu_translations/${locale}.json`,
				success: function (translationsJSON) {
					TRANSLATIONS = JSON.parse(translationsJSON);
		
					translateEverything();
				}
			});
		}
	});
}

function loadTranslations() {
	$.ajax({
		url: `https://${resName}/getLocale`,
		success: function (locale) {
			refreshTranslations(locale);
		}
	});
} loadTranslations();

function getLocalizedText(text) {
	return TRANSLATIONS[text] || ENGLISH_TRANSLATIONS[text] || text;
}

/* Utils */

function getFramework() {
	return new Promise((resolve) => {
		$.post(`https://${resName}/getFramework`, {}, (framework) => {
			resolve(framework)
		})
	}) 
}
async function getCurrentCoords() {
	return new Promise((resolve, reject) => {
		$.post(`https://${resName}/getCurrentCoords`, {}, function(coords) {
			resolve(coords);
		})
	});
}

async function getCurrentCoordsAndHeading() {
	return new Promise((resolve, reject) => {
		$.post(`https://${resName}/getCurrentCoordsAndHeading`, {}, function(data) {
			resolve(data);
		})
	});
}

async function placeObjectAndReturnCoords(object) {
	$("html").hide();
	return new Promise((resolve, reject) => {
		$.post(`https://${resName}/placeObjectAndReturnCoords`, JSON.stringify({object: object}), function(coords) {
			$("html").show();
			resolve(coords);
		})
	})
}

async function placeGasPoints() {
	$("html").hide();
	return new Promise((resolve, reject) => {
		$.post(`https://${resName}/placeGasPoints`, JSON.stringify(), function(gasPoints) {
			$("html").show();
			resolve(gasPoints);
		})
	})
}

// Open/Close menu
function openMenu(version, fullConfig) {
	$("#robbery-creator-version").text(version);

	loadSettings(fullConfig);
	loadHeists();
	loadCargoRobberies();
	loadPlannings();

    $("#robbery-creator").show()
}

function closeMenu() {
	// Resets current active tab
	$("#robbery-creator").find(".nav-link, .tab-pane").each(function() {
		if($(this).data("isDefault") == "1") {
			$(this).addClass(["active", "show"])
		} else {
			$(this).removeClass(["active", "show"])
		}
	})
	
    $("#robbery-creator").hide();

    $.post(`https://${resName}/close`, {})
}
$("#close-main-btn").click(closeMenu);

/* Progress bar */
let progressBarInterval = null;
function startTimedProgressBar(time, text) {
	let progressBarDiv = $("#progressbar-div");
	let progressBar = $("#progressbar")

    $("#progressbar-text").text(text);
    progressBar.css({width: `0%`});
    progressBarDiv.fadeIn();

    let minTime = time/100;

    let progress = 0;

	progressBar.css({"transition-duration": `${minTime}ms`})

    progressBarInterval = setInterval(() => {
        if(progress >= 99) {
            progressBarDiv.hide();
            clearInterval(progressBarInterval);

			progressBarInterval = null;
        } else {
            progress++;
            progressBar.css({width: `${progress}%`});
        }
    }, minTime);
}

function stopProgressBar() {
	if(progressBarInterval) {
		clearInterval(progressBarInterval);
		$("#progressbar-div").fadeOut();
	}
}
/* Progress bar END */

// Messages received by client
window.addEventListener('message', (event) => {
	let data = event.data;
	let action = data.action;

	switch(action) {

		case "openMenu": {
			openMenu(data.version, data.fullConfig);

			break;
		}

		case "hasDoorsCreator": {
			hasDoorsCreator = data.hasDoorsCreator;

			break;
		}

		case "progressBar": {
			startTimedProgressBar(data.time, data.text);

			break;
		}

		case "stopProgressBar": {
			stopProgressBar();

			break;
		}

		case "notAllowed": {
			$("#not-allowed-license").text(`
				add_ace identifier.${data.license} ${data.acePermission} allow # Add permission to ${data.nickname} Rockstar license
			`)
	
			$("#not-allowed-steamid").text(`
				add_ace identifier.${data.steamId} ${data.acePermission} allow # Add permission to ${data.nickname} Steam account
			`)
	
			$("#not-allowed-container").show();

			break;
		}
	}
})

$("#close-btn-not-allowed-menu").click(function() {
	$("#not-allowed-container").hide();
	closeMenu();
})

function loadSettings(fullConfig) {

	// Generic
	$("#settings_locale").val(fullConfig.locale);
	$("#settings_acePermission").val(fullConfig.acePermission);
	$("#settings_can_always_carry").prop("checked", fullConfig.canAlwaysCarryItem);
	$("#settings_can_receive_multiple_same_item").prop("checked", fullConfig.canReceiveMultipleTimesTheSameItem);
	$("#settings-global-timeout").val(fullConfig.globalMinutesTimeout);

	// NPC Mugging - Shared
	$("#enable-npc-mugging").prop("checked", fullConfig.isNpcMuggingEnabled).change();
	$("#seconds-to-mug").val(fullConfig.secondsToMug);

	// NPC Mugging - Client
	$("#can-make-npc-to-follow").prop("checked", fullConfig.clNpcMugging.canMakeFollow);
	$("#npc-mugging-cooldown-on-mugging").val(fullConfig.clNpcMugging.cooldownOnMugging);

	// NPC Mugging - Server
	setNpcMuggingRobbableObjects(fullConfig.svNpcMugging.robbableObjects)
	$("#npc-mugging-minimum-police").val(fullConfig.svNpcMugging.minimumPolice)
	$("#npc-mugging-probability-police-alert").val(fullConfig.svNpcMugging.probabilityPoliceAlert)
	$("#npc-mugging-minimum-objects-amount").val(fullConfig.svNpcMugging.minimumObjectsAmount)
	$("#npc-mugging-maximum-objects-amount").val(fullConfig.svNpcMugging.maximumObjectsAmount)
	$("#minutes-before-automatically-run-away").val(fullConfig.svNpcMugging.minutesAfterAutomaticallyRunAway);
	$("#npc-mugging-max-npcs-following").val(fullConfig.svNpcMugging.maxNPCsFollowing);

	// Gas mask
	$("#gas-mask-item-name").val(fullConfig.gasMask.name);
	$("#gas-mask-item-duration").val(fullConfig.gasMask.duration);
	$("#gas-mask-lose-on-use").prop("checked", fullConfig.gasMask.loseOnUse);
	$("#gas-mask-cloth-id").val(fullConfig.gasMaskClothId);

	// Drill
	$("#drill-required-for-cargo-robbery").prop("checked", fullConfig.drill.requiredForCargoRobbery);
	$("#drill-item-name").val(fullConfig.drill.name);
	$("#drill-lose-on-use").prop("checked", fullConfig.drill.loseOnUse);

	// Cargo robbery
	$("#cargo-robbery-minutes-delete-after-robbed").val(fullConfig.cargoRobbery.minutesBeforeDeleteAfterRobbed);
	$("#cargo-robbery-minutes-delete-after-arrived").val(fullConfig.cargoRobbery.minutesBeforeDeleteAfterArrived);
	$("#cargo-robbery-max-minutes-difference-from-defined-date").val(fullConfig.cargoRobbery.maxMinutesDifferenceFromDefinedDate);
	$("#cargo-robbery-probability-police-alert").val(fullConfig.cargoRobbery.probabilityPoliceAlert);

	// Discord logs
	$("#settings_isDiscordLogActive").prop("checked", fullConfig.areDiscordLogsActive);
	toggleDiscordLogsInSettings(fullConfig.areDiscordLogsActive);

	$("#settings_discordWebhook").val(fullConfig.mainDiscordWebhook);

	for(const[logType, webhook] of Object.entries(fullConfig.specificWebhooks)) {
		$("#settings_specific_webhooks").find(`[data-log-type="${logType}"]`).val(webhook);
	}
}


/* Discord logs */
function toggleDiscordLogsInSettings(enable) {
	$("#settings_discordWebhook").prop("disabled", !enable);
	$("#settings_discordWebhook").prop("required", enable);
	
	$("#settings_specific_webhooks").find(`.form-control`).prop("disabled", !enable);
}

$("#settings_isDiscordLogActive").change(function() {
	let enabled = $(this).prop("checked");

	toggleDiscordLogsInSettings(enabled);
})

function getSeparatedDiscordWebhooks() {
	let webhooks = {};

	$("#settings_specific_webhooks").find(".form-control").each(function(index, element) {
		let logType = $(element).data("logType");
		let webhook = $(element).val();

		if(webhook) {
			webhooks[logType] = webhook;
		}
	});

	return webhooks;
}
/* Discord logs END */

$("#settings").submit(function(event) {
	if (!this.checkValidity()) {
		event.preventDefault();
		event.stopPropagation();

		return;
	} else {
		$(this).removeClass("was-validated");
	}

	let clientSettings = {
		gasMaskClothId: parseInt( $("#gas-mask-cloth-id").val() )
	}

	let sharedSettings = {
		locale: $("#settings_locale").val(),
	}

	let serverSettings = {
		
		// Generic
		canAlwaysCarryItem: $("#settings_can_always_carry").prop("checked"),
		canReceiveMultipleTimesTheSameItem: $("#settings_can_receive_multiple_same_item").prop("checked"),
		acePermission: $("#settings_acePermission").val(),
		globalMinutesTimeout: parseInt( $("#settings-global-timeout").val() ),

		gasMask: {
			name: $("#gas-mask-item-name").val(),
			duration: parseInt( $("#gas-mask-item-duration").val() ),
			loseOnUse: $("#gas-mask-lose-on-use").prop("checked"),
		},

		drill: {
			requiredForCargoRobbery: $("#drill-required-for-cargo-robbery").prop("checked"),
			name: $("#drill-item-name").val(),
			loseOnUse: $("#drill-lose-on-use").prop("checked")
		},
		
		cargoRobbery: {
			minutesBeforeDeleteAfterRobbed: parseInt( $("#cargo-robbery-minutes-delete-after-robbed").val() ),
			minutesBeforeDeleteAfterArrived: parseInt( $("#cargo-robbery-minutes-delete-after-arrived").val() ),
			maxMinutesDifferenceFromDefinedDate: parseInt( $("#cargo-robbery-max-minutes-difference-from-defined-date").val() ),
			probabilityPoliceAlert: parseInt( $("#cargo-robbery-probability-police-alert").val() ),
		},

		// Discord logs
		areDiscordLogsActive: $("#settings_isDiscordLogActive").prop("checked"),
		mainDiscordWebhook: $("#settings_discordWebhook").val(),
		specificWebhooks: getSeparatedDiscordWebhooks(),
	}

	$.post(`https://${resName}/saveSettings`, JSON.stringify({
		clientSettings: clientSettings,
		sharedSettings: sharedSettings,
		serverSettings: serverSettings,
	}));

	refreshTranslations(sharedSettings.locale);
});

/*
██╗  ██╗███████╗██╗███████╗████████╗███████╗
██║  ██║██╔════╝██║██╔════╝╚══██╔══╝██╔════╝
███████║█████╗  ██║███████╗   ██║   ███████╗
██╔══██║██╔══╝  ██║╚════██║   ██║   ╚════██║
██║  ██║███████╗██║███████║   ██║   ███████║
╚═╝  ╚═╝╚══════╝╚═╝╚══════╝   ╚═╝   ╚══════╝
*/

let heistsDatatable = $("#heists-container").DataTable( {
	"lengthMenu": [10, 15, 20],
	"createdRow": function ( row, data, index ) {
		$(row).addClass("clickable");

		$(row).click(function() {
			let id = parseInt( data[0] );

			editHeist(id);
		})
	},
});

let heists = {};

function loadHeists() {
	$.post(`https://${resName}/getAllHeists`, {}, async function(rawHeists) {

		// Manually create the table to avoid incompatibilities due table indexing
		heists = {};

		for(const[k, heistData] of Object.entries(rawHeists)) {
			heists[heistData.id] = heistData;
		}

		heistsDatatable.clear();

		for(const[id, heistData] of Object.entries(heists)) {
			heistsDatatable.row.add([
				id,
				heistData.label,
				heistData.stages.length
			]);
		}

		heistsDatatable.draw();
	})
}

function setDefaultDataOfHeistModal() {
	$("#heist-label").val("Default");
	$("#heist-minimum-police").val(0);
	$("#heist-timeout").val(120);
	$("#heist-reset").val(60);
	$("#heist-time-limit-minutes").val(0);

	$("#heist-stages").empty();
}

$("#new-heist-btn").click(function() {
	let heistModal = $("#heist-modal");

	// Converts from edit modal to create modal
	heistModal.data("action", "create");
	
	$("#delete-heist-btn").hide();
	$("#save-heist-btn").text( getLocalizedText("menu:create") );
	
	setDefaultDataOfHeistModal();

	heistModal.modal("show");
})

function editHeist(id) {
	let heistData = heists[id];

	let heistModal = $("#heist-modal");

	heistModal.data("action", "edit");
	heistModal.data("heistId", id);
	
	$("#delete-heist-btn").show();
	$("#save-heist-btn").text( getLocalizedText("menu:save") );

	$("#heist-label").val(heistData.label);
	$("#heist-minimum-police").val(heistData.minimumPolice);
	$("#heist-timeout").val(heistData.timeoutMinutes);
	$("#heist-reset").val(heistData.minutesBeforeReset);
	$("#heist-time-limit-minutes").val(heistData.timeLimitMinutes);


	$("#heist-stages").empty();
	heistData.stages.forEach(stage => {
		addHeistStage(stage);
	})

	heistModal.modal("show");
}

function getAllRobbableObjectsFromStageDiv(stageDiv) {
	let robbableObjects = [];

	stageDiv.find(".robbable-object").each(function() {
		let robbableObjectDiv = $(this);

		let robbableObject = {
			method: "ROBBABLE_OBJECT",
			type: robbableObjectDiv.find(".object-type").val(),
			coords: {
				x: parseFloat( robbableObjectDiv.find(".coords-x").val() ),
				y: parseFloat( robbableObjectDiv.find(".coords-y").val() ),
				z: parseFloat( robbableObjectDiv.find(".coords-z").val() ),
			},
			heading: parseFloat( robbableObjectDiv.find(".heading").val() ),	
			blipData : robbableObjectDiv.data("blipData") || getDefaultBlipCustomization(),
			item: {
				type: robbableObjectDiv.find(".item-type").val(),
				name: robbableObjectDiv.find(".item-name").val(),
				minQuantity: parseInt( robbableObjectDiv.find(".item-min-quantity").val() ),
				maxQuantity: parseInt( robbableObjectDiv.find(".item-max-quantity").val() ),
			},
			isOptional: robbableObjectDiv.find(".is-optional-checkbox").prop("checked"),
			isInvisible: robbableObjectDiv.find(".is-invisible-checkbox").prop("checked"),
		}

		robbableObjects.push(robbableObject);
	});

	return robbableObjects
}

function getAllPaintingsFromStageDiv(stageDiv) {
	let paintings = [];

	stageDiv.find(".painting").each(function() {
		let paintingDiv = $(this);

		let painting = {
			method: "PAINTING",
			type: paintingDiv.find(".object-type").val(),
			coords: {
				x: parseFloat( paintingDiv.find(".coords-x").val() ),
				y: parseFloat( paintingDiv.find(".coords-y").val() ),
				z: parseFloat( paintingDiv.find(".coords-z").val() ),
			},
			heading: parseFloat( paintingDiv.find(".heading").val() ),	
			blipData : paintingDiv.data("blipData") || getDefaultBlipCustomization(),
			item: {
				type: paintingDiv.find(".item-type").val(),
				name: paintingDiv.find(".item-name").val(),
				minQuantity: parseInt( paintingDiv.find(".item-min-quantity").val() ),
				maxQuantity: parseInt( paintingDiv.find(".item-max-quantity").val() ),
			},
			isOptional: paintingDiv.find(".is-optional-checkbox").prop("checked"),
			isInvisible: paintingDiv.find(".is-invisible-checkbox").prop("checked"),
		}

		paintings.push(painting);
	});

	return paintings
}

function getGuardsFromGuardsDiv(guardsDiv) {
	let guards = [];

	guardsDiv.find(".guard").each(function() {
		let guardDiv = $(this);

		let guard = {
			model: guardDiv.find(".guard-model").val(),
			weapon: guardDiv.find(".guard-weapon").val(),
			coords: {
				x: parseFloat( guardDiv.find(".coords-x").val() ),
				y: parseFloat( guardDiv.find(".coords-y").val() ),
				z: parseFloat( guardDiv.find(".coords-z").val() ),
			},
			heading: parseFloat( guardDiv.find(".heading").val() ),
		}

		guards.push(guard);
	});

	return guards;
}

function getAllGuardsFromStageDiv(stageDiv) {
	let guards = [];

	stageDiv.find(".guards").each(function() {
		let guardsDiv = $(this);

		let currentGuards = {
			method: "GUARDS",
			difficulty: parseInt( guardsDiv.find(".difficulty").val() ),
			headshotOneshot: guardsDiv.find(".headshot-oneshot-checkbox").prop("checked"),
			guardsList: getGuardsFromGuardsDiv(guardsDiv),
		}

		guards.push(currentGuards);
	});

	return guards
}

function getAllItemsFromSafeDiv(safeDiv) {
	let items = [];

	safeDiv.find(".safe-item").each(function() {
		let itemDiv = $(this);

		let item = {
			type: itemDiv.find(".item-type").val(),
			name: itemDiv.find(".item-name").val(),
			minQuantity: parseInt( itemDiv.find(".item-min-quantity").val() ),
			maxQuantity: parseInt( itemDiv.find(".item-max-quantity").val() ),
			chances: parseInt( itemDiv.find(".item-chances").val() ),
		}

		items.push(item);
	});

	return items
}

function getAllSafesFromStageDiv(stageDiv) {
	let safes = [];

	stageDiv.find(".safe").each(function() {
		let safeDiv = $(this);

		let safe = {
			method: "SAFE",
			type: safeDiv.find(".object-type").val(),
			coords: {
				x: parseFloat( safeDiv.find(".coords-x").val() ),
				y: parseFloat( safeDiv.find(".coords-y").val() ),
				z: parseFloat( safeDiv.find(".coords-z").val() ),
			},
			heading: parseFloat( safeDiv.find(".heading").val() ),	
			blipData : safeDiv.data("blipData") || getDefaultBlipCustomization(),
			items: getAllItemsFromSafeDiv(safeDiv),
			difficulty: parseInt( safeDiv.find(".difficulty").val() ),
			minObjectsAmount: parseInt( safeDiv.find(".min-objects-amount").val() ),
			maxObjectsAmount: parseInt( safeDiv.find(".max-objects-amount").val() ),
			isOptional: safeDiv.find(".is-optional-checkbox").prop("checked"),
			isInvisible: safeDiv.find(".is-invisible-checkbox").prop("checked"),
			requiredItem: getRequiredItemFromDiv( safeDiv.find(".required-item-div") ),
			alarms: safeDiv.data("alarms")
		}

		safes.push(safe);
	});

	return safes
}

function getAllHackablePannelsFromStageDiv(stageDiv) {
	let hackablePanels = [];

	stageDiv.find(".hackable-panel").each(function() {
		let hackablePanelDiv = $(this);

		let hackablePanel = {
			type: "hackable_panel", // for the object model
			method: "HACKABLE_PANEL",
			coords: {
				x: parseFloat( hackablePanelDiv.find(".coords-x").val() ),
				y: parseFloat( hackablePanelDiv.find(".coords-y").val() ),
				z: parseFloat( hackablePanelDiv.find(".coords-z").val() ),
			},
			heading: parseFloat( hackablePanelDiv.find(".heading").val() ),	
			blipData : hackablePanelDiv.data("blipData") || getDefaultBlipCustomization(),
			isOptional: hackablePanelDiv.find(".is-optional-checkbox").prop("checked"),
			difficulty: parseInt( hackablePanelDiv.find(".difficulty").val() ),
			isInvisible: hackablePanelDiv.find(".is-invisible-checkbox").prop("checked"),
			doorsToOpen: hackablePanelDiv.data("doorsToOpen"),
			alarms: hackablePanelDiv.data("alarms"),
			requiredItem: getRequiredItemFromDiv( hackablePanelDiv.find(".required-item-div") ),
			minigameToUse: hackablePanelDiv.find(".minigame-to-use").val()
		}

		hackablePanels.push(hackablePanel);
	});

	return hackablePanels
}

function getRequiredItemFromDiv(requiredItemDiv) {
	let requiresItem = requiredItemDiv.find(".requires-an-item-checkbox").prop("checked");
	
	if(requiresItem) {
		return {
			name: requiredItemDiv.find(".required-item-name").val(),
			quantity: parseInt( requiredItemDiv.find(".required-item-quantity").val() ),
			loseOnUse: requiredItemDiv.find(".required-item-lose-on-use-checkbox").prop("checked"),
		}
	} else {
		return null;
	}
}

function getAllThermalChargesFromStageDiv(stageDiv) {
	let thermalCharges = [];

	stageDiv.find(".thermal-charge").each(function() {
		let thermalChargeDiv = $(this);

		let thermalCharge = {
			type: "thermal_charge", // for the object model
			method: "THERMAL_CHARGE",
			coords: {
				x: parseFloat( thermalChargeDiv.find(".coords-x").val() ),
				y: parseFloat( thermalChargeDiv.find(".coords-y").val() ),
				z: parseFloat( thermalChargeDiv.find(".coords-z").val() ),
			},
			blipData : thermalChargeDiv.data("blipData") || getDefaultBlipCustomization(),
			isOptional: thermalChargeDiv.find(".is-optional-checkbox").prop("checked"),
			doorsToOpen: thermalChargeDiv.data("doorsToOpen"),
			duration: parseInt( thermalChargeDiv.find(".duration").val() ),
			requiredItem: getRequiredItemFromDiv(thermalChargeDiv.find(".required-item-div")),
			alarms: thermalChargeDiv.data("alarms"),
		}

		thermalCharges.push(thermalCharge);
	});

	return thermalCharges
}

function getAllLockpickableDoorsFromStageDiv(stageDiv) {
	let lockpickableDoors = [];

	stageDiv.find(".lockpickable-door").each(function() {
		let lockpickableDoorDiv = $(this);

		let lockpickableDoor = {
			type: "lockpickable_door", // for the object model
			method: "LOCKPICKABLE_DOOR",
			coords: {
				x: parseFloat( lockpickableDoorDiv.find(".coords-x").val() ),
				y: parseFloat( lockpickableDoorDiv.find(".coords-y").val() ),
				z: parseFloat( lockpickableDoorDiv.find(".coords-z").val() ),
			},
			blipData : lockpickableDoorDiv.data("blipData") || getDefaultBlipCustomization(),
			isOptional: lockpickableDoorDiv.find(".is-optional-checkbox").prop("checked"),
			doorsToOpen: lockpickableDoorDiv.data("doorsToOpen"),
			difficulty: parseInt( lockpickableDoorDiv.find(".difficulty").val() ),
			requiredItem: getRequiredItemFromDiv(lockpickableDoorDiv.find(".required-item-div")),
			alarms: lockpickableDoorDiv.data("alarms"),
		}

		lockpickableDoors.push(lockpickableDoor);
	});

	return lockpickableDoors
}

function getAllLethalGassesFromStageDiv(stageDiv) {
	let lethalGases = [];

	stageDiv.find(".lethal-gas").each(function() {
		let lethalGasDiv = $(this);

		let lethalGas = {
			type: "lethal_gas", // for the object model
			method: "LETHAL_GAS",
			gasPoints: lethalGasDiv.data("gasPoints"),
			duration: parseInt( lethalGasDiv.find(".duration").val() ),
			damage: parseInt( lethalGasDiv.find(".damage").val() ),
			secondsBeforeStart: parseInt( lethalGasDiv.find(".seconds-before-start").val() ),
			color: hexToRgb( lethalGasDiv.find(".gas-color").val() ),
		}

		lethalGases.push(lethalGas);
	});

	return lethalGases
}

function getHeistStages() {
	let stages = [];

	$("#heist-stages").find(".stage").each(function(index) {
		let stageDiv = $(this);

		let stage = {
			steps: [
				...getAllRobbableObjectsFromStageDiv(stageDiv),
				...getAllSafesFromStageDiv(stageDiv),
				...getAllPaintingsFromStageDiv(stageDiv),
				...getAllGuardsFromStageDiv(stageDiv),
				...getAllHackablePannelsFromStageDiv(stageDiv),
				...getAllThermalChargesFromStageDiv(stageDiv),
				...getAllLockpickableDoorsFromStageDiv(stageDiv),
				...getAllLethalGassesFromStageDiv(stageDiv),
			],
		}

		stages.push(stage);
	})

	return stages
}

$("#heist-form").submit(function(event) {
	if (!this.checkValidity()) {
		event.preventDefault();
		event.stopPropagation();

		return;
	} else {
		$(this).removeClass("was-validated");
	}

	let heistModal = $("#heist-modal");
	let action = heistModal.data("action");

	let heistData = {
		label: $("#heist-label").val(),
		minimumPolice: parseInt( $("#heist-minimum-police").val() ),
		timeoutMinutes: parseInt( $("#heist-timeout").val() ),
		minutesBeforeReset: parseInt( $("#heist-reset").val() ),
		timeLimitMinutes: parseInt( $("#heist-time-limit-minutes").val() ),

		stages: getHeistStages()
	}

	switch(action) {
		case "create": {
			$.post(`https://${resName}/createHeist`, JSON.stringify(heistData), function(isSuccessful) {
				if(isSuccessful) {
					heistModal.modal("hide");
					loadHeists();
				}
			});

			break;
		}

		case "edit": {
			$.post(`https://${resName}/updateHeist`, JSON.stringify({heistId: heistModal.data("heistId"), heistData: heistData}), function(isSuccessful) {
				if(isSuccessful) {
					heistModal.modal("hide");
					loadHeists();
				}
			});

			break;
		}
	}

});

$("#delete-heist-btn").click(function() {
	let heistModal = $("#heist-modal");
	let heistId = heistModal.data("heistId");

	$.post(`https://${resName}/deleteHeist`, JSON.stringify({heistId: heistId}), function(isSuccessful) {
		if(isSuccessful) {
			heistModal.modal("hide");
			loadHeists();
		}
	});
})

async function addRobbableObjectHeist(stageDiv, robbableObject) {
	let robbableObjectDiv = $(`
		<div class="robbable-object mb-5">
			<p class="text-center text-success fs-4">${getLocalizedText("menu:robbable_object")}</p>

			<div class="row g-2 row-cols-auto align-items-center justify-content-center">

				<button type="button" class="btn btn-danger delete-robbable-object-btn me-3" ><i class="bi bi-trash-fill"></i></button>	

				<select class="form-select object-type" style="width: auto;">
					<option selected value="cash_1">${ getLocalizedText("menu:cash_1") }</option>
					<option value="cash_2">${ getLocalizedText("menu:cash_2") }</option>
					<option value="cash_3">${ getLocalizedText("menu:cash_3") }</option>
					<option value="gold_1">${ getLocalizedText("menu:gold_1") }</option>
					<option value="gold_2">${ getLocalizedText("menu:gold_2") }</option>
					<option value="gold_3">${ getLocalizedText("menu:gold_3") }</option>
					<option value="diamond_1">${ getLocalizedText("menu:diamond_1") }</option>
					<option value="diamond_2">${ getLocalizedText("menu:diamond_2") }</option>
				</select>

				<!-- Coords and heading -->
				<div class="form-floating text-body col-1 ms-4">
					<input type="number" step="0.01" class="form-control coords-x" placeholder="X" required>
					<label>${ getLocalizedText("menu:x") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-y" placeholder="Y" required>
					<label>${ getLocalizedText("menu:y") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-z" placeholder="Z" required>
					<label>${ getLocalizedText("menu:z") }</label>
				</div>
				
				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control heading" placeholder="Heading" required>
					<label>${ getLocalizedText("menu:heading") }</label>
				</div>		

				<button type="button" class="btn btn-secondary col-auto choose-coords-and-heading-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:place_object") }"><i class="bi bi-arrow-down-square"></i></button>	

				<button type="button" class="btn btn-secondary ms-3 customize-blip-btn">${getLocalizedText("menu:customize_blip")}</button>

				<div class="form-check fs-5 ms-3">
					<input class="form-check-input is-optional-checkbox" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:is_optional")}</label>
				</div>

				<div class="form-check fs-5 ms-3">
					<input class="form-check-input is-invisible-checkbox" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:is_invisible")}</label>
				</div>
			</div>

			<div class="row g-2 row-cols-auto align-items-center text-body my-2 robbable-item justify-content-center">
				<select class="form-select item-type" style="width: auto;">
					<option selected value="item">${getLocalizedText("menu:item")}</option>
					<option value="account">${getLocalizedText("menu:account")}</option>
					${await getFramework() == "ESX" ? `<option value="weapon">${getLocalizedText("menu:weapon")}</option>` : ""}
				</select>
				
				<div class="form-floating">
					<input type="text" class="form-control item-name" placeholder="Name" required>
					<label>${ getLocalizedText("menu:object_name") }</label>
				</div>

				<button type="button" class="btn btn-secondary col-auto choose-robbable-item-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>	

				<div class="form-floating">
					<input type="number" min=0 class="form-control item-min-quantity" placeholder="${getLocalizedText("menu:min_quantity")}" required>
					<label>${getLocalizedText("menu:min_quantity")}</label>
				</div>

				<div class="form-floating">
					<input type="number"  class="form-control item-max-quantity" placeholder="${getLocalizedText("menu:max_quantity")}" required>
					<label>${getLocalizedText("menu:max_quantity")}</label>
				</div>
			</div>

			<hr>
		</div>
	`);

	robbableObjectDiv.find(".choose-coords-and-heading-btn").click(async function() {
		let objectType = robbableObjectDiv.find(".object-type").val();

		let data = await placeObjectAndReturnCoords(objectType);

		if(data) {
			robbableObjectDiv.find(".coords-x").val(data.coords.x);
			robbableObjectDiv.find(".coords-y").val(data.coords.y);
			robbableObjectDiv.find(".coords-z").val(data.coords.z);
			robbableObjectDiv.find(".heading").val(data.heading);
		}
	}).tooltip();

	robbableObjectDiv.find(".customize-blip-btn").click(async function() {
		let oldBlipData = robbableObjectDiv.data("blipData");
		let blipData = await blipDialog(oldBlipData)

		robbableObjectDiv.data("blipData", blipData);
	})

	robbableObjectDiv.find(".delete-robbable-object-btn").click(function() {
		robbableObjectDiv.remove();
	})

	robbableObjectDiv.find(".choose-robbable-item-btn").click(async function() {
		let objectType = robbableObjectDiv.find(".robbable-item").find(".item-type").val();

		let objectName = await objectDialog(objectType);

		robbableObjectDiv.find(".item-name").val(objectName);
	}).tooltip();

	// Sets value if the object is not new
	if(robbableObject) {
		robbableObjectDiv.find(".object-type").val(robbableObject.type);
		robbableObjectDiv.find(".coords-x").val(robbableObject.coords.x);
		robbableObjectDiv.find(".coords-y").val(robbableObject.coords.y);
		robbableObjectDiv.find(".coords-z").val(robbableObject.coords.z);
		robbableObjectDiv.find(".heading").val(robbableObject.heading);
		robbableObjectDiv.data("blipData", robbableObject.blipData);
		robbableObjectDiv.find(".item-type").val(robbableObject.item.type);
		robbableObjectDiv.find(".item-name").val(robbableObject.item.name);
		robbableObjectDiv.find(".item-min-quantity").val(robbableObject.item.minQuantity);
		robbableObjectDiv.find(".item-max-quantity").val(robbableObject.item.maxQuantity);
		robbableObjectDiv.find(".is-optional-checkbox").prop("checked", robbableObject.isOptional);
		robbableObjectDiv.find(".is-invisible-checkbox").prop("checked", robbableObject.isInvisible);
	}

	stageDiv.find(".steps-list").append(robbableObjectDiv);
}

async function addPaintingHeist(stageDiv, painting) {
	let paintingDiv = $(`
		<div class="painting mb-5">
			<p class="text-center text-success fs-4">${getLocalizedText("menu:painting")}</p>

			<div class="row g-2 row-cols-auto align-items-center justify-content-center">

				<button type="button" class="btn btn-danger delete-robbable-object-btn me-3" ><i class="bi bi-trash-fill"></i></button>	

				<select class="form-select object-type" style="width: auto;">
					<option selected value="painting_1">${ getLocalizedText("menu:painting") } 1</option>
					<option value="painting_2">${ getLocalizedText("menu:painting") } 2</option>
					<option value="painting_3">${ getLocalizedText("menu:painting") } 3</option>
					<option value="painting_4">${ getLocalizedText("menu:painting") } 4</option>
					<option value="painting_5">${ getLocalizedText("menu:painting") } 5</option>
					<option value="painting_6">${ getLocalizedText("menu:painting") } 6</option>
					<option value="painting_7">${ getLocalizedText("menu:painting") } 7</option>
					<option value="painting_8">${ getLocalizedText("menu:painting") } 8</option>
					<option value="painting_9">${ getLocalizedText("menu:painting") } 9</option>
					<option value="painting_10">${ getLocalizedText("menu:painting") } 10</option>
				</select>

				<!-- Coords and heading -->
				<div class="form-floating text-body col-1 ms-4">
					<input type="number" step="0.01" class="form-control coords-x" placeholder="X" required>
					<label>${ getLocalizedText("menu:x") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-y" placeholder="Y" required>
					<label>${ getLocalizedText("menu:y") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-z" placeholder="Z" required>
					<label>${ getLocalizedText("menu:z") }</label>
				</div>
				
				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control heading" placeholder="Heading" required>
					<label>${ getLocalizedText("menu:heading") }</label>
				</div>		

				<button type="button" class="btn btn-secondary col-auto choose-coords-and-heading-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:place_object") }"><i class="bi bi-arrow-down-square"></i></button>	

				<button type="button" class="btn btn-secondary ms-3 customize-blip-btn">${getLocalizedText("menu:customize_blip")}</button>

				<div class="form-check fs-5 ms-3">
					<input class="form-check-input is-optional-checkbox" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:is_optional")}</label>
				</div>

				<div class="form-check fs-5 ms-3">
					<input class="form-check-input is-invisible-checkbox" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:is_invisible")}</label>
				</div>
			</div>

			<div class="row g-2 row-cols-auto align-items-center text-body my-2 robbable-item justify-content-center">
				<select class="form-select item-type" style="width: auto;">
					<option selected value="item">${getLocalizedText("menu:item")}</option>
					<option value="account">${getLocalizedText("menu:account")}</option>
					${await getFramework() == "ESX" ? `<option value="weapon">${getLocalizedText("menu:weapon")}</option>` : ""}
				</select>
				
				<div class="form-floating">
					<input type="text" class="form-control item-name" placeholder="Name" required>
					<label>${ getLocalizedText("menu:object_name") }</label>
				</div>

				<button type="button" class="btn btn-secondary col-auto choose-robbable-item-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>	

				<div class="form-floating">
					<input type="number" min=0 class="form-control item-min-quantity" placeholder="${getLocalizedText("menu:min_quantity")}" required>
					<label>${getLocalizedText("menu:min_quantity")}</label>
				</div>

				<div class="form-floating">
					<input type="number"  class="form-control item-max-quantity" placeholder="${getLocalizedText("menu:max_quantity")}" required>
					<label>${getLocalizedText("menu:max_quantity")}</label>
				</div>
			</div>

			<hr>
		</div>
	`);

	paintingDiv.find(".choose-coords-and-heading-btn").click(async function() {
		let objectType = paintingDiv.find(".object-type").val();

		let data = await placeObjectAndReturnCoords(objectType);

		if(data) {
			paintingDiv.find(".coords-x").val(data.coords.x);
			paintingDiv.find(".coords-y").val(data.coords.y);
			paintingDiv.find(".coords-z").val(data.coords.z);
			paintingDiv.find(".heading").val(data.heading);
		}
	}).tooltip();

	paintingDiv.find(".customize-blip-btn").click(async function() {
		let oldBlipData = paintingDiv.data("blipData");
		let blipData = await blipDialog(oldBlipData)

		paintingDiv.data("blipData", blipData);
	})

	paintingDiv.find(".delete-robbable-object-btn").click(function() {
		paintingDiv.remove();
	})

	paintingDiv.find(".choose-robbable-item-btn").click(async function() {
		let objectType = paintingDiv.find(".robbable-item").find(".item-type").val();

		let objectName = await objectDialog(objectType);

		paintingDiv.find(".item-name").val(objectName);
	}).tooltip();

	// Sets value if the object is not new
	if(painting) {
		paintingDiv.find(".object-type").val(painting.type);
		paintingDiv.find(".coords-x").val(painting.coords.x);
		paintingDiv.find(".coords-y").val(painting.coords.y);
		paintingDiv.find(".coords-z").val(painting.coords.z);
		paintingDiv.find(".heading").val(painting.heading);
		paintingDiv.data("blipData", painting.blipData);
		paintingDiv.find(".item-type").val(painting.item.type);
		paintingDiv.find(".item-name").val(painting.item.name);
		paintingDiv.find(".item-min-quantity").val(painting.item.minQuantity);
		paintingDiv.find(".item-max-quantity").val(painting.item.maxQuantity);
		paintingDiv.find(".is-optional-checkbox").prop("checked", painting.isOptional);
		paintingDiv.find(".is-invisible-checkbox").prop("checked", painting.isInvisible);
	}

	stageDiv.find(".steps-list").append(paintingDiv);
}

function addGuardToGuardsDiv(guardsDiv, guard) {
	let guardDiv = $(`
		<div class="row g-2 row-cols-auto align-items-center justify-content-center mb-2 guard">
			<button type="button" class="btn-close delete-guard-btn me-3" ></button>	

			<div class="form-floating text-body col-2" >
				<input type="text" class="form-control guard-model" placeholder="Guard model" required value="cs_casey">
				<label>${ getLocalizedText("menu:guard_model") }</label>
			</div>

			<div class="form-floating text-body col-2" >
				<input type="text" class="form-control guard-weapon" placeholder="Guard weapon" required value="weapon_pistol">
				<label>${ getLocalizedText("menu:guard_weapon") }</label>
			</div>

			<!-- Coords and heading -->
			<div class="form-floating text-body col-1 ms-4">
				<input type="number" step="0.01" class="form-control coords-x" placeholder="X" required>
				<label>${ getLocalizedText("menu:x") }</label>
			</div>

			<div class="form-floating text-body col-1">
				<input type="number" step="0.01" class="form-control coords-y" placeholder="Y" required>
				<label>${ getLocalizedText("menu:y") }</label>
			</div>

			<div class="form-floating text-body col-1">
				<input type="number" step="0.01" class="form-control coords-z" placeholder="Z" required>
				<label>${ getLocalizedText("menu:z") }</label>
			</div>
			
			<div class="form-floating text-body col-1">
				<input type="number" step="0.01" class="form-control heading" placeholder="Heading" required>
				<label>${ getLocalizedText("menu:heading") }</label>
			</div>	

			<button type="button" class="btn btn-secondary col-auto choose-coords-and-heading-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:place_object") }"><i class="bi bi-arrow-down-square"></i></button>	
		</div>
	`);
	
	guardDiv.find(".delete-guard-btn").click(function() {
		guardDiv.remove();
	});

	guardDiv.find(".choose-coords-and-heading-btn").click(async function() {
		let data = await placeObjectAndReturnCoords();

		if(data) {
			guardDiv.find(".coords-x").val(data.coords.x);
			guardDiv.find(".coords-y").val(data.coords.y);
			guardDiv.find(".coords-z").val(data.coords.z);
			guardDiv.find(".heading").val(data.heading);
		}
	}).tooltip();

	if(guard) {
		guardDiv.find(".guard-model").val(guard.model);
		guardDiv.find(".guard-weapon").val(guard.weapon);
		guardDiv.find(".coords-x").val(guard.coords.x);
		guardDiv.find(".coords-y").val(guard.coords.y);
		guardDiv.find(".coords-z").val(guard.coords.z);
		guardDiv.find(".heading").val(guard.heading);
	}

	guardsDiv.find(".guards-list").append(guardDiv);
}

async function addGuardsHeist(stageDiv, guards) {
	let guardsDiv = $(`
		<div class="guards mb-5">
			<p class="text-center text-success fs-4">${getLocalizedText("menu:guards")}</p>

			<div class="row g-2 row-cols-auto align-items-center justify-content-center">
				<button type="button" class="btn btn-danger delete-guards-btn me-3" ><i class="bi bi-trash-fill"></i></button>	

				<div class="form-floating text-body col-3" >
					<input type="number" class="form-control difficulty" placeholder="Difficulty" required min="1" max="5" data-bs-toggle="tooltip" data-bs-placement="top" title="1-5">
					<label>${ getLocalizedText("menu:difficulty") }</label>
				</div>

				<div class="form-check fs-4 ms-3">
					<input class="form-check-input headshot-oneshot-checkbox" type="checkbox" value="" checked>
					<label class="form-check-label">${getLocalizedText("menu:headshot_will_oneshot")}</label>
				</div>
			</div>

			<p class="text-center fs-5 mt-3">${ getLocalizedText("menu:guards_list") }</p>

			<div class="guards-list">

			</div>

			<div class="d-inline-block col-12 my-2">
				<button type="button" class="btn btn-primary ms-3 add-guard-btn float-end">${ getLocalizedText("menu:add_guard") }</button>
			</div>

			<hr>
		</div>
	`);

	guardsDiv.find(".difficulty").tooltip();

	guardsDiv.find(".delete-guards-btn").click(function() {
		guardsDiv.remove();
	});

	guardsDiv.find(".add-guard-btn").click(function() {
		addGuardToGuardsDiv(guardsDiv);
	});

	if(guards) {

		guardsDiv.find(".difficulty").val(guards.difficulty);
		guardsDiv.find(".headshot-oneshot-checkbox").prop("checked", guards.headshotOneshot);

		if(guards.guardsList) {
			guards.guardsList.forEach(guard => {
				addGuardToGuardsDiv(guardsDiv, guard);
			});
		}
	}

	stageDiv.find(".steps-list").append(guardsDiv);
}

async function addItemInSafe(safeDiv, item) {
	let safeItemDiv = $(`
		<div class="row g-2 row-cols-auto align-items-center text-body my-2 safe-item justify-content-center">

			<button type="button" class="btn-close delete-safe-item-btn me-3" ></button>	

			<select class="form-select item-type" style="width: auto;">
				<option selected value="item">${getLocalizedText("menu:item")}</option>
				<option value="account">${getLocalizedText("menu:account")}</option>
				${await getFramework() == "ESX" ? `<option value="weapon">${getLocalizedText("menu:weapon")}</option>` : ""}
			</select>
			
			<div class="form-floating">
				<input type="text" class="form-control item-name" placeholder="Name" required>
				<label>${ getLocalizedText("menu:object_name") }</label>
			</div>

			<button type="button" class="btn btn-secondary col-auto choose-item-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>	

			<div class="form-floating">
				<input type="number" min=0 class="form-control item-min-quantity" placeholder="${getLocalizedText("menu:min_quantity")}" required>
				<label>${getLocalizedText("menu:min_quantity")}</label>
			</div>

			<div class="form-floating">
				<input type="number"  class="form-control item-max-quantity" placeholder="${getLocalizedText("menu:max_quantity")}" required>
				<label>${getLocalizedText("menu:max_quantity")}</label>
			</div>

			<div class="form-floating">
				<input type="number"  class="form-control item-chances" placeholder="${getLocalizedText("menu:probability")}" required>
				<label>${getLocalizedText("menu:probability")}</label>
			</div>
		</div>
	`);

	safeItemDiv.find(".delete-safe-item-btn").click(function() {
		safeItemDiv.remove();
	})

	safeItemDiv.find(".choose-item-btn").click(async function() {
		let objectType = safeItemDiv.find(".item-type").val();

		let objectName = await objectDialog(objectType);

		safeItemDiv.find(".item-name").val(objectName);
	}).tooltip();

	if(item) {
		safeItemDiv.find(".item-type").val(item.type);
		safeItemDiv.find(".item-name").val(item.name);
		safeItemDiv.find(".item-min-quantity").val(item.minQuantity);
		safeItemDiv.find(".item-max-quantity").val(item.maxQuantity);
		safeItemDiv.find(".item-chances").val(item.chances);
	}

	safeDiv.find(".safe-items-list").append(safeItemDiv);
}

function addSafeHeist(stageDiv, safe) {
	let safeDiv = $(`
		<div class="safe mb-5">
			<p class="text-center text-success fs-4">${getLocalizedText("menu:safe")}</p>

			<div class="row g-2 row-cols-auto align-items-center justify-content-center">

				<button type="button" class="btn btn-danger delete-safe-btn me-3" ><i class="bi bi-trash-fill"></i></button>	

				<select class="form-select object-type" style="width: auto;">
					<option value="safe_big" selected>${ getLocalizedText("menu:safe_big") }</option>
					<option value="safe_little">${ getLocalizedText("menu:safe_little") }</option>
				</select>

				<!-- Coords and heading -->
				<div class="form-floating text-body col-1 ms-4">
					<input type="number" step="0.01" class="form-control coords-x" placeholder="X" required>
					<label>${ getLocalizedText("menu:x") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-y" placeholder="Y" required>
					<label>${ getLocalizedText("menu:y") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-z" placeholder="Z" required>
					<label>${ getLocalizedText("menu:z") }</label>
				</div>
				
				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control heading" placeholder="Heading" required>
					<label>${ getLocalizedText("menu:heading") }</label>
				</div>		

				<button type="button" class="btn btn-secondary col-auto choose-coords-and-heading-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:place_object") }"><i class="bi bi-arrow-down-square"></i></button>	

				<button type="button" class="btn btn-secondary ms-3 customize-blip-btn">${getLocalizedText("menu:customize_blip")}</button>

				<div class="form-floating text-body col-1 ms-4">
					<input type="number" min=1 class="form-control difficulty" placeholder="Difficulty" required>
					<label>${ getLocalizedText("menu:difficulty") }</label>
				</div>

				<div class="form-check fs-5 ms-3">
					<input class="form-check-input is-optional-checkbox" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:is_optional")}</label>
				</div>
			</div>

			<div class="required-item-div row g-2 row-cols-auto align-items-center justify-content-center mt-3">
				<div class="form-check fs-5 ms-3">
					<input class="form-check-input is-optional-checkbox requires-an-item-checkbox" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:requires_an_item")}</label>
				</div>

				<div class="row g-2 row-cols-auto align-items-center">
					<div class="form-floating text-body col-3">
						<input type="text" class="form-control required-item-name" placeholder="Item name">
						<label>${ getLocalizedText("menu:item_name") }</label>
					</div>

					<button type="button" class="btn btn-secondary col-auto choose-item-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>	

					<div class="form-floating text-body col-2">
						<input type="text" class="form-control required-item-quantity" placeholder="Quantity">
						<label>${ getLocalizedText("menu:quantity") }</label>
					</div>

					<div class="form-check fs-5 ms-1">
						<input class="form-check-input is-optional-checkbox required-item-lose-on-use-checkbox" type="checkbox" value="">
						<label class="form-check-label">${getLocalizedText("menu:lose_on_use")}</label>
					</div>

					<button type="button" class="btn btn-secondary col-auto ms-5 setup-alarm-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:setup_alarms") }"><i class="bi bi-bell"></i></button>	
					
					<div class="form-check fs-5 ms-3">
						<input class="form-check-input is-invisible-checkbox" type="checkbox" value="">
						<label class="form-check-label">${getLocalizedText("menu:is_invisible")}</label>
					</div>
				</div>
				
			</div>

			<div class="my-4 row g-2 row-cols-auto align-items-center justify-content-center">
				<p class="text-center fs-4 my-auto me-3">${ getLocalizedText("menu:amount_of_objects_from_the_safe") }</p>

				<div class="form-floating text-body col-3">
					<input type="number" min="1" class="form-control min-objects-amount" placeholder="Minimum" required>
					<label>${ getLocalizedText("menu:min_quantity") }</label>
				</div>

				<div class="form-floating text-body col-3">
					<input type="number" min="1" class="form-control max-objects-amount" placeholder="Maximum" required>
					<label>${ getLocalizedText("menu:max_quantity") }</label>
				</div>
			</div>

			<div class="safe-items-list">

			</div>

			<div class="d-inline-block col-12 my-2">
				<button type="button" class="btn btn-primary ms-3 add-item-btn float-end">${ getLocalizedText("menu:add_item") }</button>
			</div>

			<hr>
		</div>
	`);

	safeDiv.find(".setup-alarm-btn").click(async function() {
		let currentAlarms = safeDiv.data("alarms");

		let alarms = await alarmsDialog(currentAlarms);
		
		safeDiv.data("alarms", alarms);
	}).tooltip();

	safeDiv.find(".requires-an-item-checkbox").change(function() {
		toggleRequiredItem(safeDiv.find(".required-item-div"));
	});

	safeDiv.find(".choose-item-btn").click(async function() {
		let itemName = await itemsDialog();

		safeDiv.find(".required-item-name").val(itemName);
	})

	safeDiv.find(".add-item-btn").click(function() {
		addItemInSafe(safeDiv);
	})

	safeDiv.find(".choose-coords-and-heading-btn").click(async function() {
		let objectType = safeDiv.find(".object-type").val();

		let data = await placeObjectAndReturnCoords(objectType);

		if(data) {
			safeDiv.find(".coords-x").val(data.coords.x);
			safeDiv.find(".coords-y").val(data.coords.y);
			safeDiv.find(".coords-z").val(data.coords.z);
			safeDiv.find(".heading").val(data.heading);
		}
	}).tooltip();

	safeDiv.find(".customize-blip-btn").click(async function() {
		let oldBlipData = safeDiv.data("blipData");
		let blipData = await blipDialog(oldBlipData)

		safeDiv.data("blipData", blipData);
	})

	safeDiv.find(".delete-safe-btn").click(function() {
		safeDiv.remove();
	})

	// Sets value if the object is not new
	if(safe) {
		safeDiv.find(".object-type").val(safe.type);
		safeDiv.find(".coords-x").val(safe.coords.x);
		safeDiv.find(".coords-y").val(safe.coords.y);
		safeDiv.find(".coords-z").val(safe.coords.z);
		safeDiv.find(".heading").val(safe.heading);
		safeDiv.find(".difficulty").val(safe.difficulty);
		safeDiv.find(".min-objects-amount").val(safe.minObjectsAmount);
		safeDiv.find(".max-objects-amount").val(safe.maxObjectsAmount);
		safeDiv.find(".is-optional-checkbox").prop("checked", safe.isOptional);
		safeDiv.find(".is-invisible-checkbox").prop("checked", safe.isInvisible);
		safeDiv.data("blipData", safe.blipData);
		safeDiv.data("alarms", safe.alarms);

		safe.items.forEach(item => {
			addItemInSafe(safeDiv, item);
		})

		if(safe.requiredItem) {
			safeDiv.find(".required-item-name").val(safe.requiredItem.name);
			safeDiv.find(".required-item-quantity").val(safe.requiredItem.quantity);
			safeDiv.find(".required-item-lose-on-use-checkbox").prop("checked", safe.requiredItem.loseOnUse);
		}

	} else {

		// If safe didn't exist, it will also add 1 empty item to it
		addItemInSafe(safeDiv);
	}

	safeDiv.find(".requires-an-item-checkbox").prop("checked", safe?.requiredItem ? true : false).change();

	stageDiv.find(".steps-list").append(safeDiv);
}

function addHackablePanelHeist(stageDiv, hackablePanel) {
	let hackablePanelDiv = $(`
		<div class="hackable-panel mb-5">
			<p class="text-center text-success fs-4">${getLocalizedText("menu:hackable_panel")}</p>

			<div class="row g-2 row-cols-auto align-items-center justify-content-center">
				<button type="button" class="btn btn-danger delete-hackable-panel-btn me-3" ><i class="bi bi-trash-fill"></i></button>	

				<!-- Coords and heading -->
				<div class="form-floating text-body col-1 ms-4">
					<input type="number" step="0.01" class="form-control coords-x" placeholder="X" required>
					<label>${ getLocalizedText("menu:x") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-y" placeholder="Y" required>
					<label>${ getLocalizedText("menu:y") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-z" placeholder="Z" required>
					<label>${ getLocalizedText("menu:z") }</label>
				</div>
				
				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control heading" placeholder="Heading" required>
					<label>${ getLocalizedText("menu:heading") }</label>
				</div>		

				<button type="button" class="btn btn-secondary col-auto choose-coords-and-heading-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:place_object") }"><i class="bi bi-arrow-down-square"></i></button>	

				<button type="button" class="btn btn-secondary ms-3 customize-blip-btn">${getLocalizedText("menu:customize_blip")}</button>

				<div class="form-floating text-body col-1 ms-4">
					<input type="number" min="1" max="5" class="form-control difficulty" placeholder="Difficulty" required data-bs-toggle="tooltip" data-bs-placement="top" title="1-5">
					<label>${ getLocalizedText("menu:difficulty") }</label>
				</div>

				<div class="form-check fs-5 ms-3">
					<input class="form-check-input is-optional-checkbox" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:is_optional")}</label>
				</div>

				<div class="form-check fs-5 ms-3">
					<input class="form-check-input is-invisible-checkbox" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:is_invisible")}</label>
				</div>
			</div>

			<div class="row g-2 row-cols-auto align-items-center justify-content-center mt-3">
				<button type="button" class="btn btn-secondary choose-doors-btn">${getLocalizedText("menu:choose_doors")}</button>

				<div class="required-item-div row g-2 row-cols-auto align-items-center justify-content-center ms-3">
					<div class="form-check fs-5 ms-3">
						<input class="form-check-input is-optional-checkbox requires-an-item-checkbox" type="checkbox" value="">
						<label class="form-check-label">${getLocalizedText("menu:requires_an_item")}</label>
					</div>

					<div class="row g-2 row-cols-auto align-items-center">
						<div class="form-floating text-body col-3">
							<input type="text" class="form-control required-item-name" placeholder="Item name">
							<label>${ getLocalizedText("menu:item_name") }</label>
						</div>

						<button type="button" class="btn btn-secondary col-auto choose-item-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>	

						<div class="form-floating text-body col-2">
							<input type="text" class="form-control required-item-quantity" placeholder="Quantity">
							<label>${ getLocalizedText("menu:quantity") }</label>
						</div>

						<div class="form-check fs-5 ms-1">
							<input class="form-check-input is-optional-checkbox required-item-lose-on-use-checkbox" type="checkbox" value="">
							<label class="form-check-label">${getLocalizedText("menu:lose_on_use")}</label>
						</div>

						<button type="button" class="btn btn-secondary col-auto ms-5 setup-alarm-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:setup_alarms") }"><i class="bi bi-bell"></i></button>	

						<select class="form-select minigame-to-use ms-4" style="width: auto;">
							<option selected value="bruteforce">${getLocalizedText("menu:bruteforce")}</option>
							<option value="datacrack">${getLocalizedText("menu:datacrack")}</option>
							<option value="fingerprint">${getLocalizedText("menu:fingerprint")}</option>
							<option value="memory-game">${getLocalizedText("menu:memory_game")}</option>
						</select>
	
					</div>

				</div>

			</div>

			<hr>
		</div>
	`);

	hackablePanelDiv.find(".delete-hackable-panel-btn").click(function() {
		hackablePanelDiv.remove();
	})

	hackablePanelDiv.find(".difficulty").tooltip();

	hackablePanelDiv.find(".requires-an-item-checkbox").change(function() {
		toggleRequiredItem(hackablePanelDiv.find(".required-item-div"));
	});

	hackablePanelDiv.find(".choose-item-btn").click(async function() {
		let itemName = await itemsDialog();

		hackablePanelDiv.find(".required-item-name").val(itemName);
	})

	hackablePanelDiv.find(".choose-coords-and-heading-btn").click(async function() {
		let data = await placeObjectAndReturnCoords("hackable_panel");

		if(data) {
			hackablePanelDiv.find(".coords-x").val(data.coords.x);
			hackablePanelDiv.find(".coords-y").val(data.coords.y);
			hackablePanelDiv.find(".coords-z").val(data.coords.z);
			hackablePanelDiv.find(".heading").val(data.heading);
		}
	}).tooltip();

	hackablePanelDiv.find(".setup-alarm-btn").click(async function() {
		let currentAlarms = hackablePanelDiv.data("alarms");

		let alarms = await alarmsDialog(currentAlarms);
		
		hackablePanelDiv.data("alarms", alarms);
	}).tooltip();

	hackablePanelDiv.find(".customize-blip-btn").click(async function() {
		let oldBlipData = hackablePanelDiv.data("blipData");
		let blipData = await blipDialog(oldBlipData)

		hackablePanelDiv.data("blipData", blipData);
	})

	hackablePanelDiv.find(".choose-doors-btn").click(async function() {
		let doors = await doorsDialog( hackablePanelDiv.data("doorsToOpen") );

		hackablePanelDiv.data("doorsToOpen", doors);
	})
	
	hackablePanelDiv.find(".hackable-panel-btn").click(function() {
		hackablePanelDiv.remove();
	})

	// Sets value if the object is not new
	if(hackablePanel) {
		hackablePanelDiv.find(".coords-x").val(hackablePanel.coords.x);
		hackablePanelDiv.find(".coords-y").val(hackablePanel.coords.y);
		hackablePanelDiv.find(".coords-z").val(hackablePanel.coords.z);
		hackablePanelDiv.find(".heading").val(hackablePanel.heading);
		hackablePanelDiv.find(".difficulty").val(hackablePanel.difficulty);
		hackablePanelDiv.find(".is-optional-checkbox").prop("checked", hackablePanel.isOptional);
		hackablePanelDiv.find(".is-invisible-checkbox").prop("checked", hackablePanel.isInvisible);
		hackablePanelDiv.data("blipData", hackablePanel.blipData);
		hackablePanelDiv.data("doorsToOpen", hackablePanel.doorsToOpen);
		hackablePanelDiv.data("alarms", hackablePanel.alarms);
		hackablePanelDiv.find(".minigame-to-use").val(hackablePanel.minigameToUse || "bruteforce");

		if(hackablePanel.requiredItem) {
			hackablePanelDiv.find(".required-item-name").val(hackablePanel.requiredItem.name);
			hackablePanelDiv.find(".required-item-quantity").val(hackablePanel.requiredItem.quantity);
			hackablePanelDiv.find(".required-item-lose-on-use-checkbox").prop("checked", hackablePanel.requiredItem.loseOnUse);
		}
	}

	hackablePanelDiv.find(".requires-an-item-checkbox").prop("checked", hackablePanel?.requiredItem ? true : false).change();

	stageDiv.find(".steps-list").append(hackablePanelDiv);
}

function toggleRequiredItem(requiredItemDiv) {
	let enabled = requiredItemDiv.find(".requires-an-item-checkbox").prop("checked");

	requiredItemDiv.find(".required-item-name").prop("disabled", !enabled).prop("required", enabled);
	requiredItemDiv.find(".required-item-quantity").prop("disabled", !enabled).prop("required", enabled);
	requiredItemDiv.find(".choose-item-btn").prop("disabled", !enabled);
	requiredItemDiv.find(".required-item-lose-on-use-checkbox").prop("disabled", !enabled);

	if(!enabled) {
		requiredItemDiv.find(".required-item-lose-on-use-checkbox").prop("checked", false);
	}
}

function addThermalChargeHeist(stageDiv, thermalCharge) {
	let thermalChargeHeistDiv = $(`
		<div class="thermal-charge mb-5">
			<p class="text-center text-success fs-4">${getLocalizedText("menu:thermal_charge")}</p>

			<div class="row g-2 row-cols-auto align-items-center justify-content-center">
				<button type="button" class="btn btn-danger delete-thermal-charge-btn me-3" ><i class="bi bi-trash-fill"></i></button>	

				<!-- Coords and heading -->
				<div class="form-floating text-body col-1 ms-4">
					<input type="number" step="0.01" class="form-control coords-x" placeholder="X" required>
					<label>${ getLocalizedText("menu:x") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-y" placeholder="Y" required>
					<label>${ getLocalizedText("menu:y") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-z" placeholder="Z" required>
					<label>${ getLocalizedText("menu:z") }</label>
				</div>

				<button type="button" class="btn btn-secondary col-auto choose-coords-and-heading-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:place_object") }"><i class="bi bi-arrow-down-square"></i></button>	

				<button type="button" class="btn btn-secondary ms-3 customize-blip-btn">${getLocalizedText("menu:customize_blip")}</button>

				<div class="form-check fs-5 ms-3">
					<input class="form-check-input is-optional-checkbox" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:is_optional")}</label>
				</div>

				<div class="form-floating text-body ms-2">
					<input type="number" min="1" class="form-control duration" placeholder="Duration" required>
					<label>${ getLocalizedText("menu:duration") }</label>
				</div>

			</div>

			<div class="row g-2 row-cols-auto align-items-center justify-content-center mt-3">
				<button type="button" class="btn btn-secondary choose-doors-btn">${getLocalizedText("menu:choose_doors")}</button>

				<div class="required-item-div row g-2 row-cols-auto align-items-center justify-content-center ms-3">
					<div class="form-check fs-5 ms-3">
						<input class="form-check-input is-optional-checkbox requires-an-item-checkbox" type="checkbox" value="">
						<label class="form-check-label">${getLocalizedText("menu:requires_an_item")}</label>
					</div>

					<div class="row g-2 row-cols-auto align-items-center">
						<div class="form-floating text-body col-3">
							<input type="text" class="form-control required-item-name" placeholder="Item name">
							<label>${ getLocalizedText("menu:item_name") }</label>
						</div>

						<button type="button" class="btn btn-secondary col-auto choose-item-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>	

						<div class="form-floating text-body col-2">
							<input type="text" class="form-control required-item-quantity" placeholder="Quantity">
							<label>${ getLocalizedText("menu:quantity") }</label>
						</div>

						<div class="form-check fs-5 ms-1">
							<input class="form-check-input is-optional-checkbox required-item-lose-on-use-checkbox" type="checkbox" value="">
							<label class="form-check-label">${getLocalizedText("menu:lose_on_use")}</label>
						</div>

						<button type="button" class="btn btn-secondary col-auto ms-5 setup-alarm-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:setup_alarms") }"><i class="bi bi-bell"></i></button>	

					</div>
				</div>

			</div>

			<hr>
		</div>
	`);

	thermalChargeHeistDiv.find(".setup-alarm-btn").click(async function() {
		let currentAlarms = thermalChargeHeistDiv.data("alarms");

		let alarms = await alarmsDialog(currentAlarms);
		
		thermalChargeHeistDiv.data("alarms", alarms);
	}).tooltip();

	thermalChargeHeistDiv.find(".requires-an-item-checkbox").change(function() {
		toggleRequiredItem(thermalChargeHeistDiv.find(".required-item-div"));
	});

	thermalChargeHeistDiv.find(".choose-item-btn").click(async function() {
		let itemName = await itemsDialog();

		thermalChargeHeistDiv.find(".required-item-name").val(itemName);
	})

	thermalChargeHeistDiv.find(".choose-coords-and-heading-btn").click(async function() {
		let data = await placeObjectAndReturnCoords("thermal_charge");

		if(data) {
			thermalChargeHeistDiv.find(".coords-x").val(data.coords.x);
			thermalChargeHeistDiv.find(".coords-y").val(data.coords.y);
			thermalChargeHeistDiv.find(".coords-z").val(data.coords.z);
		}
	}).tooltip();

	thermalChargeHeistDiv.find(".customize-blip-btn").click(async function() {
		let oldBlipData = thermalChargeHeistDiv.data("blipData");
		let blipData = await blipDialog(oldBlipData);

		thermalChargeHeistDiv.data("blipData", blipData);
	});

	thermalChargeHeistDiv.find(".choose-doors-btn").click(async function() {
		let doors = await doorsDialog( thermalChargeHeistDiv.data("doorsToOpen") );

		thermalChargeHeistDiv.data("doorsToOpen", doors);
	});

	thermalChargeHeistDiv.find(".delete-thermal-charge-btn").click(function() {
		thermalChargeHeistDiv.remove();
	});

	if(thermalCharge) {
		thermalChargeHeistDiv.find(".coords-x").val(thermalCharge.coords.x);
		thermalChargeHeistDiv.find(".coords-y").val(thermalCharge.coords.y);
		thermalChargeHeistDiv.find(".coords-z").val(thermalCharge.coords.z);
		thermalChargeHeistDiv.find(".is-optional-checkbox").prop("checked", thermalCharge.isOptional);
		thermalChargeHeistDiv.find(".duration").val(thermalCharge.duration);
		thermalChargeHeistDiv.data("blipData", thermalCharge.blipData);
		thermalChargeHeistDiv.data("doorsToOpen", thermalCharge.doorsToOpen);
		thermalChargeHeistDiv.data("alarms", thermalCharge.alarms);
		
		if(thermalCharge.requiredItem) {
			thermalChargeHeistDiv.find(".required-item-name").val(thermalCharge.requiredItem.name);
			thermalChargeHeistDiv.find(".required-item-quantity").val(thermalCharge.requiredItem.quantity);
			thermalChargeHeistDiv.find(".required-item-lose-on-use-checkbox").prop("checked", thermalCharge.requiredItem.loseOnUse);
		}
	}

	thermalChargeHeistDiv.find(".requires-an-item-checkbox").prop("checked", thermalCharge?.requiredItem ? true : false).change();

	stageDiv.find(".steps-list").append(thermalChargeHeistDiv);
}

function addLockpickableDoorHeist(stageDiv, lockpickableDoor) {
	let lockpickableDoorHeistDiv = $(`
		<div class="lockpickable-door mb-5">
			<p class="text-center text-success fs-4">${getLocalizedText("menu:lockpickable_door")}</p>

			<div class="row g-2 row-cols-auto align-items-center justify-content-center">
				<button type="button" class="btn btn-danger delete-lockpickable-door-btn me-3" ><i class="bi bi-trash-fill"></i></button>	

				<!-- Coords and heading -->
				<div class="form-floating text-body col-1 ms-4">
					<input type="number" step="0.01" class="form-control coords-x" placeholder="X" required>
					<label>${ getLocalizedText("menu:x") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-y" placeholder="Y" required>
					<label>${ getLocalizedText("menu:y") }</label>
				</div>

				<div class="form-floating text-body col-1">
					<input type="number" step="0.01" class="form-control coords-z" placeholder="Z" required>
					<label>${ getLocalizedText("menu:z") }</label>
				</div>

				<button type="button" class="btn btn-secondary col-auto choose-coords-and-heading-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:place_object") }"><i class="bi bi-arrow-down-square"></i></button>	

				<button type="button" class="btn btn-secondary ms-3 customize-blip-btn">${getLocalizedText("menu:customize_blip")}</button>

				<div class="form-check fs-5 ms-3">
					<input class="form-check-input is-optional-checkbox" type="checkbox" value="">
					<label class="form-check-label">${getLocalizedText("menu:is_optional")}</label>
				</div>

				<div class="form-floating text-body col-1 ms-4">
					<input type="number" min=1 class="form-control difficulty" placeholder="Difficulty" required>
					<label>${ getLocalizedText("menu:difficulty") }</label>
				</div>


			</div>

			<div class="row g-2 row-cols-auto align-items-center justify-content-center mt-3">
				<button type="button" class="btn btn-secondary choose-doors-btn">${getLocalizedText("menu:choose_doors")}</button>

				<div class="required-item-div row g-2 row-cols-auto align-items-center justify-content-center ms-3">
					<div class="form-check fs-5 ms-3">
						<input class="form-check-input is-optional-checkbox requires-an-item-checkbox" type="checkbox" value="">
						<label class="form-check-label">${getLocalizedText("menu:requires_an_item")}</label>
					</div>

					<div class="row g-2 row-cols-auto align-items-center">
						<div class="form-floating text-body col-3">
							<input type="text" class="form-control required-item-name" placeholder="Item name">
							<label>${ getLocalizedText("menu:item_name") }</label>
						</div>

						<button type="button" class="btn btn-secondary col-auto choose-item-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>	

						<div class="form-floating text-body col-2">
							<input type="text" class="form-control required-item-quantity" placeholder="Quantity">
							<label>${ getLocalizedText("menu:quantity") }</label>
						</div>

						<div class="form-check fs-5 ms-1">
							<input class="form-check-input is-optional-checkbox required-item-lose-on-use-checkbox" type="checkbox" value="">
							<label class="form-check-label">${getLocalizedText("menu:lose_on_use")}</label>
						</div>

						<button type="button" class="btn btn-secondary col-auto ms-5 setup-alarm-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:setup_alarms") }"><i class="bi bi-bell"></i></button>	

					</div>
				</div>

			</div>

			<hr>
		</div>
	`);

	lockpickableDoorHeistDiv.find(".setup-alarm-btn").click(async function() {
		let currentAlarms = lockpickableDoorHeistDiv.data("alarms");

		let alarms = await alarmsDialog(currentAlarms);
		
		lockpickableDoorHeistDiv.data("alarms", alarms);
	}).tooltip();

	lockpickableDoorHeistDiv.find(".requires-an-item-checkbox").change(function() {
		toggleRequiredItem(lockpickableDoorHeistDiv.find(".required-item-div"));
	});

	lockpickableDoorHeistDiv.find(".choose-item-btn").click(async function() {
		let itemName = await itemsDialog();

		lockpickableDoorHeistDiv.find(".required-item-name").val(itemName);
	})

	lockpickableDoorHeistDiv.find(".choose-coords-and-heading-btn").click(async function() {
		let data = await placeObjectAndReturnCoords();

		if(data) {
			lockpickableDoorHeistDiv.find(".coords-x").val(data.coords.x);
			lockpickableDoorHeistDiv.find(".coords-y").val(data.coords.y);
			lockpickableDoorHeistDiv.find(".coords-z").val(data.coords.z);
		}
	}).tooltip();

	lockpickableDoorHeistDiv.find(".customize-blip-btn").click(async function() {
		let oldBlipData = lockpickableDoorHeistDiv.data("blipData");
		let blipData = await blipDialog(oldBlipData)

		lockpickableDoorHeistDiv.data("blipData", blipData);
	});

	lockpickableDoorHeistDiv.find(".choose-doors-btn").click(async function() {
		let doors = await doorsDialog( lockpickableDoorHeistDiv.data("doorsToOpen") );

		lockpickableDoorHeistDiv.data("doorsToOpen", doors);
	});

	lockpickableDoorHeistDiv.find(".delete-lockpickable-door-btn").click(function() {
		lockpickableDoorHeistDiv.remove();
	});

	if(lockpickableDoor) {
		lockpickableDoorHeistDiv.find(".coords-x").val(lockpickableDoor.coords.x);
		lockpickableDoorHeistDiv.find(".coords-y").val(lockpickableDoor.coords.y);
		lockpickableDoorHeistDiv.find(".coords-z").val(lockpickableDoor.coords.z);
		lockpickableDoorHeistDiv.find(".is-optional-checkbox").prop("checked", lockpickableDoor.isOptional);
		lockpickableDoorHeistDiv.find(".difficulty").val(lockpickableDoor.difficulty);
		lockpickableDoorHeistDiv.data("blipData", lockpickableDoor.blipData);
		lockpickableDoorHeistDiv.data("doorsToOpen", lockpickableDoor.doorsToOpen);
		lockpickableDoorHeistDiv.data("alarms", lockpickableDoor.alarms);
		
		if(lockpickableDoor.requiredItem) {
			lockpickableDoorHeistDiv.find(".required-item-name").val(lockpickableDoor.requiredItem.name);
			lockpickableDoorHeistDiv.find(".required-item-quantity").val(lockpickableDoor.requiredItem.quantity);
			lockpickableDoorHeistDiv.find(".required-item-lose-on-use-checkbox").prop("checked", lockpickableDoor.requiredItem.loseOnUse);
		}
	}

	lockpickableDoorHeistDiv.find(".requires-an-item-checkbox").prop("checked", lockpickableDoor?.requiredItem ? true : false).change();

	stageDiv.find(".steps-list").append(lockpickableDoorHeistDiv);
}

function addLethalGasHeist(stageDiv, lethalGas) {
	let lethalGasHeistDiv = $(`
		<div class="lethal-gas mb-5">
			<p class="text-center text-success fs-4">${getLocalizedText("menu:lethal_gas")}</p>

			<div class="row g-2 row-cols-auto align-items-center justify-content-center">
				<button type="button" class="btn btn-danger delete-lethal-gas-btn me-3" ><i class="bi bi-trash-fill"></i></button>	

				<button type="button" class="btn btn-secondary col-auto choose-gas-points" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:place_gas_points") }"><i class="bi bi-arrow-down-square"></i></button>	

				<div class="form-floating text-body col-3 ms-2">
					<input type="number" min=0 class="form-control seconds-before-start" placeholder="Seconds before start" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:second_to_wait_after_stage_start") }" required>
					<label>${ getLocalizedText("menu:second_to_wait") }</label>
				</div>

				<div class="form-floating text-body col-3 ms-2">
					<input type="number" min=1 class="form-control duration" placeholder="Duration" required>
					<label>${ getLocalizedText("menu:duration") }</label>
				</div>

				<div class="form-floating text-body col-3 ms-2">
					<input type="number" min=0 class="form-control damage" placeholder="Damage" required>
					<label>${ getLocalizedText("menu:damage") }</label>
				</div>

				<input type="color" class="form-control form-control-color ms-3 gas-color" value="#ff0000" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:gas_color")}">
			</div>

			<hr>
		</div>
	`);

	lethalGasHeistDiv.find(".seconds-before-start").tooltip()
	lethalGasHeistDiv.find(".gas-color").tooltip()

	lethalGasHeistDiv.find(".choose-gas-points").click(async function() {
		let gasPoints = await placeGasPoints();

		lethalGasHeistDiv.data("gasPoints", gasPoints);
	}).tooltip();

	lethalGasHeistDiv.find(".delete-lethal-gas-btn").click(function() {
		lethalGasHeistDiv.remove();
	});

	if(lethalGas) {
		lethalGasHeistDiv.find(".duration").val(lethalGas.duration);
		lethalGasHeistDiv.data("gasPoints", lethalGas.gasPoints);
		lethalGasHeistDiv.find(".damage").val(lethalGas.damage);
		lethalGasHeistDiv.find(".seconds-before-start").val(lethalGas.secondsBeforeStart);
		lethalGasHeistDiv.find(".gas-color").val( rgbToHex(lethalGas.color.r, lethalGas.color.g, lethalGas.color.b) );
	}

	stageDiv.find(".steps-list").append(lethalGasHeistDiv);
}

function renameAllStagesByTheirOrder() {
	$("#heist-stages").find(".stage-title").each(function(index) {
		let stageNumber = index + 1;

		$(this).prop("innerHTML", `${ getLocalizedText("menu:stage") }  ${stageNumber}`)
	})

	$("#heist-stages").find(".delete-stage-btn").each(function(index) {
		let stageNumber = index + 1;

		$(this).prop("innerHTML", `${ getLocalizedText("menu:delete_stage") } - ${stageNumber}`)
	})
}

function setDoorsCreatorStatusOnStageDiv(stageDiv) {
	if(hasDoorsCreator) return;

	let stepsRequiringDoorsCreator = {
		"hackable-panel": true,
		"thermal-charge": true,
		"lockpickable-door": true,
	}

	stageDiv.find("[data-step-type]").each(function() {
		let stepType = $(this).data("stepType");

		if(stepsRequiringDoorsCreator[stepType]) {
			$(this)
				.addClass("disabled")
				.parent()
					.data("bs-toggle", "tooltip")
					.data("bs-placement", "top")
					.prop("title", getLocalizedText("menu:requires_doors_creator"))
					.tooltip();
		}
	});
}

function addHeistStage(stage) {
	let stageDiv = $(`
		<div class="stage">

			<p class="text-center fs-4 stage-title">${ getLocalizedText("menu:stage") }  ${$("#heist-stages").children(".stage").length + 1}</p>

			<div class="my-3">

				<p class="fs-5 text-center fw-bold">${ getLocalizedText("menu:steps") }</p>

				<div class="steps-list">

				</div>
			</div>

			<div class="d-inline-block col-12 my-2">
				<div class="btn-group">
					<button type="button" class="btn btn-success dropdown-toggle" data-bs-toggle="dropdown">${ getLocalizedText("menu:add_step") }</button>

					<ul class="dropdown-menu steps-types-list">
						<li><a class="dropdown-item" href="#" data-step-type="robbable-object">${getLocalizedText("menu:add_robbable_object")}</a></li>
						<li><a class="dropdown-item" href="#" data-step-type="safe">${getLocalizedText("menu:add_safe")}</a></li>
						<li><a class="dropdown-item" href="#" data-step-type="painting">${getLocalizedText("menu:add_painting")}</a></li>
						<li><a class="dropdown-item" href="#" data-step-type="guards">${getLocalizedText("menu:add_guards")}</a></li>
						<li><a class="dropdown-item" href="#" data-step-type="hackable-panel">${getLocalizedText("menu:add_hackable_panel")}</a></li>
						<li><a class="dropdown-item" href="#" data-step-type="thermal-charge">${getLocalizedText("menu:add_thermal_charge")}</a></li>
						<li><a class="dropdown-item" href="#" data-step-type="lockpickable-door">${getLocalizedText("menu:add_lockpickable_door")}</a></li>
						<li><a class="dropdown-item" href="#" data-step-type="lethal-gas">${getLocalizedText("menu:add_lethal_gas")}</a></li>
					</ul>
				</div>

				<button type="button" class="btn btn-warning ms-3 delete-stage-btn float-end fs">${ getLocalizedText("menu:delete_stage") } - ${$("#heist-stages").children(".stage").length + 1}</button>
			</div>

			<hr class="thick-hr">
		</div>
	`)

	stageDiv.find(".delete-stage-btn").click(function() {
		stageDiv.remove();
		renameAllStagesByTheirOrder();
	})

	stageDiv.find(".steps-types-list a").click(function() {
		let stepType = $(this).data("stepType");

		switch(stepType) {
			case "robbable-object":
				addRobbableObjectHeist(stageDiv);
				break;
			case "safe":
				addSafeHeist(stageDiv);
				break;
			case "painting":
				addPaintingHeist(stageDiv);
				break;
			case "guards":
				addGuardsHeist(stageDiv);
				break;
			case "hackable-panel":
				addHackablePanelHeist(stageDiv);	
				break;
			case "thermal-charge":
				addThermalChargeHeist(stageDiv);
				break;
			case "lockpickable-door":
				addLockpickableDoorHeist(stageDiv);
				break;
			case "lethal-gas":
				addLethalGasHeist(stageDiv);
				break;
			default:
				console.log("Unknown step type")
				break;
		}
	})
	
	if(stage) {
		stage.steps.forEach(step => {
			switch(step.method) {
				case "ROBBABLE_OBJECT": 
					addRobbableObjectHeist(stageDiv, step);
					break;
				case "SAFE":
					addSafeHeist(stageDiv, step);
					break;
				case "PAINTING":
					addPaintingHeist(stageDiv, step);
					break;
				case "GUARDS":
					addGuardsHeist(stageDiv, step);
					break;
				case"HACKABLE_PANEL":
					addHackablePanelHeist(stageDiv, step);
					break;
				case"THERMAL_CHARGE":
					addThermalChargeHeist(stageDiv, step);
					break;
				case"LOCKPICKABLE_DOOR":
					addLockpickableDoorHeist(stageDiv, step);
					break;
				case"LETHAL_GAS":
					addLethalGasHeist(stageDiv, step);
					break;
				default: 
					console.log("Unknown step type: " + step.method);
					break;
			}
		});
	}

	setDoorsCreatorStatusOnStageDiv(stageDiv);

	$("#heist-stages").append(stageDiv);
}

$("#heist-add-stage-btn").click(function() {
	addHeistStage()
})

$("#heist-import-stages-from-heist-btn").click(async function() {
	let heistId = await heistsDialog()

	if(heistId) {
		heists[heistId].stages.forEach(stage => {
			addHeistStage(stage);
		})
	}
})

/*
 ██████╗ █████╗ ██████╗  ██████╗  ██████╗     ██████╗  ██████╗ ██████╗ ██████╗ ███████╗██████╗ ██╗███████╗███████╗
██╔════╝██╔══██╗██╔══██╗██╔════╝ ██╔═══██╗    ██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗██║██╔════╝██╔════╝
██║     ███████║██████╔╝██║  ███╗██║   ██║    ██████╔╝██║   ██║██████╔╝██████╔╝█████╗  ██████╔╝██║█████╗  ███████╗
██║     ██╔══██║██╔══██╗██║   ██║██║   ██║    ██╔══██╗██║   ██║██╔══██╗██╔══██╗██╔══╝  ██╔══██╗██║██╔══╝  ╚════██║
╚██████╗██║  ██║██║  ██║╚██████╔╝╚██████╔╝    ██║  ██║╚██████╔╝██████╔╝██████╔╝███████╗██║  ██║██║███████╗███████║
 ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝  ╚═════╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═╝╚══════╝╚══════╝
*/

let cargoRobberiesDatatable = $("#cargo-robberies-container").DataTable( {
	"lengthMenu": [10, 15, 20],
	"createdRow": function ( row, data, index ) {
		$(row).addClass("clickable");

		$(row).click(function() {
			let id = parseInt( data[0] );

			editCargoRobbery(id);
		})
	},
});

let cargoRobberies = {};

function loadCargoRobberies() {
	$.post(`https://${resName}/getAllCargoRobberies`, {}, async function(rawCargoRobberies) {

		// Manually create the table to avoid incompatibilities due table indexing
		cargoRobberies = {};

		for(const[k, heistData] of Object.entries(rawCargoRobberies)) {
			cargoRobberies[heistData.id] = heistData;
		}

		cargoRobberiesDatatable.clear();

		for(const[id, heistData] of Object.entries(cargoRobberies)) {
			cargoRobberiesDatatable.row.add([
				id,
				heistData.label,
			]);
		}

		cargoRobberiesDatatable.draw();
	})
}

function getDefaultBlipCargoRobbery() {
	return {
		isEnabled: true,
		sprite: 67,
		label: getLocalizedText("menu:armored_truck"),
		scale: 0.8,
		color: 1,
		display: 2,
	}
}

function setDefaultDataOfCargoRobberyModal() {
	$("#cargo-robbery-label").val("Default");
	$("#cargo-robbery-vehicle-model").val("stockade");
	$("#cargo-robbery-driver-model").val("mp_m_securoguard_01");
	$("#cargo-robbery-max-speed").val(50.0);
	$("#cargo-robbery-seconds-to-drill").val(20);

	$(`input[name=cargo-drive-type][value='stops']`).prop("checked", true).change();
	$("#cargo-robbery-random-drive-coords-x").val("");
	$("#cargo-robbery-random-drive-coords-y").val("");
	$("#cargo-robbery-random-drive-coords-z").val("");
	$("#cargo-robbery-random-drive-heading").val("");
	$("#cargo-robbery-random-drive-minutes-before-despawn").val(30);

	$("#cargo-robbery-min-objects-quantity").val(1);
	$("#cargo-robbery-max-objects-quantity").val(2);
	$("#cargo-items-list").empty();

	$("#cargo-robbery-stops").empty();
	$("#cargo-robbery-modal").data("blipData", getDefaultBlipCargoRobbery());
}

function renameAllStopsByTheirOrder() {
	$("#cargo-robbery-stops").find(".stop-title").each(function(index) {
		let stopNumber = index + 1;

		$(this).prop("innerHTML", `${ getLocalizedText("menu:stop") }  ${stopNumber}`)
	})

	$("#cargo-robbery-stops").find(".delete-stop-btn").each(function(index) {
		let stopNumber = index + 1;

		$(this).prop("innerHTML", `${ getLocalizedText("menu:delete_stop") } - ${stopNumber}`)
	})
}


$("#new-cargo-robbery-btn").click(function() {
	let cargoRobberyModal = $("#cargo-robbery-modal");

	// Converts from edit modal to create modal
	cargoRobberyModal.data("action", "create");
	
	$("#delete-cargo-robbery-btn").hide();
	$("#save-cargo-robbery-btn").text( getLocalizedText("menu:create") );
	
	setDefaultDataOfCargoRobberyModal();

	cargoRobberyModal.modal("show");
})


function editCargoRobbery(id) {
	let cargoRobberyData = cargoRobberies[id];

	let cargoRobberyModal = $("#cargo-robbery-modal");

	cargoRobberyModal.data("action", "edit");
	cargoRobberyModal.data("cargoRobberyId", id);
	cargoRobberyModal.data("blipData", cargoRobberyData.blipData);
	
	$("#delete-cargo-robbery-btn").show();
	$("#save-cargo-robbery-btn").text( getLocalizedText("menu:save") );

	$("#cargo-robbery-label").val(cargoRobberyData.label);
	$("#cargo-robbery-vehicle-model").val(cargoRobberyData.data.vehicleModel);
	$("#cargo-robbery-driver-model").val(cargoRobberyData.data.driverModel);
	$("#cargo-robbery-bulletproof-wheels-checkbox").prop("checked", cargoRobberyData.data.hasBulletproofTires);
	$("#cargo-robbery-max-speed").val(cargoRobberyData.data.maxSpeed);
	$("#cargo-robbery-seconds-to-drill").val(cargoRobberyData.data.secondsToDrill)

	$(`input[name=cargo-drive-type][value='${cargoRobberyData.data.driveType}']`).prop("checked", true).change();
	$("#cargo-robbery-random-drive-coords-x").val(cargoRobberyData.data.startCoords?.x);
	$("#cargo-robbery-random-drive-coords-y").val(cargoRobberyData.data.startCoords?.y);
	$("#cargo-robbery-random-drive-coords-z").val(cargoRobberyData.data.startCoords?.z);
	$("#cargo-robbery-random-drive-heading").val(cargoRobberyData.data.startCoords?.heading);
	$("#cargo-robbery-random-drive-minutes-before-despawn").val(cargoRobberyData.data.minutesBeforeDespawn);

	$("#cargo-robbery-min-objects-quantity").val(cargoRobberyData.data.minObjectsAmount);
	$("#cargo-robbery-max-objects-quantity").val(cargoRobberyData.data.maxObjectsAmount);
	$("#cargo-items-list").empty();

	if(cargoRobberyData.data.rewardObjects) {
		cargoRobberyData.data.rewardObjects.forEach(rewardObject => {
			addObjectInCargoRobbery(rewardObject);
		})	
	}

	$("#cargo-robbery-stops").empty();
	if(cargoRobberyData.data.stops) {
		cargoRobberyData.data.stops.forEach(stop => {
			addCargoRobberyStop(stop);
		})
	}

	cargoRobberyModal.modal("show");
}

function addCargoRobberyStop(stopData) {
	let stopIndex = $("#cargo-robbery-stops").children(".stop").length + 1;
	
	let stopDiv = $(`
		<div class="my-2 stop">
			<p class="text-center fs-4 fw-bold stop-title mb-3">${ getLocalizedText("menu:stop") } ${stopIndex}</p>
			
			<p class="fs-5 text-center fst-italic">${ getLocalizedText("menu:destination") }</p>
			
			<div class="row g-2 row-cols-auto align-items-center justify-content-center">
				<div class="form-floating text-body col-2">
					<input type="number" step="0.01" class="form-control coords-x" placeholder="X" required>
					<label>${ getLocalizedText("menu:x") }</label>
				</div>

				<div class="form-floating text-body col-2">
					<input type="number" step="0.01" class="form-control coords-y" placeholder="Y" required>
					<label>${ getLocalizedText("menu:y") }</label>
				</div>

				<div class="form-floating text-body col-2">
					<input type="number" step="0.01" class="form-control coords-z" placeholder="Z" required>
					<label>${ getLocalizedText("menu:z") }</label>
				</div>

				<div class="form-floating text-body col-2">
					<input type="number" step="0.01" class="form-control heading" placeholder="Heading" required>
					<label>${ getLocalizedText("menu:heading") }</label>
				</div>

				<button type="button" class="btn btn-secondary col-auto current-coords-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:current_coords") }"><i class="bi bi-arrow-down-square"></i></button>	
			
				<div class="form-floating text-body col-3">
					<input type="number" min=0 class="form-control minutes-to-wait" placeholder="Minutes to wait" value="0" required>
					<label>${ getLocalizedText("menu:minutes_to_wait_when_arrived") }</label>
				</div>
			</div>

			<div class="d-inline-block col-12 my-2">
				<button type="button" class="btn btn-warning ms-3 delete-stop-btn float-end fs">${ getLocalizedText("menu:delete_stop") } - ${stopIndex}</button>
			</div>

			<hr class="thick-hr">
		</div>
	`)
	
	stopDiv.find(".current-coords-btn").click(async function() {
		let data = await getCurrentCoordsAndHeading();

		stopDiv.find(".coords-x").val(data.coords.x);
		stopDiv.find(".coords-y").val(data.coords.y);
		stopDiv.find(".coords-z").val(data.coords.z);

		stopDiv.find(".heading").val(data.heading);
	}).tooltip();

	stopDiv.find(".delete-stop-btn").click(function() {
		stopDiv.remove();
		renameAllStopsByTheirOrder();
	});

	if(stopData) {
		stopDiv.find(".coords-x").val(stopData.coords.x);
		stopDiv.find(".coords-y").val(stopData.coords.y);
		stopDiv.find(".coords-z").val(stopData.coords.z);
		stopDiv.find(".heading").val(stopData.heading);
		stopDiv.find(".minutes-to-wait").val(stopData.minutesToWait);
	}

	$("#cargo-robbery-stops").append(stopDiv);
}

$("#cargo-robbery-add-stop-btn").click(function() {
	addCargoRobberyStop()
})

$('input[name=cargo-drive-type]').change(function() {
	let type = $(this).val();

	switch(type) {
		case "stops": {
			$("#cargo-robbery-stops-container").show().find(".form-control").prop("required", true);
			$("#cargo-robbery-random-drive-container").hide().find(".form-control").prop("required", false);

			break;
		}

		case "random": {
			$("#cargo-robbery-stops-container").hide().find(".form-control").prop("required", false);
			$("#cargo-robbery-random-drive-container").show().find(".form-control").prop("required", true);
		
			break;
		}
	}
});

$("#cargo-robbery-random-drive-current-coords-btn").click(async function() {
	let data = await getCurrentCoordsAndHeading();

	$("#cargo-robbery-random-drive-coords-x").val(data.coords.x);
	$("#cargo-robbery-random-drive-coords-y").val(data.coords.y);
	$("#cargo-robbery-random-drive-coords-z").val(data.coords.z);

	$("#cargo-robbery-random-drive-heading").val(data.heading);
})

function getCargoRobberyStops() {
	let stops = [];

	$("#cargo-robbery-stops").find(".stop").each(function() {
		let stop = {
			coords: {
				x: parseFloat( $(this).find(".coords-x").val() ),
				y: parseFloat( $(this).find(".coords-y").val() ),
				z: parseFloat( $(this).find(".coords-z").val() ),
			},

			heading: parseFloat( $(this).find(".heading").val() ),

			minutesToWait: parseInt( $(this).find(".minutes-to-wait").val() ),
		};

		stops.push(stop);
	});

	return stops;
}

function getCargoRobberyRewards() {
	let rewards = [];

	$("#cargo-items-list").find(".cargo-robbery-item").each(function() {
		let currentObject = $(this);

		let reward = {
			type: currentObject.find(".object-type").val(),
			name: currentObject.find(".object-name").val(),
			minQuantity: parseInt(currentObject.find(".min-quantity").val()),
			maxQuantity: parseInt(currentObject.find(".max-quantity").val()),
			chances: parseInt(currentObject.find(".chances").val())
		}

		rewards.push(reward);
	})
	
	return rewards;
}

$("#cargo-robbery-form").submit(function(event) {
	if (!this.checkValidity()) {
		event.preventDefault();
		event.stopPropagation();

		return;
	} else {
		$(this).removeClass("was-validated");
	}

	let cargoRobberyModal = $("#cargo-robbery-modal");
	let action = cargoRobberyModal.data("action");

	let cargoRobberyData = {
		label: $("#cargo-robbery-label").val(),
		blipData: cargoRobberyModal.data("blipData"),
		data: {
			vehicleModel: $("#cargo-robbery-vehicle-model").val(),
			driverModel: $("#cargo-robbery-driver-model").val(),
			hasBulletproofTires: $("#cargo-robbery-bulletproof-wheels-checkbox").prop("checked"),	
			maxSpeed: parseFloat( $("#cargo-robbery-max-speed").val() ),
			secondsToDrill: parseInt( $("#cargo-robbery-seconds-to-drill").val() ),
			minObjectsAmount: parseInt( $("#cargo-robbery-min-objects-quantity").val() ),
			maxObjectsAmount: parseInt( $("#cargo-robbery-max-objects-quantity").val() ),
			rewardObjects: getCargoRobberyRewards(),

			stops: getCargoRobberyStops(),
			driveType: $('input[name=cargo-drive-type]:checked').val(),
			startCoords: {
				x: parseFloat( $("#cargo-robbery-random-drive-coords-x").val() ),
				y: parseFloat( $("#cargo-robbery-random-drive-coords-y").val() ),
				z: parseFloat( $("#cargo-robbery-random-drive-coords-z").val() ),
				heading: parseFloat(  $("#cargo-robbery-random-drive-heading").val() ),
			},
			minutesBeforeDespawn: parseInt( $("#cargo-robbery-random-drive-minutes-before-despawn").val() )
		}
	}
	
	switch(action) {
		case "create": {
			$.post(`https://${resName}/createCargoRobbery`, JSON.stringify(cargoRobberyData), function(isSuccessful) {
				if(isSuccessful) {
					cargoRobberyModal.modal("hide");
					loadCargoRobberies();
				}
			});

			break;
		}

		case "edit": {
			$.post(`https://${resName}/updateCargoRobbery`, JSON.stringify({cargoRobberyId: cargoRobberyModal.data("cargoRobberyId"), cargoRobberyData: cargoRobberyData}), function(isSuccessful) {
				if(isSuccessful) {
					cargoRobberyModal.modal("hide");
					loadCargoRobberies();
				}
			});

			break;
		}
	}
});

$("#delete-cargo-robbery-btn").click(function() {
	let cargoRobberyModal = $("#cargo-robbery-modal");
	let cargoRobberyId = cargoRobberyModal.data("cargoRobberyId");

	$.post(`https://${resName}/deleteCargoRobbery`, JSON.stringify({cargoRobberyId: cargoRobberyId}), function(isSuccessful) {
		if(isSuccessful) {
			cargoRobberyModal.modal("hide");
			loadCargoRobberies();
		}
	});
})

$("#cargo-robbery-customize-blip-btn").click(async function() {
	oldBlipData = $("#cargo-robbery-modal").data("blipData");
	let blipData = await blipDialog(oldBlipData)

	$("#cargo-robbery-modal").data("blipData", blipData);
});

async function addObjectInCargoRobbery(objectData) {
	let objectDiv = $(`
		<div class="row g-2 row-cols-auto align-items-center text-body my-2 cargo-robbery-item justify-content-center">
			<button type="button" class="btn-close delete-cargo-robbery-item-btn me-3" ></button>	

			<select class="form-select object-type" style="width: auto;">
				<option selected value="item">${getLocalizedText("menu:item")}</option>
				<option value="account">${getLocalizedText("menu:account")}</option>
				${await getFramework() == "ESX" ? `<option value="weapon">${getLocalizedText("menu:weapon")}</option>` : ""}
			</select>
			
			<div class="form-floating">
				<input type="text" class="form-control object-name" placeholder="Name" required>
				<label>${ getLocalizedText("menu:object_name") }</label>
			</div>

			<button type="button" class="btn btn-secondary col-auto choose-item-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>	

			<div class="form-floating">
				<input type="number" min=0 class="form-control min-quantity" placeholder="${getLocalizedText("menu:min_quantity")}" required>
				<label>${getLocalizedText("menu:min_quantity")}</label>
			</div>

			<div class="form-floating">
				<input type="number"  class="form-control max-quantity" placeholder="${getLocalizedText("menu:max_quantity")}" required>
				<label>${getLocalizedText("menu:max_quantity")}</label>
			</div>

			<div class="form-floating">
				<input type="number"  class="form-control chances" placeholder="${getLocalizedText("menu:probability")}" required>
				<label>${getLocalizedText("menu:probability")}</label>
			</div>
		</div>
	`);

	objectDiv.find(".delete-cargo-robbery-item-btn").click(function() {
		objectDiv.remove();
	})

	objectDiv.find(".choose-item-btn").click(async function() {
		let objectType = objectDiv.find(".object-type").val();

		let objectName = await objectDialog(objectType);

		objectDiv.find(".object-name").val(objectName);
	}).tooltip();

	if(objectData) {
		objectDiv.find(".object-type").val(objectData.type);
		objectDiv.find(".object-name").val(objectData.name);
		objectDiv.find(".min-quantity").val(objectData.minQuantity);
		objectDiv.find(".max-quantity").val(objectData.maxQuantity);
		objectDiv.find(".chances").val(objectData.chances);
	}

	$("#cargo-items-list").append(objectDiv);
}

$("#cargo-robbery-add-item-btn").click(function() {
	addObjectInCargoRobbery();
});

/*
██████╗ ██╗      █████╗ ███╗   ██╗███╗   ██╗██╗███╗   ██╗ ██████╗ 
██╔══██╗██║     ██╔══██╗████╗  ██║████╗  ██║██║████╗  ██║██╔════╝ 
██████╔╝██║     ███████║██╔██╗ ██║██╔██╗ ██║██║██╔██╗ ██║██║  ███╗
██╔═══╝ ██║     ██╔══██║██║╚██╗██║██║╚██╗██║██║██║╚██╗██║██║   ██║
██║     ███████╗██║  ██║██║ ╚████║██║ ╚████║██║██║ ╚████║╚██████╔╝
╚═╝     ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═══╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 
*/
let planningsDatatable = $("#plannings-container").DataTable( {
	"lengthMenu": [10, 15, 20],
	"createdRow": function ( row, data, index ) {
		$(row).addClass("clickable");

		$(row).click(function() {
			let id = parseInt( data[0] );

			editPlanning(id);
		})
	},
});

let plannings = {};

function getRemainingTimeForPlannings() {
	return new Promise((resolve, reject) => {
		$.post(`https://${resName}/getRemainingTimeForPlannings`, function(remainingTimes) {
			resolve(remainingTimes)
		});
	})
}

async function loadPlannings() {
	let remainingTimes = await getRemainingTimeForPlannings();

	$.post(`https://${resName}/getAllPlannings`, {}, async function(rawPlannings) {

		// Manually create the table to avoid incompatibilities due table indexing
		plannings = {};

		for(const[k, planningData] of Object.entries(rawPlannings)) {
			plannings[planningData.id] = planningData;
		}

		planningsDatatable.clear();

		for(const[id, planningData] of Object.entries(plannings)) {
			planningsDatatable.row.add([
				id,
				planningData.label,
				cargoRobberies[planningData.cargoRobberyId]?.label || "None",
				remainingTimes[id] || "?",
			]);
		}

		planningsDatatable.draw();
	})
}

function planningSetTargetRobbery(robberyId = null) {
	let planningModal = $("#planning-modal");

	planningModal.data("cargoRobberyId", robberyId);

	if(robberyId) {
		let robberyLabel = cargoRobberies[robberyId].label;

		$("#planning-target-robbery").val( robberyLabel );
	} else {
		$("#planning-target-robbery").val( getLocalizedText("menu:none") );
	}
}

function setDefaultDataOfPlanningModal() {
	$("#planning-label").val("Default");
	$("#planning-min-police").val(0);

	planningSetTargetRobbery(null);

	$("#planning-date-type").val("now").change();
}

$("#new-planning-btn").click(function() {
	let planningModal = $("#planning-modal");

	// Converts from edit modal to create modal
	planningModal.data("action", "create");
	
	$("#delete-planning-btn").hide();
	$("#save-planning-btn").text( getLocalizedText("menu:create") );
	
	setDefaultDataOfPlanningModal();

	planningModal.modal("show");
})


$("#planning-choose-robbery-btn").click(async function() {
	let robberyId = await cargoRobberiesDialog();

	planningSetTargetRobbery(robberyId);
});

function togglePlanningDateType() {
	let val = $("#planning-date-type").val();

	if(val == "date") {
		$("#planning-date").show().prop("required", true);
	} else {
		$("#planning-date").hide().prop("required", false);
	}

	if(val == "interval") {
		$("#planning-interval-div").show();
		$("#planning-interval").prop("required", true);
	} else {
		$("#planning-interval-div").hide();
		$("#planning-interval").prop("required", false);
	}
}

$("#planning-date-type").change(togglePlanningDateType);

function getUnixFromDate(date) {
	return Math.floor(new Date(date).getTime() / 1000 )
}

function getDateFromUnix(unix) {
	const padL = (nr, len = 2, chr = `0`) => `${nr}`.padStart(2, chr);

	let date = new Date(unix * 1000)

	let formatted = `${
		date.getFullYear()}-${
		padL(date.getMonth()+1)}-${
		padL(date.getDate())}T${
		padL(date.getHours())}:${
		padL(date.getMinutes())}`

	return formatted;
}

$("#planning-form").submit(function(event) {
	if (!this.checkValidity()) {
		event.preventDefault();
		event.stopPropagation();

		return;
	} else {
		$(this).removeClass("was-validated");
	}

	let planningModal = $("#planning-modal");
	let action = planningModal.data("action");

	let planningData = {
		label: $("#planning-label").val(),
		minimumPolice: parseInt($("#planning-min-police").val()),
		cargoRobberyId: parseInt(planningModal.data("cargoRobberyId")),
		data: {
			dateType: $("#planning-date-type").val(),
			date: getUnixFromDate( $("#planning-date").val() ),
			interval: parseInt( $("#planning-interval").val() ),
		}
	}
	
	switch(action) {
		case "create": {
			$.post(`https://${resName}/createPlanning`, JSON.stringify(planningData), function(isSuccessful) {
				if(isSuccessful) {
					planningModal.modal("hide");
					loadPlannings();
				}
			});

			break;
		}

		case "edit": {
			$.post(`https://${resName}/updatePlanning`, JSON.stringify({planningId: planningModal.data("planningId"), planningData: planningData}), function(isSuccessful) {
				if(isSuccessful) {
					planningModal.modal("hide");
					loadPlannings();
				}
			});

			break;
		}
	}
})

function editPlanning(id) {
	let planningData = plannings[id];

	let planningsModal = $("#planning-modal");

	planningsModal.data("action", "edit");
	planningsModal.data("planningId", id);
	
	$("#delete-planning-btn").show();
	$("#save-planning-btn").text( getLocalizedText("menu:save") );

	$("#planning-label").val(planningData.label);
	$("#planning-min-police").val(planningData.minimumPolice);

	planningSetTargetRobbery(planningData.cargoRobberyId);

	$("#planning-date-type").val(planningData.data.dateType).change();
	$("#planning-date").val( getDateFromUnix(planningData.data.date) );
	$("#planning-interval").val(planningData.data.interval);

	planningsModal.modal("show");
}

$("#delete-planning-btn").click(function() {
	let planningModal = $("#planning-modal");
	let planningId = planningModal.data("planningId");

	$.post(`https://${resName}/deletePlanning`, JSON.stringify({planningId: planningId}), function(isSuccessful) {
		if(isSuccessful) {
			planningModal.modal("hide");
			loadPlannings();
		}
	});
})

/*
███╗   ██╗██████╗  ██████╗    ███╗   ███╗██╗   ██╗ ██████╗  ██████╗ ██╗███╗   ██╗ ██████╗ 
████╗  ██║██╔══██╗██╔════╝    ████╗ ████║██║   ██║██╔════╝ ██╔════╝ ██║████╗  ██║██╔════╝ 
██╔██╗ ██║██████╔╝██║         ██╔████╔██║██║   ██║██║  ███╗██║  ███╗██║██╔██╗ ██║██║  ███╗
██║╚██╗██║██╔═══╝ ██║         ██║╚██╔╝██║██║   ██║██║   ██║██║   ██║██║██║╚██╗██║██║   ██║
██║ ╚████║██║     ╚██████╗    ██║ ╚═╝ ██║╚██████╔╝╚██████╔╝╚██████╔╝██║██║ ╚████║╚██████╔╝
╚═╝  ╚═══╝╚═╝      ╚═════╝    ╚═╝     ╚═╝ ╚═════╝  ╚═════╝  ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ 
*/
function toggleNpcMugging() {
	let enableNpcMuggingDiv = $("#enable-npc-mugging")
	let enable = enableNpcMuggingDiv.prop("checked");

	$("#npc-mugging-options").find("input, button").not(enableNpcMuggingDiv).prop("disabled", !enable);
}
$("#enable-npc-mugging").change(toggleNpcMugging);

async function addRobbableObjectNpcMugging(object) {
	let robbableObjectDiv = $(`
		<div class="row g-2 row-cols-auto align-items-center text-body my-2 robbable-object">

			<select class="form-select object-type" style="width: auto;">
				<option selected value="item">${getLocalizedText("menu:item")}</option>
				<option value="account">${getLocalizedText("menu:account")}</option>
				${await getFramework() == "ESX" ? `<option value="weapon">${getLocalizedText("menu:weapon")}</option>` : ""}
			</select>
			
			<div class="form-floating">
				<input type="text" class="form-control object-name" placeholder="Name" required>
				<label>${getLocalizedText("menu:object_name")}</label>
			</div>

			<button type="button" class="btn btn-secondary col-auto choose-btn" data-bs-toggle="tooltip" data-bs-placement="top" title="${ getLocalizedText("menu:choose") }"><i class="bi bi-list-ul"></i></button>	

			<div class="form-floating">
				<input type="number" min=0 class="form-control min-quantity" placeholder="${getLocalizedText("menu:min_quantity")}" required>
				<label>${getLocalizedText("menu:min_quantity")}</label>
			</div>

			<div class="form-floating">
				<input type="number"  class="form-control max-quantity" placeholder="${getLocalizedText("menu:max_quantity")}" required>
				<label>${getLocalizedText("menu:max_quantity")}</label>
			</div>

			<div class="form-floating">
				<input type="number"  class="form-control chances" placeholder="${getLocalizedText("menu:probability")}" required>
				<label>${getLocalizedText("menu:probability")}</label>
			</div>

			<button type="button" class="btn-close btn-close-white remove-btn ms-2"></button>
		</div>
	`)

	robbableObjectDiv.find(".choose-btn").click(async function() {
		let objectType = robbableObjectDiv.find(".object-type").val();

		let objectName = await objectDialog(objectType);

		robbableObjectDiv.find(".object-name").val(objectName);
	}).tooltip();


	robbableObjectDiv.find(".remove-btn").click(function() {
		robbableObjectDiv.remove();
	})

	// Sets the object property if exist

	if(object) {
		robbableObjectDiv.find(".object-type").val(object.type);
		robbableObjectDiv.find(".object-name").val(object.name);
		robbableObjectDiv.find(".min-quantity").val(object.minQuantity);
		robbableObjectDiv.find(".max-quantity").val(object.maxQuantity);
		robbableObjectDiv.find(".chances").val(object.chances);
	}

	$("#npc-mugging-robbable-items").append(robbableObjectDiv);
}
$("#npc-mugging-add-object").click(function() {
	addRobbableObjectNpcMugging();
});

function getNpcMuggingRobbableObjects() {
	let robbableObjects = [];

	$("#npc-mugging-robbable-items").find(".robbable-object").each(function() {
		let currentObject = $(this);

		let object = {
			type: currentObject.find(".object-type").val(),
			name: currentObject.find(".object-name").val(),
			minQuantity: parseInt(currentObject.find(".min-quantity").val()),
			maxQuantity: parseInt(currentObject.find(".max-quantity").val()),
			chances: parseInt(currentObject.find(".chances").val())
		}

		robbableObjects.push(object);
	})

	return robbableObjects;
}

function setNpcMuggingRobbableObjects(objects) {
	$("#npc-mugging-robbable-items").empty();

	objects.forEach(object => {
		addRobbableObjectNpcMugging(object);
	});
}

$("#npc-mugging").submit(function(event) {
	if (!this.checkValidity()) {
		event.preventDefault();
		event.stopPropagation();

		return;
	} else {
		$(this).removeClass("was-validated");
	}

	let clientSettings = {
		clNpcMugging: {
			canMakeFollow: $("#can-make-npc-to-follow").prop("checked"),
			cooldownOnMugging: parseInt( $("#npc-mugging-cooldown-on-mugging").val() )
		}
	}

	let sharedSettings = {
		isNpcMuggingEnabled: $("#enable-npc-mugging").prop("checked"),
		secondsToMug: parseInt( $("#seconds-to-mug").val() )
	}

	let serverSettings = {
		svNpcMugging: {
			robbableObjects: getNpcMuggingRobbableObjects(),
			minimumPolice: parseInt( $("#npc-mugging-minimum-police").val() ),
			probabilityPoliceAlert: parseInt( $("#npc-mugging-probability-police-alert").val() ),
			minimumObjectsAmount: parseInt( $("#npc-mugging-minimum-objects-amount").val() ),
			maximumObjectsAmount: parseInt( $("#npc-mugging-maximum-objects-amount").val() ),
			minutesAfterAutomaticallyRunAway: parseInt( $("#minutes-before-automatically-run-away").val() ),
			maxNPCsFollowing: parseInt( $("#npc-mugging-max-npcs-following").val() )
		}
	}

	$.post(`https://${resName}/saveSettings`, JSON.stringify({
		clientSettings: clientSettings,
		sharedSettings: sharedSettings,
		serverSettings: serverSettings,
	}));
});