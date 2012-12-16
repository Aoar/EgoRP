
-- Data Header
local Data = {}
local META = {}

function META:__index(k)
	return rawget(self,k)
end

function META:GetTable()
	return Data
end

function META:__newindex(k,v)
	RP.SetData(k,v)
end

RPD = setmetatable({}, META)

if !file.Exists("literp/serverdata.txt") then
	file.Write("literp/serverdata.txt", glon.encode(Data or {}))
end

if !file.Exists("literp/classes.txt") then
	file.Write("literp/classes.txt", glon.encode(RP.Teams or {}))
else
	RP.Teams = table.Copy(glon.decode(file.Read("literp/classes.txt")))
end

-- Writer Functions
function RP.SetData(info, val)
	Data[info]=val
	file.Write("literp/serverdata.txt", glon.encode(Data or {}))
end

function RP.GetData(info)
	if !Data[info] then
		Data = glon.decode(file.Read("literp/serverdata.txt"))
	end
	
	return Data[info]
end

function RP.SaveMoney(pl)
	local uid = pl:UniqueID()
	local money = pl:GetMoney()
	file.Write("literp/money/"..uid..".txt", money)
end

function RP.ReadMoney(pl)
	local uid = pl:UniqueID()
	local money = file.Read("literp/money/"..uid..".txt")
	pl:SetMoney(money, true)
end

function RP.LoadPlayerInfo(pl)
	local uid = pl:UniqueID()
	
	if !file.Exists("literp/money/"..uid..".txt") then
		RP.InitMoney(pl)
	else
		RP.ReadMoney(pl)
	end
	
	pl.OwnedDoors = 0
	pl.OwnedCars = 0
end

function RP.InitMoney(pl)
	pl:SetMoney(RPD.InitialMoney)
end

function RP.AddClass(name, color, model, loadout, hp, armor, short, max, wage, teamreq, desc)
	local tempteam = {
		name = name,
		color = color,
		model = model,
		loadout = loadout,
		hp = hp,
		armor = armor,
		short = short,
		max = max,
		wage = wage,
		teamreq = teamreq,
		desc = desc
	}
	RP.Teams[short] = table.Copy(tempteam)
	file.Write("literp/classes.txt", glon.encode(RP.Teams))
	RP.Print("Team "..short.." ("..name..") Added.")
end

RP.InitializeData() -- Unthreaded writers have to keep going.