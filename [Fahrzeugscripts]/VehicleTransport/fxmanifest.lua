



fx_version 'adamant'
games { 'gta5' }

author 'Philipp Decker'
description 'Attach vehicles to other vehicles!'
version '1.6'

files {
    'config.ini',
    'transportData.json',
    'stream/gaudeee_carramp2.ydr',
    'stream/gaudeee_carramp2.ytyp',
}

server_scripts {
    'server/server.lua'
}

client_scripts {
    'client/Newtonsoft.Json.dll',
    'client/Kiminaze_FiveM_FileHandler.net.dll',
    'client/Kiminaze_VehicleTransport_Client.net.dll'
}

data_file 'DLC_ITYP_REQUEST' 'stream/gaudeee_carramp2.ytyp'
