local outfits = {}

local label = "Stripper outfit "
local iOffset, out = 0, ""

local replace = {
    ["arms"] = "arms",
    ["tshirt_1"] = "t-shirt",
    ["torso_1"] = "torso2",
    ["decals_1"] = "decals",
    ["pants_1"] = "pants",
    ["shoes_1"] = "shoes",
    ["chain_1"] = "accessory"
}

for i, v in pairs(outfits) do
    local t = ""
    local data = v.female
    local label = label .. i

    local outfitData = v.female
    local outfit = ""

    for og, new in pairs(replace) do
        if outfitData[og] then
            outfit = outfit .. ('       ["%s"] = { item = %i, texture = %i }, \n'):format(new, outfitData[og], outfitData[og:gsub("_1", "") .. "_2"] or 0)
        end
    end

    t = string.format([[
[%i] = {
    outfitLabel = "%s",
    outfitData = {
%s    }
},
]], iOffset + i, label, outfit)
    out = out .. t
end
print(out)