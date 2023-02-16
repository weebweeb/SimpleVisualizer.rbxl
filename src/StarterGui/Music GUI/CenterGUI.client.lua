

local siGui = nil
local sG = script.Parent.Frame

function getSize()
if siGui == nil then
local g = Instance.new("Frame")
g.Parent = sG
g.Size = UDim2.new(1,0,1,0)
g.Visible = false
siGui = g 
end
return siGui.AbsoluteSize
end

_G["CenterGui"] = function(thing)
posCenter(thing)
end

function posCenter(fr)
local x,y = fr.AbsoluteSize.x,fr.AbsoluteSize.y
local sx,sy =  game.Workspace.CurrentCamera.ViewportSize.X, game.Workspace.CurrentCamera.ViewportSize.Y
local px,py = fr.AbsolutePosition.x,fr.AbsolutePosition.y
a = sx - x
b = sy - y
ab = a/2
bb = b/2
if fr.Position.Y.Scale < 0 then
fr.Position = UDim2.new(0,ab,0,bb - 3)
else
fr.Position = UDim2.new(0,ab,fr.Position.Y.Scale,fr.Position.Y.Offset)
end
end

 posCenter(script.Parent.Frame)
 --script.Parent.Announcements.Frame.OffsetPatcher.Disabled = false

		--posCenter(script.Parent.CharacterCustomizor.Holder)


game.Workspace.CurrentCamera.Changed:connect(function (property)
	--print("recentering GUI")
	if game.Workspace.CurrentCamera.ViewportSize ~= Vector2.new(1,1) then
	wait(0.1)
	if tostring(property) == "ViewportSize" then
		print("recentering GUI")
		print(game.Workspace.CurrentCamera.ViewportSize.magnitude/1150)
		posCenter(script.Parent.Frame)

	end
	end
end)