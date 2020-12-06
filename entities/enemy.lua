Enemy = Entity:extend('Enemy')

function Enemy:new(x, y)
	Enemy.super.new(self, { x = x, y = y, types = {'Followable'}})

	self.hp        = 10
	self.r         = 25
	self.red_color = 0

	self.speed      = 200
	self.turn_speed = 50
	self.direction  = Vec2()
	self.target     = Vec2()
end

function Enemy:update(dt)
	Enemy.super.update(self, dt)

	local _target_direction = (self.target - self.pos):normalized()
	local _direction_diff   = _target_direction - self.direction
	self.direction += (_direction_diff * (self.turn_speed * dt))
	self.pos       += self.direction * self.speed * dt
end


function Enemy:draw()
	lg.setColor(self.red_color, 1 - self.red_color, 0)
	lg.circle('fill', self.pos.x, self.pos.y, self.r)
	lg.setColor(0, 1, 1)
	lg.line(self.pos.x, self.pos.y, self.pos.x + self.direction.x * 50, self.pos.y + self.direction.y * 50)
	lg.setColor(1, 1, 1)
end

function Enemy:follow(x, y) 
	self.target.x, self.target.y = x, y
end

function Enemy:hit()
	self.red_color = 1
	if self.timer:get('hit') then self.timer:remove('hit') end
	self:tween(.1, self, {red_color = 0}, 'linear', 'hit')
end
