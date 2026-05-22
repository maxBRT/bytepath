local Collider = {}

function Collider:new(x, y, w, h, user_data)
	local self = {}
	self.__type = "Collider"

	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.user_data = user_data

	function self:update(dt, x, y)
		self.x = x - self.w / 2
		self.y = y - self.h / 2
	end

	function self:destroy() self.user_data = nil end

	return self
end

return Collider
