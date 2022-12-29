
	local blips = {
		-- The Prison
		 {title="Billiard", colour=2, id=491, x=-1595.75, y=-988.35, z=13.08},
		 {title="Autohändler", colour=2, id=756, x=-57.63, y=-1096.25, z=26.42},
     {title="Flugzeughändler", colour=1, id=307, x=-949.5, y = -2946.55, z = 13.95},
     {title="7 Night Club", colour=74, id=136, x=-224.57, y = -272.13, z = 47.01},
     {title="B-Smoke", colour=74, id=106, x=-431.261536, y = -24.105492, z = 46.213867}, 
     {title="Pearls Restaurant", colour=29, id=270, x=-1833.415, y = -1194.843, z = 14.30},
     {title="Tequila LaLa", colour=29, id=270, x=-559.84, y = 285.76, z = 82.18},
     {title="Fishmarkt & Zubehör", colour=26, id=68, x=-1038.4545898438, y = -1397.0551757813, z = 4.5},
     {title="Bauamt", colour=64, id=566, x=-600.527466, y = -929.393433, z = 23.854248},
     {title="Anwaltskanzlei Garcia", colour=60, id=269, x=-589.595581, y = -706.153870, z = 36.272583 },
     {title="Burgershot", colour=17, id=106, x=-827.551636, y = -803.116455, z = 24.393433 },

    --  -827.551636, -803.116455, 24.393433
		} 
    ---, , 
	
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 0.7)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	    BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)


