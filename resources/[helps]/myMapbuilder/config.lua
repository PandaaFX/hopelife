Config = {}
Translation = {}

Config.Locale = 'de'

Config.useNativeUIReloaded = false -- if you want to disable NativeUIReloaded, you have to activate the dependency in fxmanifest.lua!
Config.Debug = false
Config.Command = 'mapbuilder' -- command to open the menu

Config.KeyUsage = false
Config.Key = 38 -- Key, when Key Usage is enabled.

Config.defaultObject = '~r~Nothing'

Config.OnlyForAdmin = true -- then only people with the group can open the menu
Config.AdminGroup = 'admin'

Config.Controls = {
    -- turn controls
    turnright = {
        name = 'INPUT_CELLPHONE_RIGHT',
        key = 175
    },
    turnleft = {
        name = 'INPUT_CELLPHONE_LEFT',
        key = 174
    },
    -- move controls
    moveright = {
        name = 'INPUT_CELLPHONE_RIGHT',
        key = 175
    },
    moveleft = {
        name = 'INPUT_CELLPHONE_LEFT',
        key = 174
    },
    moveup = {
        name = 'INPUT_FRONTEND_UP',
        key = 172
    },
    movedown = {
        name = 'INPUT_FRONTEND_DOWN',
        key = 173
    },
    movehigher = {
        name = 'INPUT_FRONTEND_UP',
        key = 172
    },
    movelower = {
        name = 'INPUT_FRONTEND_DOWN',
        key = 173
    },
    -- general controls
    fast = {
        name = 'INPUT_FRONTEND_SELECT',
        key = 217
    },
    slow = {
        name = 'INPUT_FRONTEND_LS',
        key = 209
    },
    finish = {
        name = 'INPUT_CELLPHONE_CAMERA_EXPRESSION',
        key = 186
    },
}

Config.recommendObjects = {
    {object = 'prop_table_para_comb_01', label = 'Table with umbrella', price = 1000},
    {object = 'prop_patio_lounger1', label = 'Patio lounger', price = 1000},
    {object = 'prop_patio_heater_01', label = 'Patio heater', price = 1000},
    {object = 'prop_parasol_01', label = 'Parasol', price = 1000},
    {object = 'prop_table_01', label = 'Table', price = 1000},
    {object = 'prop_table_04_chr', label = 'Chair', price = 1000},
    {object = 'prop_bbq_5', label = 'BBQ', price = 1000},
    {object = 'apa_mp_h_din_table_11', label = 'Couch table', price = 1000},
    {object = 'prop_owl_totem_01', label = 'Totem', price = 1000},
} -- You can find these objects for example on: https://cdn.rage.mp/public/odb/index.html

