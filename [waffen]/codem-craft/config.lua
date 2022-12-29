Config = {}


Config.frameworkObject = "esx" -- newqb, oldqb, esx, infinity
Config.Mysql = "oxmysql" -- mysql-async -- oxmysql
Config.SetCraftXpCommand = 'setxp' -- example = setxp id xp  = setxp 2 5
Config.AdminPerm = 'admin' --- admin rank
Config.Craft = {
    {npcHash = 's_m_m_ammucountry' ,coords = vector3(2306.89, 4881.82, 41.8082) , npcHeading = 31.91}
}



Config.Categories = {
    {
        name = "weapon",
        label = "Weapon",
    },
    {
        name = "ammo",
        label = "Ammo",
    },
    {
        name = "tools",
        label = "Tools",
    },
  
}




Config.CraftItem = {
    {
        itemName = 'weapon_switchblade',
        itemLabel = 'Klappmesser',
        minute = 1 ,
        level = 0,
        xp = 20,
        category = 'weapon',
        required = {
            { label = 'schrauben', name = "schrauben", amount = 100},
            { label = 'griff', name = "griff", amount = 1},
            
            
            
        },
        imagesname = 'weapon_switchblade' ,  ---- for mid image
   
    },
    {
        itemName = 'weapon_knuckle',
        itemLabel = 'Schlagring',
        minute = 1 ,
        level = 0,
        xp = 20,
        category = 'weapon',
        required = {
            { label = 'griff', name = "griff", amount = 1},
            { label = 'schrauben', name = "schrauben", amount = 100},           
        },
        imagesname = 'weapon_knuckle' ,  ---- for mid image
   
    },

    {
        itemName = 'weapon_crowbar',
        itemLabel = 'Brecheisen',
        minute = 1 ,
        level = 1,
        xp = 20,
        category = 'tools',
        required = {
            { label = 'schrauben', name = "schrauben", amount = 100},
            { label = 'griff', name = "griff", amount = 1},
            
            
        },
        imagesname = 'weapon_crowbar' ,  ---- for mid image
   
    },

    {
        itemName = 'weapon_bottle',
        itemLabel = 'Flasche',
        minute = 1 ,
        level = 1,
        xp = 20,
        category = 'tools',
        required = {
            { label = 'schrauben', name = "schrauben", amount = 100},
            { label = 'griff', name = "griff", amount = 1},
            
            
        },
        imagesname = 'weapon_bottle' ,  ---- for mid image
   
    },

    {
        itemName = 'weapon_pistol',
        itemLabel = 'Pistole',
        minute = 1 ,
        level =  1,
        xp = 20,
        category = 'weapon',
        required = {
            { label = 'griff', name = "griff", amount = 1},
            { label = 'schrauben', name = "schrauben", amount = 350},
            { label = 'Schaft', name = "schaft", amount = 1},
            { label = 'Lauf', name = "lauf", amount = 1},
            { label = 'KleinerChip', name = "chip1", amount = 1},
            
        },
        imagesname = 'weapon_pistol50' ,  ---- for mid image
   
    },


    {
        itemName = 'weapon_microsmg',
        itemLabel = 'Micro SMG',
        minute = 1 ,
        level = 2,
        xp = 30,
        category = 'weapon',
        required = {
            { label = 'schrauben', name = "schrauben", amount = 250},
            { label = 'griff', name = "griff", amount = 1},
            { label = 'Schaft', name = "schaft", amount = 2},
            { label = 'Lauf', name = "lauf", amount = 1},
            { label = 'MittlererChip', name = "chip2", amount = 1},
            
        },
        imagesname = 'weapon_microsmg' ,  ---- for mid image
   
    },

    {
        itemName = 'weapon_assaultrifle',
        itemLabel = 'Assault Rifle',
        minute = 1 ,
        level = 2,
        xp = 30,
        category = 'weapon',
        required = {
            { label = 'schrauben', name = "schrauben", amount = 250},
            { label = 'griff', name = "griff", amount = 4},
            { label = 'Schaft', name = "schaft", amount = 2},
            { label = 'Lauf', name = "lauf", amount = 1},
            { label = 'MittlererChip', name = "chip2", amount = 1},
        },
        imagesname = 'weapon_assaultrifle' ,  ---- for mid image
   
    },

    {
        itemName = 'weapon_pistol50',
        itemLabel = 'Pistole Kal. 50',
        minute = 1 ,
        level = 3,
        xp = 40,
        category = 'weapon',
        required = {
            { label = 'griff', name = "griff", amount = 1},
            { label = 'schrauben', name = "schrauben", amount = 350},
            { label = 'Schaft', name = "schaft", amount = 1},
            { label = 'Lauf', name = "lauf", amount = 1},
            { label = 'GroßerChip', name = "chip2", amount = 1},
            
        },
        imagesname = 'weapon_pistol50' ,  ---- for mid image
   
    },

    {
        itemName = 'weapon_gusenberg',
        itemLabel = 'Gusenberg',
        minute = 1 ,
        level = 3,
        xp = 40,
        category = 'weapon',
        required = {
            { label = 'schrauben', name = "schrauben", amount = 500},
            { label = 'griff', name = "griff", amount = 3},
            { label = 'schaft', name = "schaft", amount = 2},
            { label = 'lauf', name = "lauf", amount = 2},
            { label = 'GroßerChip', name = "chip2", amount = 1},
            
        },
        imagesname = 'weapon_gusenberg' ,  ---- for mid image
   
    },

    {
        itemName = 'weapon_bullpuprifle',
        itemLabel = 'Bullpup',
        minute = 1 ,
        level = 4,
        xp = 50,
        category = 'weapon',
        required = {
            { label = 'schrauben', name = "schrauben", amount = 500},
            { label = 'griff', name = "griff", amount = 1},
            { label = 'schaft', name = "schaft", amount = 1},
            { label = 'lauf', name = "lauf", amount = 1},
            { label = 'GroßerChip', name = "chip3", amount = 1},
        },
        imagesname = 'weapon_bullpuprifle' ,  ---- for mid image
   
    },

    {
        itemName = 'weapon_molotov',
        itemLabel = 'Molotov',
        minute = 1 ,
        level = 5,
        xp = 60,
        category = 'tools',
        required = {
            { label = 'schrauben', name = "schrauben", amount = 100},
            { label = 'griff', name = "griff", amount = 1},
            
            
        },
        imagesname = 'weapon_molotov' ,  ---- for mid image
   
    },

    {
        itemName = 'weapon_advancedrifle',
        itemLabel = 'Advanced',
        minute = 1 ,
        level = 5,
        xp = 70,
        category = 'weapon',
        required = {
            { label = 'schrauben', name = "schrauben", amount = 450},
            { label = 'griff', name = "griff", amount = 3},
            { label = 'schaft', name = "schaft", amount = 2},
            { label = 'lauf', name = "lauf", amount = 2},
            { label = 'GroßerChip', name = "chip3", amount = 1},
        },
        imagesname = 'weapon_advancedrifle' ,  ---- for mid image
   
    },

    {
        itemName = 'weapon_militaryrifle',
        itemLabel = 'Military',
        minute = 1 ,
        level = 6,
        xp = 80,
        category = 'weapon',
        required = {
            { label = 'schrauben', name = "schrauben", amount = 650},
            { label = 'griff', name = "griff", amount = 4},
            { label = 'schaft', name = "schaft", amount = 4},
            { label = 'lauf', name = "lauf", amount = 3},
            { label = 'GroßerChip', name = "chip3", amount = 1},
        },
        imagesname = 'weapon_militaryrifle' ,  ---- for mid image
   
    },

    {
        itemName = 'key',
        itemLabel = 'Handschellenschlüssel',
        minute = 1 ,
        level = 2,
        xp = 90,
        category = 'tools',
        required = {
            { label = 'Kupfer', name = "copper", amount = 500},
            { label = 'Eisen', name = "iron", amount = 500},
            
            
        },
        imagesname = 'key' ,  ---- for mid image
   
    },

   
 
}


function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.3, 0.3)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 90)
end


Config.Notifications = { -- Notifications
    ["success"] = {
        message = 'Herstellen beendet',
        type = "succes",
        time = 2500,
    },
  
    ["error"] = {
        message = 'Fehler',
        type = "error",
        time = 2500,
    },

}