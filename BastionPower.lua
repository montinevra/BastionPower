
local localSpellName = GetSpellInfo(114637) --"Bastion of Glory" in whatever the current language is

--making it draggable
BastionPowerFrame:RegisterForDrag("LeftButton")
BastionPowerFrame:SetScript("OnDragStart", BastionPowerFrame.StartMoving)
BastionPowerFrame:SetScript("OnDragStop", BastionPowerFrame.StopMovingOrSizing)
BastionPowerFrame:SetScript("OnMouseUp", function ( self, button )
	if button == "RightButton" then
		BastionPowerFrame:ClearAllPoints()
		BastionPowerFrame:SetPoint("TOP",PaladinPowerBar,"BOTTOM",0,6)
	end 
end)
---[[
BastionPowerStack1Fill:Hide()
BastionPowerStack2Fill:Hide()
BastionPowerStack3Fill:Hide()
BastionPowerStack4Fill:Hide()
BastionPowerStack5Fill:Hide()
--]]
local expiration;
BastionPowerTimer:SetScript("OnUpdate", function()
	BastionPowerTimer:SetValue(expiration -GetTime())
end)
BastionPowerTimer:Hide();

--show the frame only if you're the appropriate class and spec (i.e. prot paladin)
BastionPowerFrame:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
BastionPowerFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
BastionPowerFrame:SetScript("OnEvent", function()	
	if GetSpecialization() == 2 and select(2,UnitClass("player")) == "PALADIN" then
		BastionPowerFrame:Show() 
	else
		BastionPowerFrame:Hide()
	end
end )

--show tooltip for BoG and instructions for moving/draggin when mousing over the frame
BastionPowerFrame:SetScript("OnEnter", function() 
	GameTooltip_SetDefaultAnchor(GameTooltip, BastionPowerFrame)
	GameTooltip:SetSpellByID(114637)
	GameTooltip:AddLine("\nBastionPower:",0,0.7,1)
	GameTooltip:AddLine("Left click and drag to move. \nRight click to reset position.")
	GameTooltip:Show()
end)
BastionPowerFrame:SetScript("OnLeave", function() 
	GameTooltip:Hide()
end)

--the meat of the addon: display charges of BoG as a resource bar
BastionPowerStack1:RegisterEvent("UNIT_AURA")
BastionPowerStack1:SetScript("OnEvent", function()	
	local stacks = select(4,UnitBuff("player",localSpellName))
	if stacks == nil then
		BastionPowerStack1Fill:Hide()
		BastionPowerStack2Fill:Hide()
		BastionPowerStack3Fill:Hide()
		BastionPowerStack4Fill:Hide()
		BastionPowerStack5Fill:Hide()
		BastionPowerTimer:Hide()
	else
		expiration = (select(7,UnitBuff("player",localSpellName)));
		BastionPowerTimer:Show();
		if stacks == 1 then
			BastionPowerStack1Fill:Show()
		elseif stacks == 2 then
			BastionPowerStack2Fill:Show()
		elseif stacks == 3 then
			BastionPowerStack3Fill:Show()
		elseif stacks == 4 then
			BastionPowerStack4Fill:Show()
		elseif stacks == 5 then
			BastionPowerStack5Fill:Show()
		end
	end
end)
