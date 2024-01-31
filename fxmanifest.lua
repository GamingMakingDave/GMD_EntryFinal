fx_version 'adamant'
game 'gta5'

author 'GMD_Scripts'
name 'GMD_Entry'
version '1.0.0'
description 'all in one entrysystem'

lua54 'yes'

ui_page "NUI/index.html"

files {
	'NUI/index.html',
	'NUI/script/*.js',
	'/config.js',
	'NUI/css/*.css',
	'NUI/media/*.png',
	'NUI/media/*.jpg',
	'NUI/fonts/*.ttf',
	'NUI/fonts/*.otf'
}

server_script {
	'@oxmysql/lib/MySQL.lua',
	'server/commands.lua',
	'server/encripted-sv.lua',
	'server/main-sv.lua'
}

client_scripts {
	'client/events-cl.lua',
	'client/functions-cl.lua',
	'client/encripted-cl.lua',
	'client/loops-cl.lua'
}

shared_scripts {
	'config.lua'
}

escrow_ignore {
	'server/commands.lua',
	'server/main-sv.lua',
	'client/events-cl.lua',
	'client/functions-cl.lua',
	'client/loops-cl.lua',
	'config.lua'
}

dependencies {
	'es_extended',
	'skinchanger',
	'esx_skin'
}