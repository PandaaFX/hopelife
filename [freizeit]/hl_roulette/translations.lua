Translations = {}

function _(str, ...) -- Translate string
    if Translations[Config.TranslationSelected] ~= nil then
        if Translations[Config.TranslationSelected][str] ~= nil then
            return string.format(Translations[Config.TranslationSelected][str], ...)
        else
            return 'Translation [' .. Config.TranslationSelected .. '][' .. str .. '] does not exist'
        end
    else
        return 'Locale [' .. Config.TranslationSelected .. '] does not exist'
    end
end

function _U(str, ...) -- Translate string first char uppercase
    return tostring(_(str, ...):gsub('^%l', string.upper))
end

Translations['en'] = {
    ['limit_exceed'] = 'Ihre Wette ist zu niedrig oder zu hoch für diesen Tisch.',
    ['invalid_bet'] = 'Ungültiger Einsatzbetrag.',
    ['chair_used'] = 'Dieser Stuhl ist besetzt.',
    ['can_not_bet_because_started'] = 'Das Spiel hat begonnen, Sie können im Moment nicht wetten.',
    ['not_enough_chips'] = 'Sie haben nicht genug Chips, um eine Wette zu platzieren.',
    ['input_place_bet'] = 'Wie viele Chips möchten Sie setzen?',
    -- help msg
    ['help_sit_rulett'] = '~INPUT_CONTEXT~ Setzen Sie sich an den Roulettetisch.',
    ['help_rulett_all'] = '~INPUT_CELLPHONE_CANCEL~ Aufstehen \n~INPUT_CONTEXT~ Kamera wechseln\n~INPUT_LOOK_LR~ Nummer auswählen\n~INPUT_ATTACK~ Wettnummer\n~INPUT_CELLPHONE_UP~ Einsatz erhöhen\n~INPUT_CELLPHONE_DOWN~ Wetteinsatz reduzieren\n~INPUT_JUMP~ Benutzerdefinierter Einsatz',
    -- nui
    ['starting_soon'] = 'Das nächste Spiel startet gleich ...',
    ['game_going_on'] = 'Das Spiel ist noch im Gange..',
    ['seconds'] = 'Sekunde.',
    -- formatted msg
    ['won_chips'] = 'Sie haben %s Chips gewonnen. Multiplikator: x%s',
    ['placed_bet'] = 'Platziere Wette mit %s Chips.'
}

Translations['hu'] = {
    ['limit_exceed'] = 'Túl nagy vagy túl alacsony a téted.',
    ['invalid_bet'] = 'Érvénytelen tét érték.',
    ['chair_used'] = 'Ez a szék foglalt.',
    ['can_not_bet_because_started'] = 'Már elkezdődött a játszma, nem rakhatsz tétet.',
    ['not_enough_chips'] = 'Nincs elég chipsed hogy megtedd a tétet.',
    ['input_place_bet'] = 'Tét megadása',
    -- help msg
    ['help_sit_rulett'] = '~INPUT_CONTEXT~ Leülés a rulett asztalhoz.',
    ['help_rulett_all'] = '~INPUT_CELLPHONE_CANCEL~ Felállás\n~INPUT_CONTEXT~ Kameranézet váltás.\n~INPUT_LOOK_LR~ Szám kiválasztása\n~INPUT_ATTACK~ Szám megrakása\n~INPUT_CELLPHONE_UP~ Tét emelése\n~INPUT_CELLPHONE_DOWN~ Tét csökkentése\n~INPUT_JUMP~ Tét megadása',
    -- nui
    ['starting_soon'] = 'Játék hamarosan kezdődik..',
    ['game_going_on'] = 'Játék jelenleg folyamatban..',
    ['seconds'] = 'másodperc.',
    -- formatted msg
    ['won_chips'] = 'Nyertél %s chipset.\n(Szorzó x%s)',
    ['placed_bet'] = 'Tét megrakva %s chipssel.'
}
