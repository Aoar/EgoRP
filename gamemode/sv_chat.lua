// ChatCommand Name, Chat Type Name, Color, Radius(Optional), Team you must be to use chat (Optional), Teams that can hear chat (Optional)

local RPChatTypes = {
	{ "ooc", "OOC", Color( 255, 255, 255, 255 ), nil, nil, nil }, // OOC
	{ "/", "OOC", Color( 255, 255, 255, 255 ), nil, nil, nil },  // OOC
	{ "looc", "LOOC", Color( 225, 225, 225, 255 ), 800, nil, nil },  // Local OOC
	{ "y", "Yell", Color( 225, 225, 0, 255 ), 600, nil, nil },  // Yell
	{ "w", "Whisper", Color( 150, 120, 25, 255 ), 100, nil, nil },  // Whisper
	{ "broad", "Broadcast", Color( 255, 5, 5, 255 ), nil, { "mayor" }, nil },  // Broadcast
	{ "radio", "Radio", Color( 25, 25, 255, 255 ), nil, { "police", "mayor" }, { "police", "mayor" } },  // Police Radio
}

local DefaultChatRadius = 400

function GM:PlayerSay( ply, text )
	if( !ValidEntity( ply ) ) then return "" end
	for k, v in pairs( RPChatTypes ) do
		if( string.reverse( string.sub( string.reverse( text ), #text - ( ( #v[1] ) ) ) ) == "/"..v[1] ) then
			local ctype, cname, ccol, cradius, cteam, chear = v[1], v[2], v[3], v[4], v[5], v[6]
			local ctxt  = string.sub( text, #ctype+3 )
			if( cteam && !table.HasValue( cteam, ply.Class ) ) then
				local xt = table.Copy( cteam )
				local lv = xt[#xt]
				if( #xt > 1 ) then
					lv = "or a "..xt[#xt]
					table.remove( xt, #xt )
					if( #xt > 1 ) then
						for k,v in pairs( xt ) do
							xt[k] = v..","
						end
					end
					table.insert( xt, lv )
				end
				local msg = string.format("You must be a %s to use %s chat.", table.concat(xt, " "), v[2] )
				Notify( ply, 1, 2, msg )
				return ""
			else	
				local msg = text
				if( string.find( msg, "/"..ctype .. " " ) ) then
					msg = string.gsub( msg, "/"..ctype .. " ", "" )
				else
					msg = string.gsub( msg, "/"..ctype, "" )
				end
				if( msg == "" ) then 
					Notify( ply, 1, 2, "Your message must be at least one character." )
					return "" 
				end
				local rp = RecipientFilter()
				if( !cradius ) then
					rp:AddAllPlayers()
				else
					for k, v in pairs( ents.FindInSphere( ply:GetPos(), cradius ) ) do
						if( ValidEntity( v ) && v:IsPlayer() ) then
							rp:AddPlayer( v )
						end
					end
				end
				if( chear ) then
					rp:RemoveAllPlayers()
					for k, v in pairs( player.GetAll() ) do
						if( table.HasValue( chear, v.Class ) ) then
							rp:AddPlayer( v )
						end
					end
				end
				umsg.Start("RPChat", rp )
				umsg.Bool( true )
				umsg.String( cname )
				umsg.String( msg )
				umsg.String( ply:Nick() )
				umsg.Char( RP.Teams[ply.Class].color.r-128 )
				umsg.Char( RP.Teams[ply.Class].color.g-128 )
				umsg.Char( RP.Teams[ply.Class].color.b-128 )
				umsg.Char( RP.Teams[ply.Class].color.a-128 )
				umsg.Char( ccol.r-128 )
				umsg.Char( ccol.g-128 )
				umsg.Char( ccol.b-128 )
				umsg.Char( ccol.a-128 )
				umsg.End()
				return ""
			end
		end
	end
	local rp = RecipientFilter()
	for k, v in pairs( ents.FindInSphere( ply:GetPos(), DefaultChatRadius or 400 ) ) do
		if( ValidEntity( v ) && v:IsPlayer() ) then
			rp:AddPlayer( v )
		end
	end
	umsg.Start("RPChat", rp )
	umsg.Bool( false )
	umsg.String( "" )
	umsg.String( text )
	umsg.String( ply:Nick() )
	umsg.Char( RP.Teams[ply.Class].color.r-128 )
	umsg.Char( RP.Teams[ply.Class].color.g-128 )
	umsg.Char( RP.Teams[ply.Class].color.b-128 )
	umsg.Char( RP.Teams[ply.Class].color.a-128 )
	umsg.End()
	return ""
end