Translation = {
    ['en'] = {
        ['menu_title'] = 'Map Builder',

        ['get_object_distance'] = 'Placed objects',

        ['controls'] = 'Controls',
        ['turn_right'] = ' ~s~to ~b~turn ~s~the object ~b~right',
        ['turn_left'] = ' ~s~to ~b~turn ~s~the object ~b~left',
        ['turn_fast'] = ' ~s~to ~b~turn ~s~the object ~b~faster',
        ['turn_slow'] = ' ~s~to ~b~turn ~s~the object ~b~slower',
        ['move_forward'] = ' ~s~to ~b~move ~s~the object ~b~forward',
        ['move_backwards'] = ' ~s~to ~b~move ~s~the object ~b~backwards',
        ['move_right'] = ' ~s~to ~b~move ~s~the object ~b~right side',
        ['move_left'] = ' ~s~to ~b~move ~s~the object ~b~left side',
        ['move_fast'] = ' ~s~to ~b~move ~s~the object ~b~faster',
        ['move_slow'] = ' ~s~to ~b~move ~s~the object ~b~slower',
        ['move_higher'] = ' ~s~to ~b~move ~s~the object ~b~up',
        ['move_lower'] = ' ~s~to ~b~move ~s~the object ~b~down',
        ['back_to_menu'] = ' ~s~to go ~b~back ~s~to main menu',

        ['only_for_admins'] = '~r~This function can only be used by staff members!',

        ['spawn_object'] = 'Spawn object',
        ['spawn_object_final'] = '~g~Spawn object',
        ['spawn_object_final_desc'] = '~g~Object will be created at your current location',
        ['move_object'] = 'Move object',
        ['turn_object'] = 'Turn object',
        ['delete_object'] = '~r~Delete object',
        ['delete_object_desc'] = 'Delete object from map',
        ['save_object'] = '~g~Save object',
        ['save_object_desc'] = 'Save object to your database',
        ['enter_objectname'] = 'Object:',
        ['enter_objectname_desc'] = 'Click to enter an object name',
        ['moveupdown_object'] = 'Move object up and down',

        ['obj_tp'] = 'Teleport',
        ['obj_tp_desc'] = 'Teleport to this object',
        ['obj_hide'] = 'Hide',
        ['obj_hide_desc'] = 'Hide this object (only for you)',
        ['obj_replace'] = '(Re-)Spawn',
        ['obj_replace_desc'] = 'Spawns this object again (Undo Hide)',
        ['obj_already_exists'] = '~r~The object is still there. Hide it first and then you could respawn it.',
        ['obj_permdelete_desc'] = 'The object will be permanently removed from database!',
        ['obj_removed'] = '~g~The object was removed from database.',
        ['obj_savechanges'] = '~g~Save changes.',
        ['obj_savechanges_desc'] = 'Your changes will be saved and applied for all players.',
        ['obj_saved'] = '~g~Your changes were saved!',
        
        ['set_moveable'] = 'Freeze object?',
        ['set_moveable_desc'] = 'Should it be possible to push/move this object?',
        ['moveable_state_changed'] = '~g~Freeze state changed to ~w~',
        ['set_description'] = 'Description',
        ['set_description_desc'] = 'Makes it easier to find your object in the menu.',

        ['recommend_objects'] = 'Available objects',
        ['recommend_objects_desc'] = 'List of useful objects',
        ['select_object_desc'] = 'Buy object ~b~',

        ['selectObject_help'] = 'Now enter your object using ~y~/selectObject [~g~OBJECT~y~]~s~.',
        ['invalid_object'] = '~r~Invalid object!',
        ['not_enough_money'] = '~r~You do not have enough money!',
        ['no_object'] = '~r~No object!',
        ['cant_save'] = '~r~Object was not saved! Restart your game to to edit this object.',
        
    },
    ['de'] = {
        ['menu_title'] = 'Map Builder',

        ['get_object_distance'] = 'Platzierte Objekte',

        ['controls'] = 'Bedienung',
        ['turn_right'] = ' ~s~um das Objekt ~b~nach rechts ~s~zu drehen',
        ['turn_left'] = ' ~s~um das Objekt ~b~nach links ~s~zu drehen',
        ['turn_fast'] = ' ~s~um das Objekt ~b~schneller ~s~zu drehen',
        ['turn_slow'] = ' ~s~um das Objekt ~b~langsamer ~s~zu drehen',
        ['move_forward'] = ' ~s~um das Objekt nach ~b~vorne ~s~zu ~b~bewegen.',
        ['move_backwards'] = ' ~s~um das Objekt nach ~b~hinten ~s~zu ~b~bewegen.',
        ['move_right'] = ' ~s~um das Objekt nach ~b~rechts ~s~zu ~b~bewegen.',
        ['move_left'] = ' ~s~um das Objekt nach ~b~links ~s~zu ~b~bewegen.',
        ['move_fast'] = ' ~s~um das Objekt ~b~schneller ~s~zu ~b~bewegen.',
        ['move_slow'] = ' ~s~um das Objekt ~b~langsamer ~s~zu ~b~bewegen.',
        ['move_lower'] = ' ~s~um das Objekt ~b~nach unten ~s~zu ~b~bewegen.',
        ['move_higher'] = ' ~s~um das Objekt ~b~nach oben ~s~zu ~b~bewegen.',
        ['back_to_menu'] = ' ~s~um zum ~b~Hauptmenu ~s~zurückzukehren.',

        ['only_for_admins'] = '~r~Nur Admins können beliebige Objekte verwenden!',

        ['spawn_object'] = 'Objekt spawnen',
        ['spawn_object_final'] = '~g~Objekt spawnen',
        ['spawn_object_final_desc'] = '~g~Das Objekt wird an deiner Position spawnen',
        ['move_object'] = 'Objekt bewegen',
        ['turn_object'] = 'Objekt drehen',
        ['delete_object'] = '~r~Objekt löschen',
        ['delete_object_desc'] = 'Lösche das Objekt',
        ['save_object'] = '~g~Objekt speichern',
        ['save_object_desc'] = 'Speichert das Objekt in der Datenbank',
        ['enter_objectname'] = 'Objekt:',
        ['enter_objectname_desc'] = 'Klicke, um eine Beschreibung hinzuzufügen',
        ['moveupdown_object'] = 'Höhe verändern',

        ['obj_tp'] = 'Teleport',
        ['obj_tp_desc'] = 'Teleportiere dich zu diesem Objekt',
        ['obj_hide'] = 'Ausblebende',
        ['obj_hide_desc'] = 'Blende das Objekt aus (Nur für dich unsichtbar)',
        ['obj_replace'] = 'Einblenden',
        ['obj_replace_desc'] = 'Blende das Objekt wieder ein',
        ['obj_already_exists'] = '~r~Das Objekt sollte noch sichtbar sein.',
        ['obj_permdelete_desc'] = 'Das Objekt wird permanent aus der Datenbank gelöscht!',
        ['obj_removed'] = '~g~Das Objekt wurde aus der Datenbank entfernt.',
        ['obj_savechanges'] = '~g~Änderungen speichern.',
        ['obj_savechanges_desc'] = 'Deine Änderungen werden gespeichert und für alle Spieler synchronisiert.',
        ['obj_saved'] = '~g~Deine Änderungen wurden gespeichert!',

        ['set_moveable'] = 'Objekt einfrieren?',
        ['set_moveable_desc'] = 'Soll das Objekt bewegt werden können?',
        ['moveable_state_changed'] = '~g~Freeze-Status geändert: ~w~',
        ['set_description'] = 'Kommentar',
        ['set_description_desc'] = 'Dadurch kann das Objekt leichter wiedergefunden werden.',

        ['recommend_objects'] = 'Verfügbare Objekte',
        ['recommend_objects_desc'] = 'Nützliche Objekte',
        ['select_object_desc'] = 'Objekt kaufen~b~',

        ['selectObject_help'] = 'Wähle ein anderen Objekt mit ~y~/selectObject [~g~OBJECT~y~]~s~ aus.',
        ['invalid_object'] = '~r~Unbekanntes Objekt!',
        ['not_enough_money'] = '~r~Du hast nicht genügend Geld!',
        ['no_object'] = '~r~Kein Objekt!',
        ['cant_save'] = '~r~Änderungen nicht gespeichert! Bitte starte das Spiel neu.',
        
    },
	['es'] = {
        ['menu_title'] = 'Constructor de Mapas',

        ['get_object_distance'] = 'Objetos colocados',

        ['controls'] = 'Controles',
        ['turn_right'] = ' ~s~para ~b~girar ~s~el objeto a la ~b~derecha',
        ['turn_left'] = ' ~s~para ~b~girar ~s~el objeto ~b~Izquierda',
        ['turn_fast'] = ' ~s~para ~b~girar ~s~el objeto ~b~rapido',
        ['turn_slow'] = ' ~s~para ~b~girar ~s~el objeto ~b~lento',
        ['move_forward'] = ' ~s~para ~b~mover ~s~el objeto ~b~hacia adelante',
        ['move_backwards'] = ' ~s~para ~b~mover ~s~el objeto ~b~hacia atrás',
        ['move_right'] = ' ~s~para ~b~mover ~s~el objeto ~b~lado derecho',
        ['move_left'] = ' ~s~para ~b~mover ~s~el objeto ~b~lado izquierdo',
        ['move_fast'] = ' ~s~para ~b~mover ~s~el objeto ~b~rapido',
        ['move_slow'] = ' ~s~para ~b~mover ~s~el objeto ~b~lento',
        ['move_higher'] = ' ~s~para ~b~mover ~s~el objeto ~b~arriba',
        ['move_lower'] = ' ~s~para ~b~mover ~s~el objeto ~b~hacia abajo',
        ['back_to_menu'] = ' ~s~para ~b~volver ~s~al menu principal',

        ['only_for_admins'] = '~r~¡Esta función solo puede ser utilizada por miembros del personal aministrativo!',

        ['spawn_object'] = 'Carear objeto',
        ['spawn_object_final'] = '~g~Crear Objeto',
        ['spawn_object_final_desc'] = '~g~El objeto se creará en su ubicación actual',
        ['move_object'] = 'Mover objeto',
        ['turn_object'] = 'Girar objeto',
        ['delete_object'] = '~r~Eliminar objeto',
        ['delete_object_desc'] = 'Eliminar objeto del mapa',
        ['save_object'] = '~g~Guardar objeto',
        ['save_object_desc'] = 'Guarde el objeto en su base de datos',
        ['enter_objectname'] = 'Objeto:',
        ['enter_objectname_desc'] = 'Haga clic para ingresar un nombre de objeto',
        ['moveupdown_object'] = 'Arriba y abajo',

        ['obj_tp'] = 'Teletransportarse',
        ['obj_tp_desc'] = 'Teletransportarse a este objeto',
        ['obj_hide'] = 'Ocultar',
        ['obj_hide_desc'] = 'Ocultar este objeto (solo para ti)',
        ['obj_replace'] = '(Re-)Spawn',
        ['obj_replace_desc'] = 'Genera este objeto de nuevo (Deshacer Ocultar)',
        ['obj_already_exists'] = '~r~El objeto sigue ahí. Escóndelo primero y luego podrás reaparecer.',
        ['obj_permdelete_desc'] = '¡El objeto se eliminará permanentemente de la base de datos!',
        ['obj_removed'] = '~g~El objeto fue eliminado de la base de datos.',
        ['obj_savechanges'] = '~g~Guardar cambios.',
        ['obj_savechanges_desc'] = 'Tus cambios se guardarán y se aplicarán a todos los jugadores.',
        ['obj_saved'] = '~g~¡Se guardaron sus cambios!',

        ['set_moveable'] = '¿Congelar objeto?',
        ['set_moveable_desc'] = '¿Debería ser posible empujar / mover este objeto?',
        ['moveable_state_changed'] = '~g~El estado de congelación cambió a ~w~',
        ['set_description'] = 'Descripción',
        ['set_description_desc'] = 'Facilita la búsqueda de su objeto en el menú.',

        ['recommend_objects'] = 'Objetos disponibles',
        ['recommend_objects_desc'] = 'Lista de objetos útiles',
        ['select_object_desc'] = 'Comprar objeto ~b~',

        ['selectObject_help'] = 'Ahora ingrese su objeto usando ~y~/selectObject [~g~OBJECT~y~]~s~.',
        ['invalid_object'] = '~r~¡Objeto inválido!',
        ['not_enough_money'] = '~r~¡No tienes suficiente dinero!',
        ['no_object'] = '~r~Sin objeto!',
        ['cant_save'] = '~r~¡El objeto no se guardó! Reinicia tu juego para editar este objeto.',
        
    },
}