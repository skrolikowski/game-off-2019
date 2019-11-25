local VolumeDown = Button:extend()

function VolumeDown:new(name, x, y, width, height)
	Button.new(self, name, x, y, width, height)
end

-- Event - handle onClick
--
function VolumeDown:onClick()
	if _Volume > 0 then
		_Volume = _Volume - 0.1

		for __, source in pairs(Config.audio) do
	        source:setVolume(_Volume)
	    end

		Config.audio.takeHit:play()
	end
end

return VolumeDown