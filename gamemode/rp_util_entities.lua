
local meta = FindMetaTable("Entity")

local tblOwnable = {
	"func_door",
	"func_door_rotating",
	"prop_door_rotating",
	"prop_vehicle_jeep",
	"prop_vehicle_airboat"
}
local tblOwnableDoors = {
	"func_door",
	"func_door_rotating",
	"prop_door_rotating",
}
local tblOwnableVehicles = {
	"prop_vehicle_jeep",
	"prop_vehicle_airboat"
}

function meta:IsOwnable()
	local class = self:GetClass()
	for k, v in pairs(tblOwnable) do
		if class == v then
			return true
		end
	end
	return false
end

function meta:IsUnownable()
	-- Todo: Blacklist doors.
end

function meta:IsDoor()
	local class = self:GetClass()
	for k, v in pairs(tblOwnableDoors) do
		if class == v then
			return true
		end
	end
	return false
end

function meta:IsCar()
	local class = self:GetClass()
	for k, v in pairs(tblOwnableVehicles) do
		if class == v then
			return true
		end
	end
	return false
end

function meta:RPGetOwner()
	if( self:IsDoor() || self:IsCar() ) then 
		if( IsValid( self:GetDTEntity(0) ) ) then 
			return self:GetDTEntity(0) 
		else
			return nil
		end
	else
		return self.Owner 
	end
end

function meta:RPRemoveOwner()
	if( self:IsDoor() || self:IsCar() ) then self:SetDTEntity(0, NULL) else self.Owner = nil end
end

function meta:BuyDoor(pl)
	if self:RPGetOwner() then return end
	if self:IsDoor() and !self:IsUnownable() and tonumber(RPD.DoorLimit) > pl.OwnedDoors and tonumber(RPD.DoorCost) < pl:GetMoney() then
		pl.OwnedDoors = pl.OwnedDoors+1
		self:SetDTEntity(0, pl)
		pl:TakeMoney(tonumber(RPD.DoorCost), true)
		Notify(pl, 0, 4, "You bought this door for $"..RPD.DoorCost.."!")
	elseif self:IsDoor() and !self:IsUnownable() and tonumber(RPD.DoorLimit) <= pl.OwnedDoors then
		Notify(pl, 1, 4, "You have reached the door limit..")
	elseif self:IsDoor() and !self:IsUnownable() and tonumber(RPD.DoorCost) >= pl:GetMoney() then
		Notify(pl, 1, 4, "You are too poor to buy this door for $"..RPD.DoorCost.."..")
	end
end

function meta:BuyCar(pl)
	if self:RPGetOwner() then return end
	if self:IsCar() and !self:IsUnownable() and tonumber(RPD.CarLimit) > pl.OwnedCars and tonumber(RPD.CarCost) < pl:GetMoney() then
		pl.OwnedCars = pl.OwnedCars+1
		self:SetDTEntity(0, pl)
		pl:TakeMoney(tonumber(RPD.CarCost), true)
		Notify(pl, 0, 4, "You bought this car for $"..RPD.CarCost.."!")
	elseif self:IsCar() and !self:IsUnownable() and tonumber(RPD.CarLimit) <= pl.OwnedCars then
		Notify(pl, 1, 4, "You have reached the car limit..")
	elseif self:IsCar() and !self:IsUnownable() and tonumber(RPD.CarCost) >= pl:GetMoney() then
		Notify(pl, 1, 4, "You are too poor to buy this car for $"..RPD.CarCost.."..")
	end
end

function meta:SellDoor(pl)
	if self:IsDoor() and self:GetNetworkedEntity("Owner", pl) then
		pl.OwnedDoors = pl.OwnedDoors-1
		self:SetDTEntity(0, NULL)
		pl:AddMoney(math.floor(tonumber(RPD.DoorCost)*0.75), true)
		Notify(pl, 0, 4, "You sold this door for $"..math.floor(tonumber(RPD.DoorCost)*0.75).."!")
	end
end

function meta:SellCar(pl)
	if self:IsCar() and self:GetNetworkedEntity("Owner", pl) then
		pl.OwnedCars = pl.OwnedCars-1
		self:SetDTEntity(0, NULL)
		pl:AddMoney(math.floor(tonumber(RPD.CarCost)*0.75), true)
		Notify(pl, 0, 4, "You sold this door for $"..math.floor(tonumber(RPD.CarCost)*0.75).."!")
	end
end