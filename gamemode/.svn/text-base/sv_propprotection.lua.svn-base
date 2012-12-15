local NoPickupEntities = { "prop_door_rotating", "func_breakable_surf", "func_door", "env_sprite" }
local ExploitableTools = { "wire_winch", "wire_hydraulic", "slider", "hydraulic", "winch", "muscle" }

concommand.Add("rp_pp_resend_um", function( ply )
	for k, v in ipairs( ents.GetAll() ) do
		if( v.Owner && ValidEntity( v.Owner ) && v.Owner:IsPlayer() && !v:IsWeapon() ) then
			umsg.Start("RPOwner", ply )
			umsg.Entity( v )
			umsg.Entity( v.Owner )
			umsg.End()
		end
	end
end )

local function SendBlocked( ply, msg, ignoretime )
	if( !ValidEntity( ply ) ) then return end
	
	msg = msg or "This entity does not belong to you.";
	
	if( ignoretime ) then
		Notify( ply, 1, 2, msg )
		return
	end
	
	if( !ply.LastPhysgunPickup ) then
		ply.LastPhysgunPickup = os.time();
	end
	if( ply.LastPhysgunPickup + 1.5 < os.time() ) then
		Notify( ply, 1, 2, msg );
		ply.LastPhysgunPickup = os.time();
	end
end

local function IsOwner( ply, ply2 )
	if ply == ply2 then return true end
	if(!ValidEntity( ply ) || !ValidEntity( ply2 )) then return false end
	if( tostring( ply:GetInfo("literp_pp_friend_" .. ply2:UserID() ) ) == "1" ) then return true end
end

hook.Add("PhysgunPickup", "LiteRP:PP", function( ply, ent )
	if( ent:IsPlayer() ) then return false end
	
	if( ent:GetClass() == "prop_physics" && ValidEntity( ply ) && ent.Owner && ent.Owner == ply ) then
		ent:SetCollisionGroup( COLLISION_GROUP_WEAPON )
		ent:SetColor(0,0,0,150)
	end 
	
	if( table.HasValue( NoPickupEntities, ent:GetClass() ) ) then 
		SendBlocked( ply, "You cannot pick up this entity." )
		return false;
	end
	
	if( !ValidEntity( ent.Owner ) ) then
		SendBlocked( ply )
		return false;
	end
	
	if( !IsOwner( ent.Owner, ply ) ) then
		SendBlocked( ply )
		return false;
	end
	
	ent:SetPhysicsAttacker( ply )
	
end )

hook.Add("PhysgunDrop", "LiteRP:PP", function( ply, ent )

	if( ent:GetClass() == "prop_physics" && ValidEntity( ply ) ) then
		ent:SetCollisionGroup( COLLISION_GROUP_NONE )
		ent:SetColor(255,255,255,255)
	end 
	
	ent:SetPhysicsAttacker( ply )
end )

hook.Add("CanPlayerUnfreeze", "LiteRP:PP", function( ply, ent )
	if( ent:IsPlayer() ) then return false end
	
	if( table.HasValue( NoPickupEntities, ent:GetClass() ) ) then 
		SendBlocked( ply, "You cannot unfreeze this entity." )
		return false;
	end
	
	if( !ValidEntity( ent.Owner ) ) then
		SendBlocked( ply )
		return false;
	end
	
	if( !IsOwner( ent.Owner, ply ) ) then
		SendBlocked( ply )
		return false;
	end
	
	ent:SetPhysicsAttacker( ply )
	
end )

