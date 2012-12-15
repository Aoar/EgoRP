
include("shared.lua")
include("player.lua")
include("sv_propprotection.lua")
include("sv_chat.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_propprotection.lua")
AddCSLuaFile("cl_chat.lua")

AddCSLuaFile( "scoreboard/admin_buttons.lua" )
AddCSLuaFile( "scoreboard/player_frame.lua" )
AddCSLuaFile( "scoreboard/player_infocard.lua" )
AddCSLuaFile( "scoreboard/player_row.lua" )
AddCSLuaFile( "scoreboard/scoreboard.lua" )
AddCSLuaFile( "scoreboard/vote_button.lua" )

AddCSLuaFile( "cl_scoreboard.lua" )

RunConsoleCommand("physgun_limited", "1")
RunConsoleCommand("sbox_godmode", "0")
RunConsoleCommand("sbox_plpldamage", "0")