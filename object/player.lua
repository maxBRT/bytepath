local GameObject = require("object.game_object")
local Collider = require("lib.physics.collider")

local Player = {}

function Player:new(entity_manager, x, y, camera_shake)
	local self = GameObject:new(entity_manager, x, y)

	self.w = 15
	self.h = 15
	self.rotation = -math.pi / 2
	self.rotation_vel = 1.66 * math.pi
	self.vel = 0
	self.max_vel = 100
	self.accel = 100
	self.camera_shake = camera_shake
	self.collider = Collider:new(self.x, self.y, self.w, self.h, self)

	function self:update(dt)
		do -- Player Movement
			if input:down("left") then self.rotation = self.rotation - self.rotation_vel * dt end
			if input:down("right") then self.rotation = self.rotation + self.rotation_vel * dt end
			self.vel = math.min(self.vel + self.accel * dt, self.max_vel)
			self.x = self.x + (self.vel * math.cos(self.rotation)) * dt
			self.y = self.y + (self.vel * math.sin(self.rotation)) * dt
		end

		if self.collider then self.collider:update(dt, self.x, self.y) end
		if self.timer then self.timer:update(dt) end
	end

	function self:draw()
		love.graphics.push()
		love.graphics.translate(self.x, self.y)
		love.graphics.rotate(self.rotation)
		love.graphics.rectangle("fill", -self.w / 2, -self.h / 2, self.w, self.h)
		love.graphics.pop()
		love.graphics.line(
			self.x,
			self.y,
			self.x + self.w * math.cos(self.rotation),
			self.y + self.h * math.sin(self.rotation)
		)
	end

	function self:on_collision(other_obj) print("touch") end

	return self
end

return Player
