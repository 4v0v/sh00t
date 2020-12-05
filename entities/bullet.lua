Bullet = Entity:extend('Bullet')

function Bullet:new(x, y, direction)
	Bullet.super.new(self, {x = x, y = y})

	self.r          = 5
	self.move_speed = 800
	self.direction  = direction

	self.timer:after(2, function() self:kill() end)
end

function Bullet:update(dt)
	Bullet.super.update(self, dt)
	self.pos += self.direction * self.move_speed * dt
end

function Bullet:draw()
	Bullet.super.draw(self)
	lg.setColor(1, 1, 1)
	lg.circle('fill', self.pos.x, self.pos.y, self.r)
end