hook.Add("CanTool", "LiteRP:PP", function( ply, tr, mode )
	local ent = tr.Entity
	if( tr.HitWorld ) then SendBlocked( ply, "You cannot tool on the world.", true ) return false end
	
	if( !ValidEntity( ent ) ) then return false end
	
	if( ent:IsPlayer() ) then return false end
	
	if( table.HasValue( NoPickupEntities, ent:GetClass() ) ) then 
		SendBlocked( ply, "You cannot tool on this entity.", true )
		return false;
	end
	
	if( !ValidEntity( ent.Owner ) ) then
		SendBlocked( ply, nil, true )
		return false;
	end
	
	if( !IsOwner( ent.Owner, ply ) ) then
		SendBlocked( ply, nil, true )
		return false;
	end
	
	if( mode == "nail" ) then
	
		local trace = {}
		trace.start = tr.HitPos
		trace.endpos = tr.HitPos + ( ply:GetAimVector() * 16.0 )
		local ent1 = tr.Entity
		trace.filter = { ply, ent1 }
		local tr2 = util.TraceLine( trace )
		local _ent = tr2.Entity
		
		if(tr2.HitWorld) then SendBlocked( ply, "You cannot constrain to the world.", true ) return false end

		if( tr2.Hit && ValidEntity( _ent ) && !_ent:IsPlayer() ) then
			if( !IsOwner( _ent.Owner, ply ) ) then return false end
		end
		
	elseif( table.HasValue( ExploitableTools, mode ) ) then
	
		local trace = {}
		trace.start = tr.HitPos
		trace.endpos = trace.start + ( tr.HitNormal * 16384 )
		trace.filter = { ply }
		local tr2 = util.TraceLine(trace)
		local _ent = tr2.Entity
		
		if(tr2.HitWorld) then SendBlocked( ply, "You cannot constrain to the world.", true ) return false end
		
		if( tr2.Hit && ValidEntity( _ent ) && !_ent:IsPlayer() ) then
			if( !IsOwner( _ent.Owner, ply ) ) then return false end
		end
		
	end
	
end )

hook.Add("GravGunPickupAllowed", "LiteRP:PP", function( ply, ent )
	if( ent:IsPlayer() ) then return false end
	
	if( ply:GetEyeTrace().HitWorld ) then return false end
	
	if( table.HasValue( NoPickupEntities, ent:GetClass() ) ) then 
		SendBlocked( ply, "You cannot pick up this entity." )
		return false;
	end
	
	if( !ValidEntity( ent.Owner ) ) then
		SendBlocked( ply, nil )
		return false;
	end
	
	if( !IsOwner( ent.Owner, ply ) ) then
		SendBlocked( ply, nil )
		return false;
	end
	
end )

hook.Add("GravGunPunt", "LiteRP:PP", function( ply, ent )
	if( ent:IsPlayer() ) then return false end
	
	if( table.HasValue( NoPickupEntities, ent:GetClass() ) ) then 
		SendBlocked( ply, "You cannot punt this entity.", true )
		return false;
	end
	
	if( !ValidEntity( ent.Owner ) ) then
		SendBlocked( ply, nil, true )
		return false;
	end
	
	if( !IsOwner( ent.Owner, ply ) ) then
		SendBlocked( ply, nil, true )
		return false;
	end
	
	ent:SetPhysicsAttacker( ply )
	
end )

hook.Add("ShouldCollide", "LiteRP:PP", function( ent1, ent2 )
	if( ent1:GetClass() == "prop_physics" && ent2:GetClass() == "prop_physics" ) then
		if( ValidEntity( ent1.Owner ) ) then
			ent2:SetPhysicsAttacker( ent1.Owner )
			return
		end
		if( ValidEntity( ent2.Owner ) ) then
			ent1:SetPhysicsAttacker( ent2.Owner )
			return
		end
	end
end )

local function SendUM( ent, ply )
	if( ent:IsPlayer() || table.HasValue( NoPickupEntities, ent:GetClass() ) ) then return end
	timer.Simple( .3, function()
		umsg.Start("RPOwner")
		umsg.Entity( ent )
		umsg.Entity( ply )
		umsg.End()
	end )
end

local Collisions = {}

