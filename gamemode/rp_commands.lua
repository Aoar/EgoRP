
concommand.Add("rp_class", function(pl,cmd,args)
	if tostring(args[1]) ~= nil and RP.Teams[tostring(args[1])] then
		pl:JoinClass(tostring(args[1]))
	end
end)

concommand.Add("rp_setdata", function(pl,cmd,args)
	if !pl:IsAdmin() then
		Notify(pl, 1, 4, "What are you trying to do..?")
	elseif args[1] and args[2] then
		RP.SetData(tostring(args[1]),args[2])
	end
end)

concommand.Add("rp_unown", function(pl,cmd,args)
	if !pl:IsAdmin() then
		Notify(pl, 1, 4, "What are you trying to do..?")
	else
		local ent = pl:GetEyeTrace().Entity
		if ent:IsOwnable() and ent:RPGetOwner() then
			ent:RPRemoveOwner()
		end
	end
end)

concommand.Add("rp_addjail", function(pl,cmd,args)
	if !pl:IsAdmin() then
		Notify(pl, 1, 4, "What are you trying to do..?")
	else
		RP.AddJail(pl:GetPos()+Vector(0,0,5))
	end
end)

concommand.Add("rp_resetjail", function(pl,cmd,args)
	if !pl:IsAdmin() then
		Notify(pl, 1, 4, "What are you trying to do..?")
	else
		RP.ResetJails(pl:GetPos()+Vector(0,0,5))
		Notify(pl, 1, 4, "All jail positions have been reset and one has been added at your current position!")
	end
end)

concommand.Add("rp_owncar", function(pl,cmd,args)
	if !pl:IsAdmin() then
		Notify(pl, 1, 4, "What are you trying to do..?")
	else
		local ent = pl:GetEyeTrace().Entity
		if ent:IsCar() and !ent:RPGetOwner() then
			ent:BuyCar(pl)
		end
	end
end)

concommand.Add("rp_getowner", function(pl,cmd,args)
	if !pl:IsAdmin() then
		Notify(pl, 1, 4, "What are you trying to do..?")
	else
		local ent = pl:GetEyeTrace().Entity
		print(ent:RPGetOwner())
	end
end)

concommand.Add("rp_owndoor", function(pl,cmd,args)
	if !pl:IsAdmin() then
		Notify(pl, 1, 4, "What are you trying to do..?")
	else
		local ent = pl:GetEyeTrace().Entity
		if ent:IsDoor() and !ent:RPGetOwner() then
			ent:BuyDoor(pl)
		end
	end
end)