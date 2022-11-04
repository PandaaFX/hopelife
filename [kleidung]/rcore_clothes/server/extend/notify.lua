function notify(source, text, style)
    TriggerClientEvent(triggerName("notify"), source, text, style)
end
