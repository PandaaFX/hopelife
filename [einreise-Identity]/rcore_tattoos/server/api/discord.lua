function sendCustomDiscordMessage(webhook, name, message, color, footer)
    footer = footer or "rcore_tattoos | rcore.cz"
    color = color or SConfig.DiscordColors.Grey
    local embeds = {
        {
            ["title"] = name,
            ["description"] = message,
            ["type"] = "rich",
            ["color"] = color,
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers)
    end, 'POST', json.encode({ username = name, embeds = embeds }), { ['Content-Type'] = 'application/json' })
end
