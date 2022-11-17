Customization = { -- DONT CHANGE BELOW, IF YOU DON'T KNOW WHAT YOU'RE DOING
  debug = false,

  -- Target (EYE) Interaction (I'd recommend this, as it performs much better)
  
  -- MAKE SURE TO SET THE RESOURCE NAME
  useTarget = false, -- None of the QB Core or ESX notifications & custom "textFunction" will work with this enabled
  targetResourceName = "qb-target", -- (qb-target, qtarget, etc | Curr supported are qb-target, qtarget & bt-target)
  targetDist = 2.0, -- Change this to whatever you want
  target = { -- Target UI data, change the text and icon to whatever you want
    label = "Aufheben",
    icon = "fa-solid fa-hat-cowboy"
  },

  -- 3D Draw Text
  drawDistance = 2, -- The distance to start display the 3d text / notifications
  interactionText = { -- CHANGE THIS TO WHAT YOU WANT EACH TO SAY
    ["hat"] = "~g~[E] ~w~Hut aufheben",
    ["glasses"] = "~g~[E] ~w~Brille aufheben"
  },
  defaultType = "3d-text", -- (3d-text, upper-left) IF YOU ARE USING THIS, SET `customText` TO FALSE
  customText = false,
  textType = "qb-core", -- (qb-core, esx, etc [your framework if you wanna execute a custom notification])
  textFunction = function(inputText)
    if Customization.customText then -- Use custom text or notification
      if Customization.textType == "qb-core" or Customization.textType == "esx" then
        if Customization.textType == "qb-core" then
          -- Put QB Function or whatever you like here
        elseif Customization.textType == "esx" then
          ESX.ShowNotification(inputText) -- Put ESX Function or whatever you like here
        end
      else -- custom system
        -- put your custom notification/display text/3d text execution here
      end
    end
  end
}