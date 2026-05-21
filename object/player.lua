local GameObject = require("object.game_object")
local Collider = require("lib.physics.collider")

local Player = {}

function Player:new(entity_manager, x, y, camera_shake)
	local self = GameObject:new(entity_manager, x, y)

	self.collider = Collider:new(self.x, self.y, 20, 20, self)
	function self:on_collision(other_obj) print("touch") end

	self.camera_shake = camera_shake

	input:bind("w", "up")
	input:bind("s", "down")
	input:bind("a", "left")
	input:bind("d", "right")

	function self:update(dt, entity_manager)
		self.collider.x = self.x
		self.collider.y = self.y
		if input:down("up") then self.y = self.y - 1 end
		if input:down("down") then self.y = self.y + 1 end
		if input:down("left") then self.x = self.x - 1 end
		if input:down("right") then self.x = self.x + 1 end
		if self.timer then self.timer:update(dt) end
	end

	function self:draw() love.graphics.rectangle("fill", self.x, self.y, 15, 15) end

	return self
end

return Player
