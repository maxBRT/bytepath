local Collider = {}

function Collider:new(x, y, w, h, user_data)
	local self = {}

	self.x = x
	self.y = y
	self.w = w
	self.h = h
	self.user_data = user_data

	return self
end

return Collider
