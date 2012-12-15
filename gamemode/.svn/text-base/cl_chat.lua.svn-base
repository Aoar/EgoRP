usermessage.Hook("RPChat", function( um )	
	local loc = um:ReadBool()
	local ctype, text, nick = um:ReadString(), um:ReadString(), um:ReadString()
	local pr, pg, pb, pa = um:ReadChar()+128, um:ReadChar()+128, um:ReadChar()+128, um:ReadChar()+128
	local cr, cg, cb, ca = um:ReadChar()+128, um:ReadChar()+128, um:ReadChar()+128, um:ReadChar()+128
	local pc, cc, wc = Color( pr, pg, pb, pa ), Color( cr, cg, cb, ca ), Color( 255, 255, 255, 255 )
	
	if( loc ) then
		chat.AddText( cc, "("..ctype..") ", pc, nick, wc, ": " .. text )
	else
		chat.AddText( pc, nick, wc, ": " .. text )
	end
end )