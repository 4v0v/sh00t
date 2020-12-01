Enemy = Entity:extend('Enemy')

function Enemy:new(id, x, y)
	self.super.new(self, id, x, y)

	self.hp = 10
	self.r = 25
	self.speed = 300
	self.direction = Vec2(0, 1)

	self.red_color = 0
end

function Enemy:update(dt)
	self.super.update(self, dt)

	local player = self.mgr:get('player')
	if player then 
		local _player_direction = Vec2(player.x - self.x, player.y - self.y):normalized()
		self.direction = self.direction:lerp(_player_direction, .05):normalized()
	end

	local _position = Vec2(self.x, self.y)
	local _new_position = _position + self.direction * self.speed * dt

	self.x = _new_position.x
	self.y = _new_position.y
end

function Enemy:hit()
	self.red_color = 1

	if self.timer:get('hit') then 
		self.timer:remove('hit')
	end

	self.timer:tween(.1, self, {red_color = 0}, 'linear', 'hit')
end

function Enemy:draw()
	self.super.draw(self)
	lg.setColor(self.red_color, 1 - self.red_color, 0)
	lg.circle('fill', self.x, self.y, self.r)
	
	lg.setColor(0, 1, 1)
	lg.line(self.x, self.y, self.x + self.direction.x * 50, self.y + self.direction.y * 50)

	lg.setColor(1, 1, 1)
end
