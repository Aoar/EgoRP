

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "pistol"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "Glock"			
	SWEP.Author				= "Sadistic Slayer"
	SWEP.Slot				= 1
	SWEP.SlotPos			= 4
	SWEP.IconLetter			= "c"
	
	killicon.AddFont( "weapon_rp_glock", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end


SWEP.Base				= "weapon_cs_base2"
SWEP.Category			= "LiteRP"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_pist_glock18.mdl"
SWEP.WorldModel			= "models/weapons/w_pist_glock18.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_Glock.Single" )
SWEP.Primary.Recoil			= 2
SWEP.Primary.Damage			= 10
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.047
SWEP.Primary.ClipSize		= 20
SWEP.Primary.Delay			= 0.05
SWEP.Primary.DefaultClip	= 21
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "pistol"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 		= Vector( 4.3, -2, 2.7 )
