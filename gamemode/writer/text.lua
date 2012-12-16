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

if !file.Exists( "literp/serverdata.txt", "GAME" ) then
	file.Write("literp/serverdata.txt", util.TableToJSON(Data or {}))
end

if !file.Exists("literp/classes.txt", "GAME") then
	file.Write("literp/classes.txt", util.TableToJSON(RP.Teams or {}))
else
	RP.Teams = table.Copy(util.JSONToTable(file.Read( "literp/classes.txt", "GAME" )))
end

-- Writer Functions
function RP.SetData(info, val)
	Data[info]=val
	file.Write("literp/serverdata.txt", util.TableToJSON(Data or {}))
end

function RP.GetData(info)
	if !Data[info] then
		Data = util.JSONToTable(file.Read( "literp/serverdata.txt", "GAME" ))
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
	
	if !file.Exists("literp/money/"..uid..".txt", "GAME") then
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
	file.Write("literp/classes.txt", util.TableToJSON(RP.Teams))
	RP.Print("Team "..short.." ("..name..") Added.")
end

RP.InitializeData() -- Unthreaded writers have to keep going.