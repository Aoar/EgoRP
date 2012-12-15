--[[
	Fancy wrapper that allows you to send user messages of arbitrary length, so no 255 byte limit! :O
	With the added bonus of a Lua implementation of all non-char value transfering in user messages. :3
		By Overv
		
	Edited by Clavus so it doesn't overwrite the standard usermessage message system. Instead use
	umsg.ExtStart, umsg.ExtEnd, umsg.ExtVector, umsg.ExtFloat etc for user message to use Overv's usermessage system.
]]--

if ( SERVER ) then

	--[[
		Custom transfer system
	]]--

	umsg.PoolString( "UM_C" )
	umsg.PoolString( "UM_D" )

	local _id, _filter
	local _size = 0
	local _buffer = {}

	local Char = umsg.Char
	local String = umsg.String

	local Start = umsg.Start
	local End = umsg.End

	function umsg.ExtStart( id, filter )
		_id = id
		_filter  = filter
		_buffer = {}
	end

	local function flushBuffer()
		if ( #_buffer == 0 ) then return end
		
		Start( "UM_C", _filter )
			for i = 1, 200 do
				Char( _buffer[i] )
			end
		End()
		
		_buffer = {}
	end

	function umsg.ExtEnd()
		flushBuffer()
		
		Start( "UM_D", _filter )
			String( _id )
		End()
	end

	--[[
		Custom type sending
	]]--

	function umsg.ExtChar( c )
		_size = _size + 1
		table.insert( _buffer, c )
		
		if ( #_buffer == 200 ) then
			flushBuffer()
		end
	end

	function umsg.ExtAngle( a )
		umsg.ExtFloat( a.p )
		umsg.ExtFloat( a.y )
		umsg.ExtFloat( a.r )
	end

	function umsg.ExtBool( b )
		if ( b ) then
			umsg.ExtChar( 1 )
		else
			umsg.ExtChar( 0 )
		end
	end

	function umsg.ExtEntity( e )
		umsg.ExtShort( e:EntIndex() )
	end

	function umsg.ExtFloat( f )
		f = f or 0
		
		local neg = f < 0
		f = math.abs( f )
		
		-- Extract significant digits and exponent
		local e = 0
		if ( f >= 1 ) then
			while ( f >= 1 ) do
				f = f / 10
				e = e + 1
			end
		else
			while ( f < 0.1 ) do
				f = f * 10
				e = e - 1
			end
		end
		
		-- Discard digits
		local s = tonumber( string.sub( f, 3, 9 ) )
		
		-- Negate if the original number was negative
		if ( neg ) then s = -s end
		
		-- Convert to unsigned
		s = s + 8388608
		
		-- Send significant digits as 3 byte number
		
		local a = math.modf( s / 65536 ) s = s - a * 65536
		local b = math.modf( s / 256 ) s = s - b * 256
		local c = s
		
		umsg.ExtChar( a - 128 )
		umsg.ExtChar( b - 128 )
		umsg.ExtChar( c - 128 )
		
		-- Send exponent
		umsg.ExtChar( e )
	end

	function umsg.ExtLong( l )
		-- Convert to unsigned
		l = l + 2147483648
		
		local a = math.modf( l / 16777216 ) l = l - a * 16777216
		local b = math.modf( l / 65536 ) l = l - b * 65536
		local c = math.modf( l / 256 ) l = l - c * 256
		local d = l
		
		umsg.ExtChar( a - 128 )
		umsg.ExtChar( b - 128 )
		umsg.ExtChar( c - 128 )
		umsg.ExtChar( d - 128 )
	end

	function umsg.ExtShort( s )
		-- Convert to unsigned
		s = ( s or 0 ) + 32768
		
		local a = math.modf( s / 256 )
		
		umsg.ExtChar( a - 128 )
		umsg.ExtChar( s - a * 256 - 128 )
	end

	function umsg.ExtString( s )
		for i = 1, #s do
			umsg.ExtChar( s:sub( i, i ):byte() - 128 )
		end
		umsg.ExtChar( 0 )
	end

	function umsg.ExtVector( v )
		umsg.ExtFloat( v.x )
		umsg.ExtFloat( v.y )
		umsg.ExtFloat( v.z )
	end

	function umsg.ExtVectorNormal( v )
		umsg.ExtVector( v )
	end

end