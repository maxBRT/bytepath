local ProjectileDeathEffect = {}

function ProjectileDeathEffect:new(entity_manager, x, y, radius)
	local self = GameObject:new(entity_manager, x, y)
	self.__type = "ProjectileDeathEffect"
	self.radius = radius

	self.explosion_alpha = 1
	self.first = true
	self.timer:after(0.1, function()
		self.first = false
		self.second = true
		self.timer:after(0.15, function() self.second = false end)
	end)

	self.timer:tween(
		0.25,
		self,
		{ radius = self.radius * 4, explosion_alpha = 0.25 },
		"in-out-cubic",
		function() self:destroy() end
	)

	function self:draw()
		if self.first then
			love.graphics.setColor(default_color[1], default_color[2], default_color[3], self.explosion_alpha)
		elseif self.second then
			love.graphics.setColor(hp_color[1], hp_color[2], hp_color[3], self.explosion_alpha)
		end
		love.graphics.circle("fill", self.x, self.y, self.radius)
	end

	return self
end

return ProjectileDeathEffect
