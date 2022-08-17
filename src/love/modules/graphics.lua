local fade={1}
local isFading=false
local fadeTimer

local screenWidth, screenHeight
blocks = { -- load default blocks table
    destroy = function()
        for i = 1, #blocks-1 do -- Minus 1 cuz function
            blocks[i] = nil
        end
    end
}
finish = { -- load default finish table for more than 1 finish (may do later)
    destroy = function()
        for i = 1, #finish-1 do -- Minus 1 cuz function
            finish[i] = nil
        end
    end
}
return {
    screenBase = function(width, height)
        screenWidth, screenHeight = width, height
    end,
    getWidth = function() 
        return screenWidth
    end,
    getHeight = function() 
        return screenHeight
    end,
    newBlock = function(mode, x, y, width, height, rx, ry, segments) -- create a new object in the blocks table
        mode = mode or "normal" -- default to normal
        blocks[#blocks + 1] = {
            x = x or 0,
            y = y or 0,
            width = width or 0,
            height = height or 0,
            rx = rx or 0,
            ry = ry or 0,
            segments = segments or 0,

            checkCollision = function(a_x, a_y, a_width, a_height, b_x, b_y, b_width, b_height) -- unused currently
                return (a_x + a_width > b_x) and (a_x < b_x + b_width) and (a_y + a_height > b_y) and (a_y < b_y + b_height)
            end,

            draw = function(self)
                if mode == "normal" then lg.setColor(0.65,0.65,0.65,1) elseif mode == "transparent" then lg.setColor(0,0,0,0) end
                    lg.rectangle(
                        "fill", 
                        self.x, 
                        self.y, 
                        self.width, 
                        self.height, 
                        self.rx, 
                        self.ry,
                        self.segments
                    )
                lg.setColor(1,1,1)
            end,
        }
    end,
    newFinish = function(x, y, width, height, rx, ry, segments) -- for if someone was wanting to have more than 1 finish (idk why tho)
        finish[#finish + 1] = { --                                   its the same as the newBlock function tho
            x = x or 0,
            y = y or 0,
            width = width or 0,
            height = height or 0,
            rx = rx or 0,
            ry = ry or 0,
            segments = segments or 0,

            checkCollision = function(a_x, a_y, a_width, a_height, b_x, b_y, b_width, b_height)
                return (a_x + a_width > b_x) and (a_x < b_x + b_width) and (a_y + a_height > b_y) and (a_y < b_y + b_height)
            end,

            draw = function(self)
                lg.setColor(0.15,0.4,0.15)
                lg.rectangle(
                    "fill", 
                    self.x, 
                    self.y, 
                    self.width, 
                    self.height, 
                    self.rx, 
                    self.ry,
                    self.segments
                )
                lg.setColor(1,1,1)
            end,
        }
    end,
    -- Fade functions, currently unused
    setFade = function(value)
		if fadeTimer then
			Timer.cancel(fadeTimer)

			isFading = false
		end

		fade[1] = value
	end,
	getFade = function(value)
		return fade[1]
	end,
	fadeOut = function(duration, func)
		if fadeTimer then
			Timer.cancel(fadeTimer)
		end

		isFading = true

		fadeTimer = Timer.tween(
			duration,
			fade,
			{0},
			"linear",
			function()
				isFading = false

				if func then func() end
			end
		)
	end,
	fadeIn = function(duration, func)
		if fadeTimer then
			Timer.cancel(fadeTimer)
		end

		isFading = true

		fadeTimer = Timer.tween(
			duration,
			fade,
			{1},
			"linear",
			function()
				isFading = false

				if func then func() end
			end
		)
	end,
	isFading = function()
		return isFading
	end,
    -- Misc
    clear = function(r, g, b, a, s, d)
		local fade = fade[1]

		lg.clear(fade * r, fade * g, fade * b, a, s, d)
	end,
	setColor = function(r, g, b, a)
		local fade = fade[1]

		lg.setColor(fade * r, fade * g, fade * b, a)
	end,
	setColorF = function(r, g, b, a)
		local fade = fade[1]

		lg.setColor(fade * (r/255), fade * (g/255), fade * (b/255), a)
	end,
	setBackgroundColor = function(r, g, b, a)
		local fade = fade[1]

		lg.setBackgroundColor(fade * r, fade * g, fade * b, a)
	end,
	getColor = function()
		local r, g, b, a = lg.getColor()
		local fade = fade[1]

		return r / fade, g / fade, b / fade, a
	end
}
