-- Make some modular config loader shit
RP.DebugPrints = true

function RP.Print(txt, bypass)
	if !txt then return end
	
	if bypass then
		print("[LiteRP] "..txt)
	elseif RP.DebugPrints then
		print("[LiteRP] "..txt)
	end
end

function RP.LoadBaseFiles()
	if (SERVER) then
		include("sv_ext_umsg.lua")
		include("rp_util.lua")
		include("rp_util_player.lua")
		include("rp_util_entities.lua")
		include("rp_commands.lua")
		AddCSLuaFile("cl_ext_umsg.lua")
		AddCSLuaFile("rpcl_util.lua")
		AddCSLuaFile("rpcl_util_entities.lua")
		AddCSLuaFile("rpcl_util_player.lua")
		AddCSLuaFile("rpcl_networking.lua")
		AddCSLuaFile("rp_config.lua")
	else
		include("rpcl_util.lua")
		include("rpcl_util_entities.lua")
		include("rpcl_util_player.lua")
		include("rpcl_networking.lua")
	end
end

function RP.LoadConfigFiles()
	if (SERVER) then
		AddCSLuaFile("config/teams.lua")
	end
	
	include("config/teams.lua")
end

function RP.LoadDataFiles()
	if (SERVER) then
		include("literp/gamemode/data/settings.lua")
	end
end

RP.LoadBaseFiles()
RP.LoadConfigFiles()