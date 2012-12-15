usermessage.Hook("RP_PlayerMoneyUpdate", function(umsg)
	local money = umsg:ReadLong()
	local silent = umsg:ReadBool()
	local msg = umsg:ReadString()
	local newmoney = money-(LocalPlayer().Money or money)
	
	LocalPlayer().Money = money
	
	if !silent then
		if newmoney > 0 then
			if !msg then
				GAMEMODE:AddNotify("You have recieved $"..newmoney.."!", 0, 4)
			else
				GAMEMODE:AddNotify("You have recieved $"..newmoney.." "..msg, 0, 4)
			end
		else
			if !msg then
				GAMEMODE:AddNotify("You have spent $"..math.abs(newmoney)..".", 0, 4)
			else
				GAMEMODE:AddNotify("You have spent $"..math.abs(newmoney).." "..msg, 0, 4)
			end
		end
	end
end)

usermessage.Hook("RP_PlayerJoinClass", function(umsg)
	local ply = umsg:ReadEntity()
	local class = umsg:ReadString()
	
	if LocalPlayer() == ply then
		LocalPlayer().Class = class
		GAMEMODE:AddNotify("You have become a "..RP.Teams[class].name.."!", 0, 4)
	else
		ply.Class = class
		GAMEMODE:AddNotify(ply:Nick().." has became a "..RP.Teams[class].name..".", 0, 4)
	end
end)

usermessage.Hook("RP_PlayerInitClass", function(umsg)
	local ply = umsg:ReadEntity()
	local class = umsg:ReadString()
	ply.Class = class
end)

usermessage.Hook("RP_DefaultClass", function(umsg)
	local class = umsg:ReadString()
	
	for k, v in pairs(player.GetAll()) do
		v.Class = class
	end
end)

usermessage.Hook("RP_CreateClass", function(umsg)
	local index = umsg:ExtReadString()
	local temptable = glon.decode(umsg:ExtReadString())
	RP.Teams[index] = table.Copy(temptable)
	print("RP Team: "..index.." ("..RP.Teams[index].name..") Initialized.")
end)
