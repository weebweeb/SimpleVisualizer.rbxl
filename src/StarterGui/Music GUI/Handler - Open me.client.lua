music = {
{name = "Dancin", artist = "Krono", id = 3225507391}, -- example listings
{name = "PILLAR MEN", artist = "JOJO'S BIZARRE ADVENTURE", id = 607462546}, -- simply copy and paste these
{name = "PILLAR MEN", artist = "JOJO'S BIZARRE ADVENTURE", id = 607462546}, -- and fill in the areas
	
	
	}
currentsong = nil
soundvolume = 100
musicobject = script.Parent.Frame.Song
visualize = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
player = game.Players.LocalPlayer

managevisualizer = coroutine.wrap(function()
	wait(2)
	player.PlayerGui["Music GUI"].Frame:TweenPosition(UDim2.new(player.PlayerGui["Music GUI"].Frame.Position.X, 0,0, 0))
	while true do
	   wait(1/30)
	if currentsong ~= nil then
		if musicobject.IsPlaying == true then
			table.insert(visualize,1,musicobject.PlaybackLoudness)
			--print(musicobject.PlaybackLoudness)
if #visualize > 20 then
	visualize[21] = nil
end	
	for i,v in pairs(script.Parent.Frame.Frame.Waveform:GetChildren()) do


		if visualize[tonumber(v.Name)] ~= nil then
		local loudness = visualize[tonumber(v.Name)]
		v.Size = UDim2.new(0.01,0,0.006+ loudness/5000,0)
		v.Position = UDim2.new(v.Position.X.Scale,0,0.823-loudness/5000,0)
		end
		end
	
	
		end
	end
	end
	end)

run = coroutine.wrap(function() 
	
	local function fadein(s)
warn("playing "..currentsong.name)
script.Parent.Frame.Frame.SongName.Text = currentsong.name
script.Parent.Frame.Frame.SongArtist.Text = currentsong.artist
musicobject.SoundId = "rbxassetid://"..currentsong.id
s:Play()
for i = 1, soundvolume do
wait(0.1)
s.Volume = s.Volume + 0.01
end

end
local function fadeout(s)
for i = 1, (s.Volume * 100) do
wait(0.01)
s.Volume = s.Volume - 0.01
end
s:Stop()
end

	local function playmusic(id) 
		if currentsong ~= nil then
			fadeout(musicobject)
		end
		
		fadein(musicobject)
		repeat wait() until musicobject.TimePosition >= (musicobject.TimeLength - 3)
		
		end
	while true do
		wait(1/60)
		for i = 1, #music do
			currentsong = music[i]
			playmusic(music[i].id)
		end
		
	end
	
	
	
	
end)

run()
managevisualizer()