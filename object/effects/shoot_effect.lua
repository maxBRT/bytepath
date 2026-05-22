local ShootEffect = {}

function ShootEffect:new(entity_manager, x, y, ship)
	local self = GameObject:new(entity_manager, x, y)
	self.__type = "ShootEffect"
	self.w = 8
	self.ship = ship
	self.distance = self.ship.w * 1.2
	self.timer:tween(0.1, self, { w = 0 }, "in-out-cubic", function() self:destroy() end)

	local super_update = self.update

	function self:update(dt)
		if self.ship then self.x = self.ship.x + self.distance * math.cos(self.ship.rotation) end
		if self.ship then self.y = self.ship.y + self.distance * math.sin(self.ship.rotation) end
		super_update(self, dt)
	end

	function self:draw()
		love.graphics.push_rotate(self.x, self.y, self.ship.rotation + math.pi / 4)
		love.graphics.translate(-self.x, -self.y)
		love.graphics.setColor(default_color)
		love.graphics.rectangle("fill", self.x - self.w / 2, self.y - self.w / 2, self.w, self.w)
		love.graphics.pop()
	end

	return self
end

return ShootEffect
