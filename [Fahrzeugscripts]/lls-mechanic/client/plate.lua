plates = {
{"plate01","https://i.imgur.com/56K8nnG.png",734,361},
{"plate01_n","https://i.imgur.com/FNb3UP8.png",256,128},
{"plate02","https://i.imgur.com/TPYHhMt.png",734,361},
{"plate02_n","https://i.imgur.com/7sKA7M1.png",300,160},
{"plate03","https://i.imgur.com/bBe7FFV.png",734,361},
{"plate03_n","https://i.imgur.com/7sKA7M1.png",300,160},
{"plate04_n","https://i.imgur.com/FNb3UP8.png",256,128},
{"plate04","https://i.imgur.com/SHIlqdc.png",734,361},
{"plate05","https://i.imgur.com/OB7Zuxb.png",734,361},
{"plate05_n","https://i.imgur.com/FNb3UP8.png",256,128},
{"yankton_plate","https://i.imgur.com/T9OQDpW.png",734,361},
{"yankton_plate_n","https://i.imgur.com/FNb3UP8.png",256,128},
}

for l, p in pairs(plates) do
    local txd = CreateRuntimeTxd("testing")
    local duiObj = CreateDui(p[2], p[3], p[4])
    local dui = GetDuiHandle(duiObj)
    local tx = CreateRuntimeTextureFromDuiHandle(txd, "test", dui)
    AddReplaceTexture("vehshare", p[1], "testing", "test")
end