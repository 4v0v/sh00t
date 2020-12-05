Lizard = Entity:extend('Lizard')

function Lizard:new(x, y)
	Lizard.super.new(self, { x = x, y = y})

	self.hp         = 30
	self.speed      = 200
	self.turn_speed = 50
	self.dir        = Vec2()
	self.target     = Vec2()
end

function Lizard:update(dt)
	Lizard.super.update(self, dt)

	local _target_dir = (self.target - self.pos):normalized()
	local _diff       = _target_dir - self.dir
	self.dir += _diff * self.turn_speed * dt
	self.pos += self.dir * self.speed * dt
end

function Lizard:draw()
	lg.setColor(1, 0, 0)
	lg.circle('fill', self.pos.x, self.pos.y, 20)
	lg.setColor(1, 1, 1)
end

function Lizard:follow(x, y) 
	self.target.x, self.target.y = x, y
end