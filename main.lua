require("libraries/monkey")
require("libraries/utils")
Class = require("libraries/class")
Camera = require("libraries/camera")
Vec2 = require("libraries/vector")

require("classes/entity_mgr")
require("classes/entity")
require("classes/timer")
require("classes/spring")
require("classes/sinewave")

require("managers/play")

require("entities/player")
require("entities/enemy")
require("entities/bullet")
require("entities/trail")
require("entities/wave_title")
require("entities/rectangle")
require("entities/text")

function love.load()
	love.graphics.setDefaultFilter("nearest", "nearest")
	love.graphics.setLineStyle("rough")
	play_mgr = Play()
end

function love.update(dt)
	play_mgr:update(dt)
end

function love.draw()
	play_mgr:draw()
end

function love.keypressed(key)
	if key == "escape" then love.load() end
end
