function AddPedToTargetting(ped)
    if (Config.target.enabled and Config.target.system) then

        local system = Config.target.system

        exports[system]:AddTargetEntity(ped, {
            options = {
                {
                    type = "client",
                    event = "kq_detective:investigate",
                    icon = "fas fa-user-injured",
                    label = L('Investigate'),
                    canInteract = function(entity)
                        return IsEntityDead(entity)
                    end,
                },
            },
            distance = 1.75
        })
    end
end