hook.Add("Tick", "LiteRP:PP", function()
	for k, v in ipairs( player.GetAll() ) do 
		if( !Collisions[v] ) then Collisions[v] = 0 end
		if( Collisions[v] > 150 && !v.AYS ) then
			Notify( v, 1, 3, "Are you stuck?" )
			v.AYS = true
		end
		
		if( Collisions[v] > 300 ) then
			//Notify( v, 1, 4, "We're trying to get you out, hang on in there..." )
			local trace = {}
			trace.start = v:EyePos()
			trace.endpos = v:GetPos()
			trace.filter = v 
			trace.mins = v:OBBMins()
			trace.maxs = v:OBBMaxs()
			trace = util.TraceHull( trace )	
			
			if( ValidEntity( trace.Entity ) ) then
				local ent = trace.Entity
				v.StuckEnt = ent
				local mdl = ent:GetModel()
				local se = string.Explode("/", mdl )
				mdl = string.gsub( se[#se], ".mdl", "" )
			
				Notify( v, 1, 4, "It appears you're stuck in a " .. mdl .. "! We're going to nocollide the prop for you.")
				timer.Simple( 1.5, function()
					ent:SetCollisionGroup( COLLISION_GROUP_WEAPON )
					Notify( v, 1, 4, "You should be able to walk out now." )
				end )
			end
			//v:SetPos( v:GetPos() + Vector( 0, 0, 25 ) )
			Collisions[v] = 0
			return
		end
		
		if( ValidEntity( v:GetPhysicsObject() ) && v:GetPhysicsObject():IsPenetrating() ) then
			Collisions[v] = Collisions[v] + 1
		else
			Collisions[v] = 0
			timer.Simple( 1.5, function()
				if( ValidEntity( v.StuckEnt ) ) then
					v.StuckEnt:SetCollisionGroup( COLLISION_GROUP_NONE )
					v.StuckEnt = nil
				end
			end )
			v.AYS = false
		end
	end
end )

hook.Add("PlayerSpawnedProp", "PP", function( ply, model, ent )
	if( ValidEntity( ply ) && ValidEntity( ent ) ) then
		ent.Owner = ply;
		SendUM( ent, ply )
	end
end )

hook.Add("PlayerSpawnedEffect", "PP", function( ply, model, ent )
	if( ValidEntity( ply ) && ValidEntity( ent ) ) then
		ent.Owner = ply;
		SendUM( ent, ply )
	end
end )

hook.Add("PlayerSpawnedNPC", "PP", function( ply, ent )
	if( ValidEntity( ply ) && ValidEntity( ent ) ) then
		ent.Owner = ply;
		SendUM( ent, ply )
	end
end )

hook.Add("PlayerSpawnedRagdoll", "PP", function( ply, model, ent )
	if( ValidEntity( ply ) && ValidEntity( ent ) ) then
		ent.Owner = ply;
		SendUM( ent, ply )
	end
end )

hook.Add("PlayerSpawnedSENT", "PP", function( ply, ent )
	if( ValidEntity( ply ) && ValidEntity( ent ) ) then
		ent.Owner = ply;
		SendUM( ent, ply )		
	end
end )

hook.Add("PlayerSpawnedVehicle", "PP", function( ply, ent )
	if( ValidEntity( ent ) && ent:IsCar() ) then ent:Fire("lock", "", 0) return end
	if( ValidEntity( ply ) && ValidEntity( ent ) ) then
		ent.Owner = ply;
		SendUM( ent, ply )
	end
end )

hook.Add("PlayerSpawnProp", "LiteRP", function() return tobool( RPD.SpawnProps ) end)
hook.Add("PlayerSpawnRagdoll", "LiteRP", function() return tobool( RPD.SpawnRagdolls ) end)
hook.Add("PlayerSpawnVehicle", "LiteRP", function() return tobool( RPD.SpawnVehicles ) end)
hook.Add("PlayerSpawnSwEP", "LiteRP", function() return tobool( RPD.SpawnSWEPs ) end)
hook.Add("PlayerSpawnSENT", "LiteRP", function() return tobool( RPD.SpawnSENTs ) end)
hook.Add("PlayerSpawnNPC", "LiteRP", function() return tobool( RPD.SpawnNPCs ) end)
hook.Add("PlayerSpawnEffect", "LiteRP", function() return tobool( RPD.SpawnEffects ) end)