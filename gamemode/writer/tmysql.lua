
require("tmysql") -- Load our module

local mysql_host = "81.19.212.130" -- MySQL IP
local mysql_port = 3306 -- MySQL Port. Default is 3306, if you don't know this value you should leave it at default.
local mysql_user = "EgoRPdev" -- Your MySQL username provided by your host.
local mysql_pass = "EgoRPdev" -- Your MySQL password provided by your host.
local mysql_dbnm = "EgoRP" -- Your MySQL database name provded by your host.

tmysql.initialize(mysql_host, mysql_user, mysql_pass, mysql_dbnm, mysql_port) -- Open the MySQL Connection

-- Data Header
local Data = {}
local RawData = {}
local Money = {}
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

tmysql.query("CREATE TABLE IF NOT EXISTS `EgoRP_data` (`data` VARCHAR(255), `value` TEXT, PRIMARY KEY (`data`))")
tmysql.query("CREATE TABLE IF NOT EXISTS `EgoRP_classes`(`class` VARCHAR(255), `data` TEXT, PRIMARY KEY (`class`))")
tmysql.query("CREATE TABLE IF NOT EXISTS `EgoRP_money`(`steamid` VARCHAR(255), `money` INT, PRIMARY KEY (`steamid`))")

tmysql.query("SELECT * FROM `EgoRP_data`", function(data, status, error)
	for k, v in pairs(data) do
		Data[tostring(v[1])] = tostring(v[2])
	end
	
	RP.InitializeData()
end)

tmysql.query("SELECT * FROM `EgoRP_classes`", function(data)
	for k, v in pairs(data) do
		RP.Teams[tostring(v[1])] = glon.decode(v[2])
	end
end)

-- Writer Functions
function RP.SetData(info, val)
	Data[info] = val
	tmysql.query(string.format("REPLACE INTO `EgoRP_data` ( `data`, `value` ) VALUES ( '%s', '%s' )", tmysql.escape(tostring(info)), tmysql.escape(tostring(val))))
end

function RP.GetData(info)
	return Data[info]
end

function RP.SaveMoney(pl)
	tmysql.query(string.format("REPLACE INTO `EgoRP_money` ( `steamid`, `money` ) VALUES ( '%s', '%s' )", tostring(pl:SteamID()), tonumber(pl:GetMoney())))
end

function RP.ReadMoney(pl)
	tmysql.query("SELECT `money` FROM `EgoRP_money` WHERE `steamid`='"..pl:SteamID().."'", function(data)
		pl:SetMoney(money, true)
	end)
end

function RP.LoadPlayerInfo(pl)
	tmysql.query("SELECT `money` FROM `EgoRP_money` WHERE `steamid`='"..pl:SteamID().."'", function(data)
		if data and data[1] then
			pl:SetMoney(tonumber(data[1][1]), true)
		else
			pl:SetMoney(RPD.InitialMoney)
		end
	end)
	
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
	tmysql.query("REPLACE INTO `EgoRP_classes` ( `class`, `data` ) VALUES ( '"..short.."', '"..glon.encode(tempteam).."' )")
	RP.Print("Team "..short.." ("..name..") Added.")
end