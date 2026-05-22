local ShootEffect = require("object.effects.shoot_effect")
local Projectile = require("object.projectile")
local Player = {}

function Player:new(entity_manager, x, y)
	local self = GameObject:new(entity_manager, x, y)
	self.__type = "Player"

	self.w = 15
	self.h = 15
	self.rotation = 2 * math.pi
	self.rotation_vel = 1.66 * math.pi
	self.vel = 0
	self.max_vel = 100
	self.accel = 100
	self.collider = Collider:new(self.x, self.y, self.w * 1.5, self.h * 1.5, self)
	self.attack_speed = 1

	do -- Player Attacks
		self.timer:after(1, function()
			self.timer:every(0.24 / self.attack_speed, function() self:shoot() end)
		end)
	end

	local super_update = self.update

	function self:update(dt)
		do -- Player Movement
			if input:down("left") then self.rotation = self.rotation - self.rotation_vel * dt end
			if input:down("right") then self.rotation = self.rotation + self.rotation_vel * dt end
			self.vel = math.min(self.vel + self.accel * dt, self.max_vel)
			self.x = self.x + (self.vel * math.cos(self.rotation)) * dt
			self.y = self.y + (self.vel * math.sin(self.rotation)) * dt
		end

		if self.collider then self.collider:update(dt, self.x, self.y) end
		super_update(self, dt)
	end

	function self:draw()
		love.graphics.circle("line", self.x, self.y, self.w)
		love.graphics.line(
			self.x,
			self.y,
			self.x + self.w * math.cos(self.rotation),
			self.y + self.h * math.sin(self.rotation)
		)
	end

	function self:on_collision(other_obj) end

	local super_destroy = self.destroy

	function self:shoot()
		self.entity_manager:add(
			ShootEffect:new(
				self.entity_manager,
				self.x + 1.2 * self.w * math.cos(self.rotation),
				self.y + 1.2 * self.h * math.sin(self.rotation),
				self
			)
		)
		self.entity_manager:add(
			Projectile:new(
				self.entity_manager,
				self.x + 1.2 * self.w * math.cos(self.rotation),
				self.y + 1.2 * self.h * math.sin(self.rotation),
				self.rotation,
				2,
				self.vel * 2
			)
		)
		self.entity_manager:add(
			Projectile:new(
				self.entity_manager,
				self.x + 1.2 * self.w * math.cos(self.rotation),
				self.y + 1.2 * self.h * math.sin(self.rotation),
				self.rotation + math.to_radiant(30),
				2,
				self.vel * 2
			)
		)
		self.entity_manager:add(
			Projectile:new(
				self.entity_manager,
				self.x + 1.2 * self.w * math.cos(self.rotation),
				self.y + 1.2 * self.h * math.sin(self.rotation),
				self.rotation - math.to_radiant(30),

				2,
				self.vel * 2
			)
		)
	end

	function self:destroy()
		if self.collider.destroy then
			self.collider:destroy()
			self.collider = nil
		end
	end

	return self
end

return Player
