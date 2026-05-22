local timer = require("lib.timer")
local utils = require("lib.utils")
local GameObject = {}

function GameObject:new(entity_manager, x, y)
	local self = {}
	self.__type = "GameObject"
	self.x = x
	self.y = y
	self.id = utils.uuid()
	self.dead = false
	self.timer = timer()
	self.entity_manager = entity_manager

	function self:update(dt)
		if self.timer then self.timer:update(dt) end
	end

	function self:destroy()
		self.dead = true

		if self.timer then
			if self.timer.clear then self.timer:clear() end
			self.timer = nil
		end

		self.entity_manager = nil
	end

	return self
end

return GameObject
