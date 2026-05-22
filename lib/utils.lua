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

	mem_debug = function()
		print("Before collection: " .. collectgarbage("count") / 1024)
		collectgarbage()
		print("After collection: " .. collectgarbage("count") / 1024)
		print("Object count: ")
		local counts = type_count()
		for k, v in pairs(counts) do
			print(k, v)
		end
		print("-------------------------------------")
	end,

	linear_velocity = function(velocity, rotation, dt) return velocity * math.cos(rotation) * dt end,
}

function count_all(f)
	local seen = {}
	local count_table
	count_table = function(t)
		if seen[t] then return end
		f(t)
		seen[t] = true
		for k, v in pairs(t) do
			if type(v) == "table" then
				count_table(v)
			elseif type(v) == "userdata" then
				f(v)
			end
		end
	end
	count_table(_G)
end

function type_count()
	local counts = {}
	local enumerate = function(o)
		local t = type_name(o)
		counts[t] = (counts[t] or 0) + 1
	end
	count_all(enumerate)
	return counts
end

global_type_table = nil
function type_name(o)
	if type(o) == "table" and rawget(o, "__type") then return rawget(o, "__type") end
	if global_type_table == nil then
		global_type_table = {}
		for k, v in pairs(_G) do
			global_type_table[v] = k
		end
		global_type_table[0] = "table"
	end
	return global_type_table[getmetatable(o) or 0] or "Unknown"
end

return utils
