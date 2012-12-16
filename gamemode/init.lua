GM.Version = "0.0.1"
GM.Name = "EgoRP"
GM.Author = "Original: Sadistic Slayer, Miss Pink, Pcwizdan, EgoRP: Aoar, Zero"

DeriveGamemode("sandbox")

include("shared.lua")
include("player.lua")
include("sv_propprotection.lua")
include("sv_chat.lua")

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_propprotection.lua")
AddCSLuaFile("cl_chat.lua")

RunConsoleCommand("physgun_limited", "1")
RunConsoleCommand("sbox_godmode", "0")
RunConsoleCommand("sbox_plpldamage", "0")