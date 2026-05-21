require("globals")

local Stage = require("object.rooms.stage")

function love.load()
	Utils.resize(3)
	input = Input()
	input:bind("left", "left")
	input:bind("right", "right")
	input:bind("a", "left")
	input:bind("d", "right")
	input:bind("c", "shake")
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
