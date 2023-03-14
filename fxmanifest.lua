name "arp-scrapyard"
author "Erebus"
version "v1.0"
description "Scrapyard by Erebus"
fx_version "cerulean"
game "gta5"

dependencies { 'qb-menu', 'qb-target', }

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/EntityZone.lua',
    '@PolyZone/CircleZone.lua',
    '@PolyZone/ComboZone.lua',
	'client/*.lua',
}
server_scripts { 'server/*.lua' }
shared_scripts { 'config.lua', 'shared/*.lua', 'locales/*.lua' }

escrow_ignore {
	'config.lua'
  }

lua54 'yes'