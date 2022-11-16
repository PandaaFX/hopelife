Strings = {
    ["blip"] = "Vanilla unicorn",

    ["poledance"] = "poledance",
    ["lapdance"] = "lapdance",
    ["cancel_dance"] = "Press ~INPUT_FRONTEND_RRIGHT~ to stop dancing",

    ["sit"] = "sit",
    ["cancel_sit"] = "Press ~INPUT_FRONTEND_RRIGHT~ to stand up",
    ["cancel_sit_touch"] = "Press ~INPUT_FRONTEND_RRIGHT~ to stand up\nHold ~INPUT_VEH_HANDBRAKE~ to touch",
    ["stop_touch"] = "Release ~INPUT_VEH_HANDBRAKE~ to stop touching",

    ["change_clothes"] = "change clothes",
    ["wardrobe"] = "Wardrobe",

    ["regular"] = "Regular outfit",
    
    ["lean"] = "lean",
    ["cancel_lean"] = "Press ~INPUT_FRONTEND_RRIGHT~ to stop leaning\nPress ~INPUT_DETONATE~ to throw money ($%i)\nPress ~INPUT_CONTEXT~ to make it rain ($%i)",
    ["no_money"] = "You don't have enough money!",
    ["no_dancer"] = "There's no stripper to throw money at!",
    ["threw"] = "Someone threw ~g~$%s ~s~at you!",

    ["occupied"] = "Occupied",

    ["boss_actions"] = "manage boss actions",
    ["inventory"] = "Zugang zum Lager",

    ["items"] = "Items",
    ["weapons"] = "Weapons",
    ["storage"] = "Lager",
    ["get_items"] = "Herraus nehmen",
    ["put_items"] = " Einlagern",
    ["get_weapons"] = "Withdraw weapons",
    ["put_weapons"] = "Deposit weapons",
    ["no_items"] = "Keine Items",
    ["no_weapons"] = "No weapons",
    ["quantity"] = "Menge",
    ["invalid_amount"] = "Ungültige Menge",
    ["deposited"] = "Eingelagert x%s %s",
    ["withdrew"] = "Aufgenommen x%s %s",
    ["cant_carry"] = "Du kannst nicht soviel tragen!",

    ["enter_bar"] = "Öffnen",
    ["exit_bar"] = "Zurück",
    ["open_fridge"] = "Kühlschrank öffnen",
    ["purchase_items"] = "Purchase items",
    ["purchase_bundles"] = "Fertige Drinks Einkaufen",
    ["purchase_bundle"] = "%s ($%s)",
    ["fridge"] = "Kühlschrank",
    ["browse_items"] = "Kühlung",

    ["open_menu"] = "Unicorn job menu",
    ["job_menu"] = "Vanilla unicorn",
    ["bill_closest"] = "Rechnung an nähste Person",
    ["bill_reason"] = "Rechnungs Grund",
    ["bill_amount"] = "Rechnungs Höhe",
    ["player_id"] = "Player id",
    ["invalid_reason"] = "Ungültiger Grund",
    ["noone_nearby"] = "Keiner in der Nähe!",
    ["billed"] = "Rechnung ausgestellt ~g~$%s ~s~Grund %s.",

    ["listing_item"] = "%s ($%s)",
    ["amount_buy"] = "Amount of %s to purchase?",
    ["company_no_money"] = "The company doesn't have enough money.",
    ["you_purchased"] = "You purchased x%s %s for $%s",

    ["mix_drink"] = "Mix ein Drink",
    ["mixed"] = "Du mixt %s",
    ["select_drink"] = "Wähle einen Drink",
    ["make_drink"] = "Stelle einen %s her",
    ["amount_ingredient"] = "x%s %s",
    ["missing_ingredients"] = "Nicht genug Zutaten.",
}

-- ignore this
setmetatable(Strings, {__index = function(self, key)return "Error: Missing translation for \""..key.."\""end})