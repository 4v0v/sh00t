love.graphics.setDefaultFilter("nearest", "nearest")
love.graphics.setLineStyle("rough")

require("libraries/monkey")
require("libraries/utils")
Class  = require("libraries/class")
Camera = require("libraries/camera")
Vec2   = require("libraries/vector")

require_all("classes")
require_all("managers")
require_all("entities", {recursive = true})

function love.load()
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
