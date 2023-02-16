music = {
	{name = "Expedition", artist = "Hyper Potions & Nokae", id = 7023887630}, -- example listings
	{name = "Love Is", artist = "Vintage & Morelli x Brandon Mignacca", id = 7029092469}, -- simply copy and paste these
	{name = "Glide", artist = "Stephen Walking", id = 7028957903}, -- and fill in the areas
	
	
	}
currentsong = nil
soundvolume = 100
musicobject = script.Parent.Frame.Song
visualize = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
loudnessThreshold = 200
beatTimes = {} -- Array to store times of detected beats
player = game.Players.LocalPlayer

managevisualizer = coroutine.wrap(function()
	wait(2)
	local function BPM(Sound)
		local numBeats = #beatTimes - 1
		local totalTime = Sound.TimeLength
		local totalBeatsTime = beatTimes[numBeats] - beatTimes[1]
		local avgBeatTime = totalBeatsTime / numBeats
		local bpm = math.floor(60 / avgBeatTime)
		return bpm
	end
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
				if musicobject.PlaybackLoudness > loudnessThreshold then
					table.insert(beatTimes, musicobject.TimePosition)
				end
				
				local container = script.Parent.Frame.Frame
				if #beatTimes >= 30 and bpm == nil then -- make a guess on bpm if we have enough samples
					bpm = BPM(musicobject)
					else bpm = 120
				end
				local y = 10 * math.sin((10 * math.pi * musicobject.TimePosition) / (bpm/60)) -- calculate bpm size at any given moment using a sine wave
				y = y/2000
				container.Size = UDim2.new(0.386+ y/1.5, 0,0.217+ y/1.5, 0)
				container.Position = UDim2.new(0.3-  y/2, 0,0.803- y/2, 0)
				for i,v in pairs(script.Parent.Frame.Frame.Waveform:GetChildren()) do
						if visualize[tonumber(v.Name)] ~= nil then
							local loudness = visualize[tonumber(v.Name)]
						v.Size = UDim2.new(v.Size.X.Scale,0,0.006+ loudness/10000,0)
							v.Position = UDim2.new(v.Position.X.Scale,0,0.823-loudness/10000,0)
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