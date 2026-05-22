local World = require("lib.physics.world")
local AABB = require("lib.physics.AABB")

local EntityManager = {}

function EntityManager:new(room)
	local self = {
		room = room,
		game_objects = {},
	}

	function self:update(dt)
		if self.world then
			self.world:update(dt)
			detect_collision(self.game_objects, self.world)
		end
		for i = #self.game_objects, 1, -1 do
			local obj = self.game_objects[i]
			obj:update(dt, self)
			if obj.dead then table.remove(self.game_objects, i) end
		end

		if self.world then
			self.world:clear()
			for _, obj in ipairs(self.game_objects) do
				if obj.collider then self.world:insert_collider(obj.collider) end
			end
		end
	end

	function self:draw()
		for _, obj in ipairs(self.game_objects) do
			obj:draw()
		end
	end

	function self:add(t)
		table.insert(self.game_objects, t)
		return t
	end

	function self:get_game_objects(callback)
		local t = {}
		for _, game_object in ipairs(self.game_objects) do
			if callback(game_object) then table.insert(t, game_object) end
		end
		return t
	end

	function self:create_physics_world() self.world = World:new() end

	function self:destroy()
		if self.world.destroy then self.world:destroy() end
		if self.room then self.room = nil end
		if self.game_objects then self.game_objects = nil end
	end

	return self
end

function detect_collision(game_objects, world)
	for _, entity in ipairs(game_objects) do
		if entity.collider then
			local nearby = world:query_nearby(entity.collider)
			if nearby then
				for _, c in ipairs(nearby) do
					if c.user_data ~= entity then
						if AABB(entity.collider, c) and entity.on_collision then entity.on_collision(c.user_data) end
					end
				end
			end
		end
	end
end

return EntityManager
