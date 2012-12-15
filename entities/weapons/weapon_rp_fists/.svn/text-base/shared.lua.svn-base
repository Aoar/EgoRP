-- I found this swep on Garrysmod.org, thanks go to -[SB]- Spy.

if( SERVER ) then
	AddCSLuaFile( "shared.lua" )
end

if( CLIENT ) then
	SWEP.PrintName = "Fists"
	SWEP.Slot = 2
	SWEP.SlotPos = 0
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = true
end

SWEP.Author			= "Sadistic Slayer"
SWEP.Instructions	= "Left click for a left-hand swing \nRight click for a right-hand swing."
SWEP.Contact		= ""
SWEP.Purpose		= ""

SWEP.ViewModelFOV	= 47 -- Low FOV so we can't see the un-done hand models thanks to Valve.
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true


SWEP.ViewModel      = "models/weapons/v_punch.mdl"

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

if CLIENT then
	SWEP.FrameVisible = false
end

function SWEP:Initialize()
	self:SetWeaponHoldType("fist")
end

function SWEP:Precache()
end

function SWEP:Think()
end 

function SWEP:Deploy()
	if (SERVER) then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
	
	self.Weapon:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire(CurTime() + 0.7)
	self:SetNextSecondaryFire(CurTime() + 0.7)
	return true
end

function SWEP:Holster()
	return true
end

function SWEP:Reload()
end

function SWEP:PrimaryAttack()
	self.Weapon:EmitSound("npc/zombie/claw_miss"..math.random(1, 2)..".wav")
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Delay)
	self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	local trace = self.Owner:GetEyeTrace()
	if self.Owner:EyePos():Distance(trace.HitPos) > 85 then return end
	
	if trace.HitWorld then
		self.Weapon:EmitSound("physics/flesh/flesh_impact_hard"..math.random(1, 6)..".wav")
	end
	
	local ent = trace.Entity
	
	if ent and ent:IsValid() then
		self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random(1, 5) .. ".wav")
		if (SERVER) then
			ent:TakeDamage(10, self.Owner, self.Weapon)
		end
	end
end 

function SWEP:SecondaryAttack()
	self.Weapon:EmitSound("npc/zombie/claw_miss"..math.random(1, 2)..".wav")
	self.Weapon:SetNextPrimaryFire(CurTime() + self.Delay)
	self.Weapon:SetNextSecondaryFire(CurTime() + self.Delay)
	self.Weapon:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	
	local trace = self.Owner:GetEyeTrace()
	if self.Owner:EyePos():Distance(trace.HitPos) > 85 then return end
	
	if trace.HitWorld then
		self.Weapon:EmitSound("physics/flesh/flesh_impact_hard"..math.random(1, 6)..".wav")
	end
	
	local ent = trace.Entity
	
	if ent and ent:IsValid() then
		self.Weapon:EmitSound("physics/flesh/flesh_impact_bullet" .. math.random(1, 5) .. ".wav")
		if (SERVER) then
			ent:TakeDamage(10, self.Owner, self.Weapon)
		end
	end
end
