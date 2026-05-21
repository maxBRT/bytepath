local World = {}

function World:new()
	local self = {}
	self.cell_size = SPRITE_SIZE * 4
	self.cells = {}

	function self:clear() self.cells = {} end

	function self:insert_collider(collider)
		if collider.x and collider.y then
			key = get_grid_key(collider.x, collider.y, self.cell_size)
			if self.cells[key] then
				self.cells[key][#self.cells[key] + 1] = collider
			else
				self.cells[key] = { collider }
			end
		end
	end

	function self:query_nearby(collider)
		if collider.x and collider.y then
			key = get_grid_key(collider.x, collider.y, self.cell_size)
			return self.cells[key]
		end
	end

	function self:update(dt) end

	function self:debug()
		for _, c_array in pairs(self.cells) do
			for _, c in ipairs(c_array) do
				draw_collider(c)
			end
		end
	end

	return self
end

function get_grid_key(x, y, cell_size)
	local gx = math.floor(x / cell_size)
	local gy = math.floor(y / cell_size)
	return gx .. "," .. gy
end

function draw_collider(collider)
	if collider.x and collider.y and collider.w and collider.h then
		love.graphics.rectangle("line", collider.x, collider.y, collider.w, collider.h)
	end
end

return World
