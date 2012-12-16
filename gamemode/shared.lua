
RP = {}

-- This is just incase code errors are made.
TEAM_CITIZEN = 1
team.SetUp(TEAM_CITIZEN, "Citizen", Color(0, 160, 255))

include("rp_config.lua")

-- If you change the name things will break, change the Subversion instead.
-- Please make sure you leave the authors intact, we've all spent hours making this gamemode work.

GM.Name = "EgoRP"
GM.Version = "0.0.1"
GM.Author = "Original: Sadistic Slayer, Miss Pink, Pcwizdan, EgoRP: Aoar, Zero"
GM.Email = ""
GM.Website = ""
GM.Subversion = ""
DeriveGamemode("sandbox")

-- Precache Playermodels
util.PrecacheModel("models/player/alyx.mdl")
util.PrecacheModel("models/player/barney.mdl")
util.PrecacheModel("models/player/breen.mdl")
util.PrecacheModel("models/player/combine_soldier.mdl")
util.PrecacheModel("models/player/combine_soldier_prisonguard.mdl")
util.PrecacheModel("models/player/combine_super_soldier.mdl")
util.PrecacheModel("models/player/eli.mdl")
util.PrecacheModel("models/player/gman_high.mdl")
util.PrecacheModel("models/player/Kleiner.mdl")
util.PrecacheModel("models/player/monk.mdl")
util.PrecacheModel("models/player/mossman.mdl")
util.PrecacheModel("models/player/odessa.mdl")
util.PrecacheModel("models/player/police.mdl")
util.PrecacheModel("models/player/classic.mdl")
util.PrecacheModel("models/player/corpse1.mdl")
util.PrecacheModel("models/player/charple01.mdl")
util.PrecacheModel("models/player/soldier_stripped.mdl")
util.PrecacheModel("models/player/Zombiefast.mdl")
util.PrecacheModel("models/player/Group01/female_01.mdl")
util.PrecacheModel("models/player/Group01/female_02.mdl")
util.PrecacheModel("models/player/Group01/female_03.mdl")
util.PrecacheModel("models/player/Group01/female_04.mdl")
util.PrecacheModel("models/player/Group01/female_06.mdl")
util.PrecacheModel("models/player/Group01/female_07.mdl")
util.PrecacheModel("models/player/Group03/female_01.mdl")
util.PrecacheModel("models/player/Group03/female_02.mdl")
util.PrecacheModel("models/player/Group03/female_03.mdl")
util.PrecacheModel("models/player/Group03/female_04.mdl")
util.PrecacheModel("models/player/Group03/female_06.mdl")
util.PrecacheModel("models/player/Group03/female_07.mdl")
util.PrecacheModel("models/player/Group01/male_01.mdl")
util.PrecacheModel("models/player/Group01/male_02.mdl")
util.PrecacheModel("models/player/Group01/male_03.mdl")
util.PrecacheModel("models/player/Group01/male_04.mdl")
util.PrecacheModel("models/player/Group01/male_05.mdl")
util.PrecacheModel("models/player/Group01/male_06.mdl")
util.PrecacheModel("models/player/Group01/male_07.mdl")
util.PrecacheModel("models/player/Group01/male_08.mdl")
util.PrecacheModel("models/player/Group01/male_09.mdl")
util.PrecacheModel("models/player/Group03/male_01.mdl")
util.PrecacheModel("models/player/Group03/male_02.mdl")
util.PrecacheModel("models/player/Group03/male_03.mdl")
util.PrecacheModel("models/player/Group03/male_04.mdl")
util.PrecacheModel("models/player/Group03/male_05.mdl")
util.PrecacheModel("models/player/Group03/male_06.mdl")
util.PrecacheModel("models/player/Group03/male_07.mdl")
util.PrecacheModel("models/player/Group03/male_08.mdl")
util.PrecacheModel("models/player/Group03/male_09.mdl")
util.PrecacheModel("models/player/zombie_soldier.mdl")
util.PrecacheModel("models/player/arctic.mdl")
util.PrecacheModel("models/player/guerilla.mdl")
util.PrecacheModel("models/player/riot.mdl")
util.PrecacheModel("models/player/police.mdl")
util.PrecacheModel("models/player/swat.mdl")
util.PrecacheModel("models/player/leet.mdl")
util.PrecacheModel("models/player/gasmask.mdl")
util.PrecacheModel("models/player/Hostage/Hostage_01.mdl")
util.PrecacheModel("models/player/Hostage/Hostage_02.mdl")
util.PrecacheModel("models/player/Hostage/hostage_03.mdl")
util.PrecacheModel("models/player/Hostage/hostage_04.mdl")
util.PrecacheModel("models/player/Phoenix.mdl")
util.PrecacheModel("models/player/urban.mdl")

function playerSetSpeed(ply)
 
	GAMEMODE:SetPlayerSpeed(ply, 250, 500)
	-- Editing these values will change the walk and sprint speed
	-- "(ply, walk speed, sprint speed)"
end

-- Thanks JetBoom
function GM:Move(pl, move)
	local speed = move:GetForwardSpeed()
	local sidespeed = move:GetSideSpeed()
	
	if speed < 0 and speed - math.abs(sidespeed) < -130 then
		move:SetForwardSpeed(speed * 0.666)
		move:SetSideSpeed(sidespeed * 0.666)
	end
end

function GM:GetGameDescription()
	--return self.Name.." v"..string.format("%.2f", self.Version).."("..string.format("%.2f", self.Subversion)..")"
	return "Cool Gamemode Bro!"
end
