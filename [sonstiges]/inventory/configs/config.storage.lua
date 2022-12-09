Config.Storages = false -- toggle storages | default: true
Config.StorageLocations = {
  ["tsche"] = {
    label = "Tschetschenen",
    jobs = {'che'}, -- set to false to disable whitelisting
    job_grades = {10,11,12}, -- set to false to disable grading
    weight = 5000000,
    delay = 500,
    openBtn = "Lager öffnen",
    blip = {id = 525, color = 7, scale = 0.5, hiddenForOthers = true},
    locations = {
      vector3(-3031.819824, 87.468140, 12.345825),
    }
  },
  ["mg13"] = {
    label = "MG13",
    jobs = {'mg13'}, -- set to false to disable whitelisting
    job_grades = {7,8,9,10,11,12}, -- set to false to disable grading
    weight = 5000000,
    delay = 500,
    openBtn = "Lager öffnen",
    blip = {id = 525, color = 7, scale = 0.5, hiddenForOthers = true},
    locations = {
      vector3(1246.087891, -1574.835205, 58.345825),
    }
  },
  ["lafam"] = {
    label = "La Familia",
    jobs = {'lafam'}, -- set to false to disable whitelisting
    job_grades = {9,10,11,12}, -- set to false to disable grading
    weight = 5000000,
    delay = 500,
    openBtn = "Lager öffnen",
    blip = {id = 525, color = 7, scale = 0.5, hiddenForOthers = true},
    locations = {
      vector3(-3198.633057, 838.496704, 8.925293),
    }
  },
  --[[
  ["ndrang"] = {
    label = "Wein",
    jobs = {'wein'}, -- set to false to disable whitelisting
    job_grades = {5,6,7,8,9,10,11,12}, -- set to false to disable grading
    weight = 5000000,
    delay = 500,
    openBtn = "Lager öffnen",
    blip = {id = 525, color = 7, scale = 0.5, hiddenForOthers = true},
    locations = {
      vector3(-1882.681274, 2070.712158, 140.994141),
    }
  },
  ]]
  ["saints"] = {
    label = "Saints",
    jobs = {'saints'}, -- set to false to disable whitelisting
    job_grades = {6,7,8,9,10,11,12}, -- set to false to disable grading
    weight = 5000000,
    delay = 500,
    openBtn = "Lager öffnen",
    blip = {id = 525, color = 7, scale = 0.5, hiddenForOthers = true},
    locations = {
      vector3(-1739.301147, 373.806610, 89.720093),
    }
  }
}