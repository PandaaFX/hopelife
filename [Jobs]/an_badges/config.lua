Config = {}

---- Do not forget to configure fxmanifest.lua as well 
Config.Settings = {
    { -- LSPD Example
        itemName = "badge", -- item name
        design = "lspd.png", -- imagename.png
        job = "police", -- job name that will show this badge
        number = "#01", -- callsign department number - It shows before the officer callsign
    },
    { -- BCSO Example
        itemName = "sdbadge",
        design = "bcso.png",
        job = "lssd",
        number = "#02",
    },
	{ -- DOJ Example
        itemName = "dojbadge",
        design = "doj.png",
        job = "doj",
        number = "#03",
    },
    { -- FIB Example
        itemName = "fibbadge",
        design = "fib.png",
        job = "fib",
        number = "#69",
    }
}

Config.Ranks = {
    ["police"] = { -- Job Name
        [0] = "Rek.", -- Grade → Grade Name that you want to show before the name in the badge
        [1] = "Ofc.1.",
        [2] = "Ofc.2.",
        [3] = "Ofc.3.",
        [4] = "Det.1.",
        [5] = "Det.2.",
        [6] = "Det.3.",
        [7] = "Serg.1.",
        [8] = "Serg.2.",
        [9] = "Serg.3.",
        [10] = "Lt.1.",
        [11] = "Lt.2.",
        [12] = "Lt.3.",
        [13] = "Cp.1.",
        [14] = "Cp.2.",
        [15] = "Com.1.",
        [16] = "Com.2.",
        [17] = "Dep.Ch.",
        [18] = "As.Ch",
        [19] = "Chief.",
    },
    ["lssd"] = {
        [0] = "Cadet",
        [1] = "Ofc.1.", -- Grade → Grade Name that you want to show before the name in the badge
        [2] = "Ofc.2.",
        [3] = "Ofc.3.",
        [4] = "Corp.1.",
        [5] = "Corp.2.",
        [6] = "Serg.1.",
        [7] = "Serg.2.",
        [8] = "Serg.3.",
        [9] = "Cp1.",
        [10] = "Cp2.",
        [11] = "Cp3.",
        [12] = "Maj1.",
        [13] = "Maj2.",
        [14] = "Maj3.",
        [15] = "Col.1.",
        [16] = "Col.2.",
        [17] = "Dep.Sh.",
        [18] = "Ch.Dep.",
        [19] = "Sheriff",
    },
	["doj"] = {
        [1] = "RA",
        [2] = "StA", -- Grade → Grade Name that you want to show before the name in the badge
        [3] = "Marshal",
        [4] = "Dir. USMS",
        [5] = "Richter",
        [6] = "GStA",
        [7] = "Dep. Chief",
        [8] = "Chief",
    },
    ["fib"] = {
        [1] = "Trainee",
        [2] = "Agent",
        [3] = "Experienced Agent",
        [4] = "Special Agent",
        [5] = "Supervisory Agent",
        [6] = "Section Director",
        [7] = "Asst. Director",
        [8] = "Director",
    },
}

Config.DefaultCallsign = "000"