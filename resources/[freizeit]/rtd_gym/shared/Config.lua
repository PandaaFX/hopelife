Gym = {}

Gym['locale'] = "de"

Gym.BreakTime = 60000
Gym.MemberCost = 500

Gym.UpdateFrequency = 3600 -- Segundos que pasan para borrar un stat. (Por defecto 1 hora) / Seconds that pass to clear a stat. (Default 1 hour)
Gym.DeleteStats = true -- True = borramos un poco de las stats cada vez que el tiempo especificado (Gym.UpdateFrequency) pase. / True = We delete a bit of stats each time the specified time (Gym.UpdateFrequency) passes.

Gym.Notifications = false --  notificamos cuando pierdes/ganas stats? / we notify when you lose/gain stats?

Gym.AccountType = 'money' -- Tipo de cuenta para la membresia. / Membership account type. (bank, black_money, money)

Gym.SkillsCommand = 'skills' -- Comando para abrir el menu de habilidades. / Command to open the skills menu.

Gym.Skills = {
    ["Resistencia"] = { -- Resistencia or Endurance
        ["Current"] = 0, 
        ["RemoveAmount"] = -0.3, 
        ["Stat"] = "MP0_STAMINA" 
    },

    ["Fuerza"] = { -- Fuerza or Strength
        ["Current"] = 0,
        ["RemoveAmount"] = -0.3,
        ["Stat"] = "MP0_STRENGTH"
    },
}