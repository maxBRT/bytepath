require("globals")

local Stage = require("object.rooms.stage")

function love.load()
	Utils.resize(3)
	input = Input()
	input:bind("left", "left")
	input:bind("right", "right")
	input:bind("a", "left")
	input:bind("d", "right")
	input:bind("f2", "destroy")
	input:bind("f1", Utils.mem_debug)
	camera = Camera()
	current_room = Stage:new()
end

function love.update(dt)
	if input:pressed("destroy") then
		if current_room.destroy then go_to_room(Stage) end
	end
	if current_room then current_room:update(dt) end
end

function love.draw()
	Utils.draw_debug()
	if current_room then current_room:draw() end
end

function go_to_room(room, opts)
	opts = opts and opts or {}
	if current_room.destroy then
		current_room:destroy()
		current_room = room:new(opts)
	end
end
