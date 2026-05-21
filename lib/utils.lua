local utils = {
	uuid = function()
		local fn = function(x)
			local r = love.math.random(16) - 1
			r = (x == "x") and (r + 1) or (r % 4) + 9
			return ("0123456789abcdef"):sub(r, r)
		end
		return (("xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx"):gsub("[xy]", fn))
	end,

	resize = function(s)
		love.window.setMode(s * GAME_WIDTH, s * GAME_HEIGHT)
		SCALE_X, SCALE_Y = s, s
	end,

	draw_debug = function()
		love.graphics.print("FPS: " .. love.timer.getFPS(), 10, 10)
		love.graphics.print("DELTA: " .. love.timer.getDelta(), 10, 30)
		love.graphics.print("RAM: " .. collectgarbage("count") .. " KB", 10, 50)
	end,

	lerp = function(from, to, weight) return from + weight * (to - from) end,
}

return utils
