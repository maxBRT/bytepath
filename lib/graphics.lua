love.graphics.push_rotate = function(x, y, r)
	love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(r or 0)
end

love.graphics.push_rotate_scale = function(x, y, r, sx, sy)
	love.graphics.push()
	love.graphics.translate(x, y)
	love.graphics.rotate(r or 0)
	love.graphics.scale(sx or 1, sy or sx or 1)
	love.graphics.translate(-x, -y)
end
