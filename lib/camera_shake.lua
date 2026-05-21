local CameraShake = {}

function get_gradient(p)
	local hash = p * 2654435761
	return bit.band(hash, 1) == 0 and 1 or -1
end

function perlin_1d(time)
	local x0 = math.floor(time)
	local x1 = x0 + 1

	local d0 = time - x0
	local d1 = time - x1

	local v0 = get_gradient(x0) * d0
	local v1 = get_gradient(x1) * d1

	w = perlin_fade(d0)

	return Utils.lerp(v0, v1, w)
end

function perlin_fade(t) return t * t * t * (t * (t * 6 - 15) + 10) end

---comment
---@param camera Camera
function CameraShake:new(camera)
	local self = {}
	self.camera = camera
	self.trauma = 0
	self.max_offset = 15
	self.trauma_decay = 1

	function self:shake(trauma, max_offset)
		self.max_offset = max_offset or self.max_offset
		self.trauma = math.min(self.trauma + trauma, 1)
	end

	function self:update(dt)
		if self.trauma > 0 then
			shake = self.trauma * self.trauma
			offset_x = perlin_1d(love.timer.getTime() * 15) * shake * self.max_offset
			x, y = self.camera:position()
			self.camera:lookAt(x + offset_x, y)
			self.trauma = self.trauma - self.trauma_decay * dt
		end
	end

	return self
end

return CameraShake
