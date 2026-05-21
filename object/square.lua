local GameObject = require("object.game_object")
local Collider = require("lib.physics.collider")

local Square = {}

function Square:new(entity_manager, x, y, camera_shake)
	local self = GameObject:new(entity_manager, x, y)
	self.collider = Collider:new(self.x, self.y, 20, 20, self)
	self.camera_shake = camera_shake

	function self:update(dt, entity_manager)
		self.collider.x = self.x
		self.collider.y = self.y
		if self.timer then self.timer:update(dt) end
	end

	function self:draw() love.graphics.rectangle("fill", self.x, self.y, 15, 15) end

	return self
end

return Square
