require("lib.graphics")
require("lib.math")
Input = require("lib.input")
Timer = require("lib.timer")
Utils = require("lib.utils")
Camera = require("lib.camera")
EntityManager = require("object.entity_manager")
GameObject = require("object.game_object")
Collider = require("lib.physics.collider")

do -- Colors
	default_color = { 222 / 255, 222 / 255, 222 / 255 }
	background_color = { 16 / 255, 16 / 255, 16 / 255 }
	ammo_color = { 123 / 255, 200 / 255, 164 / 255 }
	boost_color = { 76 / 255, 195 / 255, 217 / 255 }
	hp_color = { 241 / 255, 103 / 255, 69 / 255 }
	skill_point_color = { 1, 198 / 255, 93 / 255 }
end
