Bullet = Entity:extend('Bullet')

function Bullet:new(id, x, y, direction)
	self.super.new(self, id, x, y)

	self.r = 5
	self.move_speed = 800
	self.direction = direction

	self.timer:after(2, function() self:kill() end)
end

function Bullet:update(dt)
	self.super.update(self, dt)

	local position_vector = Vec2(self.x, self.y) + self.direction * self.move_speed * dt

	self.x = position_vector.x
	self.y = position_vector.y
end

function Bullet:draw()
	self.super.draw(self)
	love.graphics.setColor(1, 1, 1)
	love.graphics.circle('fill', self.x, self.y, self.r)
end
