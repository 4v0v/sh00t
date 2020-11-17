require("libraries/utils")
Class = require("libraries/class")
Vec2 = require("libraries/vector")

require("classes/entity_mgr")
require("classes/entity")
require("classes/timer")
require("classes/spring")
require("classes/sinewave")

require("managers/play")

require("entities/player")
require("entities/zombie")
require("entities/bullet")

function love.load()
	play_mgr = Play()
	play_mgr:add(Player('player', 200, 200))

	for i = 1, 10 do 
		play_mgr:add(Zombie(_, love.math.random(0, 800), love.math.random(0, 600)))
	end
end

function love.update(dt)
	play_mgr:update(dt)
end

function love.draw()
	play_mgr:draw()
end