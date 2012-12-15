
-- Data Header
local Data = {}
local META = {}

function META:__index(k)
	return RP.GetData(k) or rawget(self,k)
end

function META:GetTable()
	return Data
end

function META:__newindex(k,v)
	RP.SetData(k,v)
end

RPD = setmetatable({}, META)

sql.Query("CREATE TABLE IF NOT EXISTS literp_data ( data TEXT NOT NULL PRIMARY KEY, value TEXT )")
sql.Query("CREATE TABLE IF NOT EXISTS literp_classes( class TEXT NOT NULL PRIMARY KEY, data TEXT )")

local classtbl = sql.Query("SELECT * FROM literp_classes") or {}
for k, v in pairs(classtbl) do
	RP.Teams[tostring(k)] = glon.decode(v)
end

-- Writer Functions
function RP.SetData(info, val)
	Data[info]=val
	sql.Query(string.format("REPLACE INTO literp_data ( data, value ) VALUES ( %s, %s )", SQLStr(info), SQLStr(val)))
end

function RP.GetData(info)
	if !Data[info] then
		Data[info] = sql.QueryValue("SELECT value FROM literp_data WHERE data = "..SQLStr(info).."")
	end
	
	return Data[info]
end

function RP.SaveMoney(pl)
	pl:SetPData("money", pl:GetMoney())
end

function RP.ReadMoney(pl)
	local money = pl:GetPData("money")
	pl:SetMoney(money, true)
end

function RP.LoadPlayerInfo(pl)
	local money = pl:GetPData("money")
	
	if !money then
		RP.InitMoney(pl)
	else
		pl:SetMoney(money, true)
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
	RP.Teams[short] = tempteam
	sql.Query("REPLACE INTO literp_classes ( class, data ) VALUES ( "..SQLStr(short)..", "..SQLStr(glon.encode(tempteam)).." )")
	RP.Print("Team "..short.." ("..name..") Added.")
end

RP.InitializeData() -- Unthreaded writers have to keep going.