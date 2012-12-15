require("mysqloo") -- Load our module

local mysql_host = "81.19.212.130" -- MySQL IP
local mysql_port = 3306 -- MySQL Port. Default is 3306, if you don't know this value you should leave it at default.
local mysql_user = "literpdev" -- Your MySQL username provided by your host.
local mysql_pass = "literpdev" -- Your MySQL password provided by your host.
local mysql_dbnm = "literp" -- Your MySQL database name provded by your host.

local db = nil

db = mysqloo.connect(mysql_host, mysql_user, mysql_pass, mysql_dbnm, mysql_port)

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

db.onConnected = function()
	local tbld = db:query("CREATE TABLE IF NOT EXISTS `literp_data` (`data` VARCHAR(255), `value` TEXT, PRIMARY KEY (`data`))")
	local tblc = db:query("CREATE TABLE IF NOT EXISTS `literp_classes`(`class` VARCHAR(255), `data` TEXT, PRIMARY KEY (`class`))")
	local tblm = db:query("CREATE TABLE IF NOT EXISTS `literp_money`(`steamid` VARCHAR(255), `money` INT, PRIMARY KEY (`steamid`))")
	tbld:start()
	tblc:start()
	tblm:start()

	local dbdata = db:query("SELECT * FROM `literp_data`")
	dbdata.onData = function(q, d) Data[tostring(d['data'])] = tostring(d['value']) end
	dbdata.onSuccess = RP.InitializeData
	dbdata:start()
	
	local dbclasses = db:query("SELECT * FROM `literp_classes`")
	dbclasses.onData = function(q, d) RP.Teams[tostring(d['class'])] = glon.decode(d['data']) end
	dbclasses.onSuccess = RP.InitClasses
	dbclasses:start()
end
db:connect()

-- Writer Functions
function RP.SetData(info, val)
	Data[info] = val
	local updata = db:query(string.format("REPLACE INTO `literp_data` ( `data`, `value` ) VALUES ( '%s', '%s' )", db:escape(tostring(info)), db:escape(tostring(val))))
	updata:start()
end

function RP.GetData(info)
	return Data[info]
end

function RP.SaveMoney(pl)
	local upmoney = db:query(string.format("REPLACE INTO `literp_money` ( `steamid`, `money` ) VALUES ( '%s', '%s' )", tostring(pl:SteamID()), tonumber(pl:GetMoney())))
	upmoney:start()
end

function RP.ReadMoney(pl)
	local getmoney = db:query("SELECT `money` FROM `literp_money` WHERE `steamid`='"..pl:SteamID().."'")
	getmoney.onData = function(q, d)
		if d and d['money'] then
			pl:SetMoney(tonumber(d['money']), true)
		else
			pl:SetMoney(RPD.InitialMoney)
		end
	end
	getmoney:start()
end

function RP.LoadPlayerInfo(pl)
	local getminfo = db:query("SELECT `money` FROM `literp_money` WHERE `steamid`='"..pl:SteamID().."'")
	getminfo.onData = function(q, d)
		if d and d['money'] then
			pl:SetMoney(tonumber(d['money']), true)
		end
	end
	getminfo.onSuccess = function()
		if !pl.Money then
			pl:SetMoney(RPD.InitialMoney)
		end
	end
	getminfo:start()
	
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
	local upclass = db:query("REPLACE INTO `literp_classes` ( `class`, `data` ) VALUES ( '"..short.."', '"..glon.encode(tempteam).."' )")
	upclass:start()
	RP.Print("Team "..short.." ("..name..") Added.")
end