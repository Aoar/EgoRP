
local DataSaveMethod = "text"
local JailPositions = {}

RP.Teams = {}

local function InitSaveMethod()
	include("writer/"..DataSaveMethod..".lua")
	RP.Print("DataSaveMethod set as "..DataSaveMethod..".", true)
end

function RP.InitJails()
	local map = string.lower(game.GetMap())
	JailPositions = table.Copy(glon.decode(RPD['Jails_'..map]))
end

function RP.InitializeData()
	RP.LoadDataFiles()
	
	if RPD.DataInitialized == nil then
		RP.FirstInitializeData()
	end
	
	RP.InitJails()
end

InitSaveMethod()

function RP.InitClasses()

end

function RP.SendClasses(pl)
	umsg.Start("RP_DefaultClass", pl)
		umsg.String(RPD.DefaultClass)
	umsg.End()
	
	for k, v in pairs(RP.Teams) do
		RP.SendClass(pl, k)
	end
end

-- Thank you OverV for making a badass simple unlimited usmg wrapper.
function RP.SendClass(pl, index)
	umsg.ExtStart("RP_CreateClass", pl)
		umsg.ExtString(index)
		umsg.ExtString(glon.encode(RP.Teams[index]))
	umsg.ExtEnd()
end

function RP.PayDay()
	for k,v in pairs(player.GetAll()) do
		v:DoPayDay()
	end
end

function RP.NumClass(index)
	local num = 0
	
	for k,v in pairs(player.GetAll()) do
		if v.Class == index then
			num = num+1
		end
	end
	
	return num
end

function RP.TeamJoinable(index)
	if (RP.Teams[index].max == -2 and RP.NumClass(index) > 0) or (RP.Teams[index].max > 0 and (RP.NumClass(index) > #player.GetAll()/5/RP.Teams[index].max)) then
		return false
	else
		return true
	end
end

function RP.UnarrestPlayer(pardon, self)
	if timer.IsTimer(self:UserID().."Arrest") then timer.Destroy(self:UserID().."Arrest") end
	
	if pardon then
		for k,v in pairs(self.JailWeps) do
			self:GiveWeapon(v)
		end
	else
		self:Spawn()
		self.JailWeps = nil
	end
	
	self.Arrested = false
	RP.JailedPlayers[self:UniqueID()] = nil
	
	RP.Print(self:Nick().." was Unarrested.")
end

function RP.PlayerJoinable(self)
	-- Todo: Blacklisting Players
	return self:IsValid()
end

function RP.GetJailPos()
	if JailPositions then
		local jailpos = math.random(#JailPositions)
		return Vector(JailPositions[jailpos][1], JailPositions[jailpos][2], JailPositions[jailpos][3])
	else
		return nil
	end
end

function RP.AddJail(vec)
	local map = string.lower(game.GetMap())
	local temptable = {}
	
	if JailPositions then
		temptable = table.Copy(JailPositions)
	else
		temptable = {}
	end
	
	table.insert(temptable, {vec.x, vec.y, vec.z})
	RP.SetData("Jails_"..map, glon.encode(temptable))
	JailPositions = table.Copy(temptable)
	RP.Print("Jail at ("..vec.x..", "..vec.y..", "..vec.z..") was added.", true)
end
	
function RP.ResetJails(vec)
	local map = string.lower(game.GetMap())
	local temptable = {}
	table.insert(temptable, {vec.x, vec.y, vec.z})
	RP.SetData("Jails_"..map, glon.encode(temptable))
	JailPositions = table.Copy(temptable)
	RP.Print("All Jails have been removed.", true)
	RP.Print("Jail at ("..vec.x..", "..vec.y..", "..vec.z..") was added.", true)
end

function RP.SendMoney(ply, silent, msg)
	umsg.Start("RP_PlayerMoneyUpdate", ply)
		umsg.Long(ply.Money)
		umsg.Bool(silent or false)
		if msg then
			umsg.String(msg)
		end
	umsg.End()
end

function RP.InitClasses(ply)
	for k,v in pairs(player.GetAll()) do
		if v.Class != RPD.DefaultClass then
			umsg.Start("RP_PlayerInitClass", ply)
				umsg.Entity(v)
				umsg.String(v.Class)
			umsg.End()
		end
	end
end

function Notify(ply, msgtype, len, msg)
	if not ValidEntity(ply) then return end
	
	umsg.Start("_Notify", ply)
		umsg.String(msg)
		umsg.Short(msgtype)
		umsg.Long(len)
	umsg.End()
end

function NotifyAll(msgtype, len, msg)
	for k, v in pairs(player.GetAll()) do
		Notify(v, msgtype, len, msg)
	end
end