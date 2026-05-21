require("globals")

local Stage = require("object.rooms.stage")

function love.load()
	Utils.resize(3)
	input = Input()
	camera = Camera()
	current_room = Stage:new()
end

function love.update(dt)
	if current_room then current_room:update(dt) end
end

function love.draw()
	Utils.draw_debug()
	if current_room then current_room:draw() end
end
