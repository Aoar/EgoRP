local PPEnts = {}
local ThinkWait = os.time()
local physgunpickupentity = nil
local CPan = nil

usermessage.Hook("RPOwner", function( um )
	local owner = "Error"
	local ent = um:ReadEntity()
	local ply = um:ReadEntity()
	
	if( !IsValid( ply ) || !IsValid( ent ) || !ply:IsPlayer() ) then 
		owner = "Error"
	else
		owner = ply:Nick()
	end
	
	local should_insert = true
	
	for k, v in pairs( PPEnts ) do
		if( v[1] == ent ) then
			should_insert = false
			break
		end
	end
	
	if( should_insert ) then
		table.insert( PPEnts, { ent, ply } )
	end
	
end )

hook.Add("Think", "EgoRP_PP", function()

	for k, v in ipairs( PPEnts or {} ) do
		if( !IsValid( v[1] ) || !IsValid( v[2] ) ) then
			table.remove( PPEnts, k )
		end
	end
	
/*	if( ThinkWait + .25 > os.time() ) then return end
	
	ThinkWait = os.time()
	
	if( !IsValid( LocalPlayer() ) ) then return end
	
	local ent = LocalPlayer():GetEyeTrace().Entity
	
	if( !IsValid( ent ) ) then return end
	
	if( ent:IsPlayer() ) then return end
	
	if( string.find( ent:GetClass(), "door" ) ) then return end
	if( string.find( ent:GetClass(), "func" ) ) then return end
	if( ent:IsCar() ) then return end
	
	local is_in_table = false
	
	for k, v in pairs( PPEnts ) do
		if( v[1] == ent ) then
			is_in_table = true
			break
		end
	end
	
	if( is_in_table ) then return end
	
	RunConsoleCommand("rp_pp_getowner", ent:EntIndex() )*/
	
end )

hook.Add("HUDPaint", "EgoRP_PP", function()

	if( !IsValid( LocalPlayer() ) ) then return end
	
	local ent = LocalPlayer():GetEyeTrace().Entity
	
	if( IsValid( physgunpickupentity ) ) then ent = physgunpickupentity end 
	
	if( !IsValid( ent ) ) then return end
	
	if( ent:IsPlayer() ) then return end
	
	local ply = nil
	
	for k, v in pairs( PPEnts ) do
		if( v[1] == ent ) then
			ply = v[2] 
			break
		end
	end
	
	if( !IsValid( ply ) || !ply:IsPlayer() ) then return end
	
	if( ent:GetPos():Distance( LocalPlayer():GetPos() ) > 300 ) then return end
	
	local pos = ent:LocalToWorld( ent:OBBCenter() ):ToScreen()
	
	draw.SimpleTextOutlined("Owner: "..ply:Nick(), "EgoRPEntFont", pos.x, pos.y, Color(255,255,255,230), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,150,200,230))

end )

function GM:PhysgunPickup( ply, ent )
	if( IsValid( ent ) ) then
		physgunpickupentity = ent 
	end
	if( IsValid(ent) && ent:IsPlayer() ) then return false end
end 

function GM:PhysgunDrop( ent )
	physgunpickupentity = nil
end

concommand.Add("EgoRP_pp_clearfriends", function()
	for k, v in pairs( player.GetAll() ) do
		local cmd = "EgoRP_pp_friend_" .. v:SteamID() 
		if( ConVarExists( cmd ) ) then
			RunConsoleCommand( cmd, "0" )
		end
	end
end )

local function PPFriends( Panel )

	Panel:ClearControls()
	
	if(!CPan) then
		CPan = Panel
	end
	

	Panel:AddControl( "Label", { Text = ""} )
	
	
	if( #player.GetAll() == 1 ) then
	
		Panel:AddControl( "Label", { Text = "" } )
	else
	
		for k, v in pairs( player.GetAll() ) do
		
			if( IsValid( v ) && v != LocalPlayer()) then
				local _FC = "EgoRP_pp_friend_".. v:UserID()
				
				if( !ConVarExists( _FC ) ) then
					CreateClientConVar( _FC, 0, false, true )
				end

				Panel:AddControl( "CheckBox", { Label = v:Nick(), Command = _FC } )
			end
		end
		
		Panel:AddControl( "Label", { Text = "" } )
		
	end
	
	Panel:AddControl( "Label", { Text = "" } )
	
	Panel:AddControl( "Button", { Text  = "Clear Friends", Command = "EgoRP_pp_clearfriends" } )
end

hook.Add("SpawnMenuOpen", "PP", function()

	if( CPan ) then
		PPFriends( CPan )
	end
	
end )

hook.Add("PopulateToolMenu", "PP", function()
	spawnmenu.AddToolMenuOption("EgoRP", "Prop Protection", "Friends", "Friends", "", "", PPFriends )
end )


	