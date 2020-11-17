Zombie = Entity:extend('Zombie')

function Zombie:new(id, x, y)
	self.super.new(self, id, x, y)

	self.r = 25
	self.move_speed = love.math.random(50, 150)
	self.turn_speed = love.math.random(50, 150)
	self.direction = Vec2.from_cartesian(1, math.rad(love.math.random(360)))
	self.sine = Sinewave(0, 10)
	self.sine:stop()
	self.timer:after({0, 1}, function() self.sine:play() end)
end

function Zombie:update(dt)
	self.super.update(self, dt)
	self.sine:update(dt)

	local player = self.mgr:get('player')
	if player then 
		local target_direction = (Vec2(player.x, player.y) - Vec2(self.x, self.y)):normalized()
		local steering = target_direction - self.direction

		self.direction = self.direction + (steering / self.turn_speed)
		local position_vector = Vec2(self.x, self.y) + self.direction * self.move_speed * dt

		self.x = position_vector.x
		self.y = position_vector.y
	end
end

function Zombie:draw()
	self.super.draw(self)
	love.graphics.setColor(0, 1, 0)
	love.graphics.circle('fill', self.x, self.y, self.r + self.sine:value())

	love.graphics.setColor(1, 1, 1)
	love.graphics.line(self.x, self.y, self.x + self.direction.x * 50, self.y + self.direction.y * 50)

	love.graphics.setColor(1, 1, 1)
end
