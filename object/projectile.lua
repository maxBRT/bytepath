local ProjectileDeathEffect = require("object.effects.projectile_death_effect")
local Projectile = {}

function Projectile:new(entity_manager, x, y, rotation, radius, velocity)
	local self = GameObject:new(entity_manager, x, y)
	self.__type = "Projectile"
	self.rotation = rotation
	self.radius = radius
	self.velocity = velocity
	self.collider = Collider:new(x, y, radius * 2, radius * 2)

	local super_update = self.update

	function self:update(dt)
		if self.x < 0 then self:die() end
		if self.x > GAME_WIDTH then self:die() end
		if self.y < 0 then self:die() end
		if self.y > GAME_HEIGHT then self:die() end

		self.x = self.x + (self.velocity * math.cos(self.rotation)) * dt
		self.y = self.y + (self.velocity * math.sin(self.rotation)) * dt
		self.collider:update(dt, self.x, self.y)
		super_update(self, dt)
	end

	function self:draw()
		love.graphics.setColor(default_color)
		love.graphics.circle("line", self.x, self.y, self.radius)
	end

	function self:die()
		if self.dead then return end
		self.entity_manager:add(ProjectileDeathEffect:new(self.entity_manager, self.x, self.y, self.radius))
		self:destroy()
	end

	local super_destroy = self.destroy
	function self:destroy()
		if self.collider.destroy then self.collider:destroy() end
		super_destroy(self)
	end

	return self
end

return Projectile
