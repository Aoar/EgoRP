

if ( SERVER ) then

	AddCSLuaFile( "shared.lua" )
	
	SWEP.HoldType			= "ar2"
	
end

if ( CLIENT ) then

	SWEP.PrintName			= "M4"			
	SWEP.Author				= "Sadistic Slayer"
	SWEP.Slot				= 3
	SWEP.SlotPos			= 1
	SWEP.IconLetter			= "w"
	
	killicon.AddFont( "weapon_rp_m4", "CSKillIcons", SWEP.IconLetter, Color( 255, 80, 0, 255 ) )
	
end


SWEP.Base				= "weapon_cs_base2"
SWEP.Category			= "LiteRP"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel			= "models/weapons/v_rif_m4a1.mdl"
SWEP.WorldModel			= "models/weapons/w_rif_m4a1.mdl"

SWEP.Weight				= 5
SWEP.AutoSwitchTo		= false
SWEP.AutoSwitchFrom		= false

SWEP.Primary.Sound			= Sound( "Weapon_M4A1.Single" )
SWEP.Primary.Recoil			= 1.25
SWEP.Primary.Damage			= 15
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0.03
SWEP.Primary.ClipSize		= 30
SWEP.Primary.Delay			= 0.086
SWEP.Primary.DefaultClip	= 60
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "smg1"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"

SWEP.IronSightsPos 		= Vector( 6.25, -4, 0.0 )
SWEP.IronSightsAng 		= Vector( 6, 2, 6 )
