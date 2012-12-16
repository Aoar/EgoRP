function GM:PlayerNoClip(pl)
	return(pl:IsSuperAdmin())
end

function GM:PlayerInitialSpawn(pl)
	pl.Class = RPD.DefaultClass or "citizen"
	if RP.JailedPlayers[pl:UniqueID()] then pl:ArrestPlayer(RPD.ArrestTime*3) end
end

-- LocalPlayer not existing on InitialSpawn is retarded...
concommand.Add("rp_playerinitnetworking", function(pl) hook.Call("PlayerInitNetworking", GAMEMODE, pl) end)

function GM:PlayerInitNetworking(pl)
	RP.LoadPlayerInfo(pl)
	RP.SendClasses(pl)
end

function GM:PlayerSpawn(pl)
	pl:UnSpectate()
	self:SetPlayerSpeed(pl, 250, 500)
	pl:SetHealth(RP.Teams[pl.Class].hp)
	pl:SetArmor(RP.Teams[pl.Class].armor)
	hook.Call( "PlayerLoadout", GAMEMODE, pl )
	hook.Call( "PlayerSetModel", GAMEMODE, pl )
end

function GM:PlayerLoadout(pl)
	local index = pl.Class
	for k,v in pairs(CitizenLoadout) do
		pl:Give(v)
	end
	for k,v in pairs(RP.Teams[index].loadout) do
		pl:Give(v)
	end
end

function GM:PlayerSetModel(pl)
	local index = pl.Class
	if (RP.Teams[index].model == "usersel") then -- Copy Paste from Base Gamemode
		local cl_playermodel = pl:GetInfo( "cl_playermodel" )
		local modelname = player_manager.TranslatePlayerModel( cl_playermodel )
		pl:SetModel( modelname )
	else
		pl:SetModel(tostring(RP.Teams[index].model[math.random(#RP.Teams[index].model)]))
	end
end

function GM:PlayerDisconnected(ply)
	if( ValidEntity( ply ) ) then

		RP.SaveMoney(ply)
		
		for k, v in pairs( ents.GetAll() ) do
			if( ValidEntity( v ) && v.Owner && v.Owner == ply ) then
				v:Remove()
			end
		end
	end
end