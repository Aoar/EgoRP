
RP.Teams = {}

function DisplayNotify(msg)
	local txt = msg:ReadString()
	GAMEMODE:AddNotify(txt, msg:ReadShort(), msg:ReadLong())
	surface.PlaySound("ambient/water/drip" .. math.random(1, 4) .. ".wav")
	
	print(txt)
end
usermessage.Hook("_Notify", DisplayNotify)