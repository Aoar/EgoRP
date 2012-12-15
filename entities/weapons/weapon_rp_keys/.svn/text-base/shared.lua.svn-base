if SERVER then
	AddCSLuaFile("shared.lua")
end

if CLIENT then
	SWEP.PrintName = "Keys"
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
end

SWEP.Author = "Sadistic Slayer"
SWEP.Instructions = "Left click to lock.\nRight click to unlock.\nReload to Buy/Sell."
SWEP.Contact = ""
SWEP.Purpose = ""

SWEP.ViewModel      = "models/weapons/v_hands.mdl"

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"

SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.Sound = "doors/door_latch3.wav"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

if CLIENT then
	SWEP.FrameVisible = false
end

function SWEP:Initialize()
	self:SetWeaponHoldType("normal")
end

function SWEP:Deploy()
	if (SERVER) then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
end

function SWEP:PrimaryAttack()
	if CLIENT then return end

	self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)
	
	local ent = self.Owner:GetEyeTrace().Entity
	
	if not ent or not ent:IsValid() then return end
	if self.Owner:EyePos():Distance(ent:GetPos()) > 100 then return end
	
	if( !ent:IsDoor() && !ent:IsCar() ) then return end
	
	if ent and (ent:RPGetOwner() == self.Owner) then
		ent:Fire("lock", "", 0)
		self.Owner:EmitSound(self.Sound)
		self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)
	elseif ent and ent:IsDoor() then
		Notify(self.Owner, 1, 3, "You don't own this door.")
	elseif ent and ent:IsCar() then
		Notify(self.Owner, 1, 3, "You don't own this car.")
	end
end

function SWEP:SecondaryAttack()
	if CLIENT then return end

	self.Weapon:SetNextPrimaryFire(CurTime() + 0.3)
	self.Weapon:SetNextSecondaryFire(CurTime() + 0.3)
	
	local ent = self.Owner:GetEyeTrace().Entity
	
	if not ent or not ent:IsValid() then return end
	if self.Owner:EyePos():Distance(ent:GetPos()) > 100 then return end
	
	if( !ent:IsDoor() && !ent:IsCar() ) then return end
	
	if ent and (ent:RPGetOwner() == self.Owner) then
		ent:Fire("unlock", "", 0)
		self.Owner:EmitSound(self.Sound)
	elseif ent and ent:IsDoor() then
		Notify(self.Owner, 1, 3, "You don't own this door.")
	elseif ent and ent:IsCar() then
		Notify(self.Owner, 1, 3, "You don't own this car.")
	end
end

function SWEP:Reload()
	if CLIENT then return end
	
	if self.Owner.NextKeyReload and (self.Owner.NextKeyReload > CurTime()) then return end
	
	local ent = self.Owner:GetEyeTrace().Entity
	
	if not ent or not ent:IsValid() then return end
	if self.Owner:EyePos():Distance(ent:GetPos()) > 100 then return end
	
	if( !ent:IsDoor() && !ent:IsCar() ) then return end
	
	if ent:IsDoor() then
		if !ent:RPGetOwner() then
			ent:BuyDoor(self.Owner)
			ent:Fire("unlock", "", 0 )
		elseif ent:RPGetOwner() == self.Owner then
			ent:SellDoor(self.Owner)
			ent:Fire("unlock", "", 0 )
			ent:Fire("close", "", 0 )
		end
		self.Owner.NextKeyReload = CurTime()+2.5
	else
		if !ent:RPGetOwner() then
			ent:BuyCar(self.Owner)
		elseif ent:RPGetOwner() == self.Owner then
			ent:SellCar(self.Owner)
			ent:Fire("lock", "", 0 )
		end
		self.Owner.NextKeyReload = CurTime()+2.5
	end
end
