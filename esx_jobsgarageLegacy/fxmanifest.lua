fx_version 'cerulean'
game 'gta5'

description 'Job Garage with ox_lib and okokNotify'
author 'pika80'
version '1.0.0'

shared_script '@ox_lib/init.lua'
shared_script 'config.lua'

client_scripts {
    'client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua', -- caso uses MySQL
    'server.lua'
}

