Player = Entity:extend('Player')

function Player:new(id, x, y)
	self.super.new(self, {id = id, x = x, y = y})

	self.r           = 25
	self.speed       = 500
	self.reload_time = 0.10
	self.direction   = Vec2()
end

function Player:update(dt)
	self.super.update(self, dt)

	if     down("q") then self.pos.x = self.pos.x - self.speed * dt
	elseif down("d") then self.pos.x = self.pos.x + self.speed * dt end
	if     down("z") then self.pos.y = self.pos.y - self.speed * dt
	elseif down("s") then self.pos.y = self.pos.y + self.speed * dt end

	local _x, _y = self.mgr.camera:getMousePosition()

	local mouse_direction = (Vec2(_x, _y) - self.pos):normalized()
	self.direction        = self.direction:lerp(mouse_direction, .2):normalized()

	if down('space') then 
		if not self.timer:get('bullet_reload') then 
			local _bullet_spawn_position = self.pos + self.direction * 25
			self.mgr:add(Bullet(_, _bullet_spawn_position.x, _bullet_spawn_position.y, self.direction))
			self.mgr.camera:shake(30)
			self.timer:after(self.reload_time, function() end, 'bullet_reload')
		end
	end
end

function Player:draw()
	self.super.draw(self)

	lg.setColor(1, 0, 0)
	lg.circle('fill', self.pos.x, self.pos.y, self.r)
	lg.setColor(0, 1, 1)
	lg.line(self.pos.x, self.pos.y, self.pos.x + self.direction.x * 50, self.pos.y + self.direction.y * 50)
	lg.setColor(1, 1, 1)
end
