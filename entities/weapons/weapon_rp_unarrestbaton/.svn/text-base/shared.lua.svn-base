-- I found this swep on Garrysmod.org, thanks go to -[SB]- Spy.

if SERVER then
	AddCSLuaFile("shared.lua")
	SWEP.HoldType = "melee"
end

if CLIENT then
	SWEP.PrintName = "Unarrest Baton"
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author 		= "Sadistic Slayer"
SWEP.Instructions 	= "Left or Right Click to Unarrest player."
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 55
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel 			= Model("models/weapons/v_stunstick.mdl")
SWEP.WorldModel			= Model("models/weapons/w_stunbaton.mdl")

SWEP.Primary.Recoil			= 0
SWEP.Primary.Damage			= 0
SWEP.Primary.NumShots		= 1
SWEP.Primary.Cone			= 0
SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic   	= false	
SWEP.Primary.Ammo         	= "none"

SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "none"

SWEP.Delay					= 0.35

function SWEP:Initialize()
	if( SERVER ) then
		self:SetWeaponHoldType( self.HoldType )
	end
end

function SWEP:Precache()
end

function SWEP:Think()
end 

function SWEP:Deploy()
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire(CurTime() + 0.7)
	self:SetNextSecondaryFire(CurTime() + 0.7)
	self.Weapon:EmitSound("weapons/stunstick/spark"..math.random(1, 3)..".wav")
	return true
end

function SWEP:Holster()
	return true
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	self.Weapon:EmitSound("weapons/stunstick/stunstick_swing"..math.random(1, 2)..".wav")
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Delay)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
	
	if (SERVER) then
		local trace = self.Owner:GetEyeTrace()
		if self.Owner:EyePos():Distance(trace.HitPos) > 95 then return end
	
		local ent = trace.Entity
		if ent and ent:IsPlayer() then
			ent:UnarrestPlayer()
		end
	end
end 

function SWEP:SecondaryAttack()
	self.Weapon:PrimaryAttack()
end
