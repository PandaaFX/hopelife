fx_version 'cerulean'
games { 'gta5' }

lua54 'yes'

description 'Progressbar'

version '1.0.1'

escrow_ignore {
  'client.lua',
}

files {
    'html/index.html',
    'html/style.css',
    'html/main.js',
}

client_scripts {
    'client.lua'
}

ui_page 'html/index.html'

export "drawBar"

dependency '/assetpacks'