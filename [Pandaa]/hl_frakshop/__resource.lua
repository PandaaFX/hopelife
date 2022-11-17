resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'Fraktionsshop'

version '1.0.0'

server_scripts {
  '@async/async.lua',
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'
}

client_scripts {
  'vehicle_names.lua',
  'Config/Config.lua',
  'client/main.lua'
}

ui_page 'html/ui.html'
files {
  'html/ui.html',
  'html/ui.css', 
  'html/ui.js',
  'html/close.png',
  'html/garage.png',
  'html/carimages/*.png',
  'html/cars/*.png',
  'html/car.png'
}


dependencies {
	'es_extended'
}
