GM.Version = "0.0.1"
GM.Name = "EgoRP"
GM.Author = "Original: Sadistic Slayer, Miss Pink, Pcwizdan, EgoRP: Aoar, Zero"

DeriveGamemode("sandbox")

include("shared.lua")
include("cl_chat.lua")

-- Don't change these values. If you must, make a new font and change to it.

surface.CreateFont(  "EgoRPHUDFont",
					{
					font	= "coolvetica",
					size	= 20, 
					weight	= 400, 
					antialias	= true, 
					shadow	= false 
			})
			
surface.CreateFont(  "EgoRPEntFont",
					{
					font	= "coolvetica",
					size	= 28, 
					weight	= 400, 
					antialias	= true, 
					shadow	= false 
			})

function GM:InitPostEntity()
	RunConsoleCommand("rp_playerinitnetworking")
	RunConsoleCommand("rp_pp_resend_um")
end

function GM:PlayerNoClip() return false end

function GM:HUDPaint()
	local hp = LocalPlayer():Health()
	local armor = LocalPlayer():Armor()
	local money = LocalPlayer().Money or 0
	local w = ScrW()
	local h = ScrH()
	self:PaintNotes()
	self.BaseClass:HUDPaint()
	self:PaintEnts()
	
	if hp > 0 then
		if armor > 0 then
			draw.SimpleTextOutlined("Money: "..money, "EgoRPHUDFont", 30, h-80, Color(255,255,255,230), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, Color(0,175,0,230))
			draw.SimpleTextOutlined("Health: "..hp, "EgoRPHUDFont", 30, h-60, Color(255,255,255,230), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, Color(200,0,0,230))
			draw.SimpleTextOutlined("Armor: "..armor, "EgoRPHUDFont", 30, h-40, Color(255,255,255,230), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, Color(0,0,150,230))
		else
			draw.SimpleTextOutlined("Money: "..money, "EgoRPHUDFont", 30, h-60, Color(255,255,255,230), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, Color(0,175,0,230))
			draw.SimpleTextOutlined("Health: "..hp, "EgoRPHUDFont", 30, h-40, Color(255,255,255,230), TEXT_ALIGN_LEFT, TEXT_ALIGN_LEFT, 1, Color(200,0,0,230))
		end
	end
end

function GM:PaintEnts()
	local ent = LocalPlayer():GetEyeTrace().Entity
	local pl = ent:RPGetOwner()
	
	if LocalPlayer():InVehicle() then return end
	
	if ent and ent:IsValid() and ent:IsOwnable() and (ent:GetPos():Distance(LocalPlayer():GetPos()) < 300) and (pl and pl:IsValid()) then
		local name = pl:Nick()
		local entpos = ent:LocalToWorld(ent:OBBCenter()):ToScreen()
		
		if ent:IsCar() then
			entpos = ent:LocalToWorld(ent:OBBCenter()+Vector(0,0,20)):ToScreen()
		end
		
		draw.SimpleTextOutlined("Owned By: "..pl:Nick(), "EgoRPEntFont", entpos.x, entpos.y, Color(255,255,255,230), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(0,150,200,230))
	elseif ent and ent:IsValid() and ent:IsOwnable() and (ent:GetPos():Distance(LocalPlayer():GetPos()) < 300) and (!pl or !pl:IsValid()) then
		local entpos = ent:LocalToWorld(ent:OBBCenter()):ToScreen()
		draw.SimpleTextOutlined("Unowned", "EgoRPEntFont", entpos.x, entpos.y, Color(255,255,255,230), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(175,75,75,230))
	end
end
	
function GM:HUDShouldDraw(name)
	return name ~= "CHudHealth" and name ~= "CHudBattery"
end