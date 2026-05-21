local EntityManager = require("object.entity_manager")
local Player = require("object.player")
local Square = require("object.square")
local Collider = require("lib.physics.collider")
local Stage = {}

function Stage:new()
	self.entity_manager = EntityManager:new(self)
	self.entity_manager:create_physics_world()
	self.camera_shake = CameraShake:new(camera)
	self.main_canvas = love.graphics.newCanvas(GAME_WIDTH, GAME_HEIGHT)
	self.entity_manager:add(Player:new(self.entity_manager, GAME_WIDTH / 2, GAME_HEIGHT / 2))
	self.entity_manager:add(Square:new(self.entity_manager, GAME_WIDTH / 3, GAME_HEIGHT / 3))

	function self:update(dt)
		camera.smoother = Camera.smooth.damped(5)
		camera:lockPosition(CENTER_X, CENTER_Y)
		if self.entity_manager then self.entity_manager:update(dt) end
	end

	function self:draw()
		love.graphics.setCanvas(self.main_canvas)
		love.graphics.clear()
		camera:attach(0, 0, GAME_WIDTH * SCALE_X, GAME_HEIGHT * SCALE_Y)
		do
			if self.entity_manager then self.entity_manager:draw() end
			if self.entity_manager.world then self.entity_manager.world:debug() end
		end
		camera:detach()
		love.graphics.setCanvas()

		love.graphics.setColor(255, 255, 255, 255)
		love.graphics.setBlendMode("alpha", "premultiplied")
		love.graphics.draw(self.main_canvas, 0, 0, 0, SCALE_X, SCALE_Y)
		love.graphics.setBlendMode("alpha")
	end

	return self
end

return Stage
