--[[
	Fancy wrapper that allows you to send user messages of arbitrary length, so no 255 byte limit! :O
	With the added bonus of a Lua implementation of all non-char value transfering in user messages. :3
		By Overv
		
	Edited by Clavus so it doesn't overwrite the standard usermessage message system. Instead use
	um:ExtReadFloat, um:ExtReadVector etc for user messages that use Overv's usermessage system.
]]--

if CLIENT then

	--[[
		Custom receive system
	]]--

	local ReadString = _R.bf_read.ReadString
	local ReadChar = _R.bf_read.ReadChar

	local _buffer = {}
	local _index = 1

	usermessage.Hook( "UM_C", function( um )		
		for i = 1, 200 do
			table.insert( _buffer, ReadChar( um ) )
		end
	end )

	usermessage.Hook( "UM_D", function( um )
		local id = ReadString( um )
		
		_index = 1
		usermessage.IncomingMessage( id, um )
		
		_buffer = {}
	end )

	--[[
		Custom type receiving
	]]--

	function _R.bf_read:ExtReadChar()
		_index = _index + 1
		return _buffer[_index-1]
	end

	function _R.bf_read:ExtReadAngle()
		return Angle( self:ExtReadFloat(), self:ExtReadFloat(), self:ExtReadFloat() )
	end

	function _R.bf_read:ExtReadBool()
		return self:ExtReadChar() == 1
	end

	function _R.bf_read:ExtReadEntity()
		return Entity( self:ExtReadShort() )
	end

	function _R.bf_read:ExtReadFloat()
		local a, b, c = self:ExtReadChar() + 128, self:ExtReadChar() + 128, self:ExtReadChar() + 128
		local e = self:ExtReadChar()
		
		local s = a * 65536 + b * 256 + c - 8388608
		
		if ( s > 0 ) then
			return tonumber( "0." .. s ) * 10^e
		else
			return tonumber( "-0." .. math.abs( s ) ) * 10^e
		end
	end

	function _R.bf_read:ExtReadLong()
		local a, b, c, d = self:ExtReadChar() + 128, self:ExtReadChar() + 128, self:ExtReadChar() + 128, self:ExtReadChar() + 128
		return a * 16777216 + b * 65536 + c * 256 + d - 2147483648
	end

	function _R.bf_read:ExtReadShort()
		return ( self:ExtReadChar() + 128 ) * 256 + self:ExtReadChar() + 128 - 32768
	end

	function _R.bf_read:ExtReadString()
		local s, b = "", self:ExtReadChar()
		
		while ( b != 0 ) do
			s = s .. string.char( b + 128 )
			b = self:ExtReadChar()
		end
		
		return s
	end

	function _R.bf_read:ExtReadVector()
		return Vector( self:ExtReadFloat(), self:ExtReadFloat(), self:ExtReadFloat() )
	end

	function _R.bf_read:ExtReadVectorNormal()
		return self:ExtReadVector()
	end

end