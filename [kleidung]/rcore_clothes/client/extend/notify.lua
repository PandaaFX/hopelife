function notify(text, style)
    SendNUIMessage({
        type = 'notify',
        message = text,
        alert = style,
    })
end

RegisterNetEvent(triggerName("notify"))
AddEventHandler(triggerName("notify"), notify)

function ShowHelpNotification(text)
    AddTextEntry('jesuswhy_two', text)
    BeginTextCommandDisplayHelp('jesuswhy_two')
    EndTextCommandDisplayHelp(0, false, true, 5000)
end

RegisterNetEvent(triggerName("ShowHelpNotification"))
AddEventHandler(triggerName("ShowHelpNotification"), ShowHelpNotification)