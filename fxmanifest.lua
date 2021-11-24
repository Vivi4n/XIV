fx_version "adamant"
games {"rdr3"}
version '1.0.0'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {
	'client/*.lua',
	'client/cl_notification.js',
}

server_scripts {
	'server/*.lua'
}

server_exports {
	'getPlayerFromId',
	'playerLoaded',
}