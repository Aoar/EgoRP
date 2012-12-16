
RP.JailedPlayers = {}

local meta = FindMetaTable("Player")

function meta:SetMoney(money, silent, msg)
	self.Money = tonumber(money)
	RP.SendMoney(self, silent, msg)
	RP.SaveMoney(self)
end

function meta:GetMoney()
	return self.Money
end

function meta:AddMoney(money, silent, msg)
	local amount = self:GetMoney() + money
	self:SetMoney(amount, silent, msg)
end

function meta:TakeMoney(money, slient)
	local ammount = self:GetMoney() - money
	self:SetMoney(ammount, slient)
end

function meta:JoinClass(index)
	if self.Class == index then Notify(self, 1, 4, "You are currently on this team!") return end
	
	local changeto = RP.Teams[index]
	local previndex = self.Class
	if RP.Teams[index] and (RP.Teams[index].teamreq == -1 or RP.Teams[index].teamreq == previndex) and RP.TeamJoinable(index) and RP.PlayerJoinable(self) then
		self:ClassLoadout(previndex, index)
		umsg.Start("RP_PlayerJoinClass", 0)
			umsg.Entity(self)
			umsg.String(index)
		umsg.End()
		self.Class = index
	end
end

function meta:ClassLoadout(previndex, index)
	self:StripAmmo()
	self:SetArmor(RP.Teams[index].armor)
	for k, v in pairs(RP.Teams[previndex].loadout) do
		self:StripWeapon(v)
	end
	for k, v in pairs(RP.Teams[index].loadout) do
		self:Give(v)
	end
	for k,v in pairs(CitizenLoadout) do
		self:Give(v)
	end
	if (RP.Teams[index].model == "usersel") then
		local cl_playermodel = self:GetInfo( "cl_playermodel" )
		local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
		self:SetModel( modelname )
	else
		self:SetModel(tostring(RP.Teams[index].model[math.random(#RP.Teams[index].model)]))
	end
end

function meta:ArrestPlayer(time)
	timer.Create(self:UserID().."Arrest", RPD.ArrestTime, 1, self.UnarrestPlayer, self)
	self:SetPos(RP.GetJailPos() or self:GetPos())
	self.JailWeps = self:GetWeapons()
	self:StripWeapons()
	self.Arrested = true
	RP.JailedPlayers[self:UniqueID()] = 1
end

function meta:UnarrestPlayer(pardon)
	if not self then return end
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
end

function meta:DoPayDay()
	self:AddMoney(tonumber(RP.Teams[self.Class].wage), false, "for being a "..RP.Teams[self.Class].name.."!")
end

timer.Exists("PayDayTimer", 60, 0, function() RP.PayDay() end)