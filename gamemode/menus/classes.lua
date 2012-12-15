
--[[
local RPClassMenuFrame
local PADDING = 5
local RPClassMenuFrame_WIDTH, RPClassMenuFrame_HEIGHT = ScrW()-100, ScrH()-100
local RPClassMenu_Button_HEIGHT = 150
local RPClassMenu_Buttons_TOTAL_WIDTH = RPClassMenuFrame_WIDTH-PADDING*2
local RPClassMenu_Buttons_Y_PADDING = 25

hook.Add("Initialize", "RPClassMenu", function()
	RPClassMenuFrame = vgui.Create("DFrame")
			RPClassMenuFrame:SetPos(50, 50)
			RPClassMenuFrame:SetSize(RPClassMenuFrame_WIDTH, RPClassMenuFrame_HEIGHT)
			RPClassMenuFrame:SetDraggable(false)
			RPClassMenuFrame:SetDeleteOnClose(false)
		local RPClassMenu_Buttons_X_TALLY = PADDING
		local team_count = table.Count(RP.Teams)
		local RPClassMenu_Button_WIDTH = (RPClassMenu_Buttons_TOTAL_WIDTH-PADDING*(team_count-1))/team_count
		for k,team in pairs(RP.Teams) do
			local button = vgui.Create("DButton", RPClassMenuFrame)
					button:SetSize(RPClassMenu_Button_WIDTH, RPClassMenu_Button_HEIGHT)
					button:SetPos(RPClassMenu_Buttons_X_TALLY, RPClassMenu_Buttons_Y_PADDING+PADDING)
			RPClassMenu_Buttons_X_TALLY = RPClassMenu_Buttons_X_TALLY+PADDING+RPClassMenu_Button_WIDTH
					button:SetText(team.name)
					function button:DoClick()
						RunConsoleCommand("rp_class", team.index)
					end
		end
			RPClassMenuFrame:Close()
end)

function RP.ClassMenu()
	RPClassMenuFrame:MakePopup()
end

I use this style:

CREATE ELEMENT1
		SET PROPERTIES OF ELEMENT1
	CREATE CHILD OF ELEMENT1: ELEMENT2
			SET PROPERTIES OF ELEMENT2
		CREATE CHILD OF ELEMENT2: ELEMENT3
				SET PROPERTIES OF ELEMENT3
			CREATE CALLBACK FOR ELEMENT2
		DO STUFF TO ELEMENT1
DO SOME CODE
ETC

function RP.ClassMenu()
	local dframe = vgui.Create("DFrame")
	dframe:SetPos(50, 50)
	dframe:SetSize(w-100, h-100)
	dframe:SetDraggable(false)
	dframe:MakePopup()

	local dborder = vgui.Create("DPanel", dframe)
	dborder:SetPos(10, 35)
	dborder:SetSize(w-120, h-145)
	dborder.Paint = function()
		surface.SetDrawColor( 50, 50, 50, 255 )
		surface.DrawRect(0, 0, dborder:GetWide(), dborder:GetTall())
	end

	local function TeamButton(name, index)
		local dbutton = vgui.Create("DButton", dframe)
		dbutton:SetSize(150, 250)
		dbutton:SetPos(10+(150*index), 45)
		dbutton:SetText(name)
		dbutton.DoClick = function( button )
			RunConsoleCommand("rp_class", index)
		end
	end
	
	for k,v in pairs(RP.Teams) do TeamButton(v.name, v.index) end
	
end
]]
