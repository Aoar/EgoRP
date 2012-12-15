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

/*function meta:RPGetOwner()
	if (!IsValid(self:GetDTEntity(0))) then
		return nil
	else
		return self:GetDTEntity(0)
	end
end*/

function meta:RPGetOwner()
	if( IsValid( self ) ) then
		return self:GetDTEntity(0)
	end
end