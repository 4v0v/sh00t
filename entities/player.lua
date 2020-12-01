Player = Entity:extend('Player')

function Player:new(id, x, y)
	self.super.new(self, {id = id, x = x, y = y})

	self.r           = 25
	self.speed       = 300
	self.direction   = Vec2(0, 1)
	self.reload_time = 0.10
end

function Player:update(dt)
	self.super.update(self, dt)

	if     down("q") then self.x = self.x - self.speed * dt
	elseif down("d") then self.x = self.x + self.speed * dt end
	if     down("z") then self.y = self.y - self.speed * dt
	elseif down("s") then self.y = self.y + self.speed * dt end

	local _x, _y = self.mgr.camera:getMousePosition()
	local mouse_direction = Vec2(_x - self.x, _y - self.y):normalized()
	self.direction = self.direction:lerp(mouse_direction, .2):normalized()

	if down('space') then 
		if not self.timer:get('bullet_reload') then 
			local _bullet_spawn_position = Vec2(self.x, self.y) + self.direction * 25
			self.mgr:add(Bullet(_, _bullet_spawn_position.x, _bullet_spawn_position.y, self.direction))
			self.mgr.camera:shake(30)
			self.timer:after(self.reload_time, function() end, 'bullet_reload')
		end
	end
end

function Player:draw()
	self.super.draw(self)

	lg.setColor(1, 0, 0)
	lg.circle('fill', self.x, self.y, self.r)
	lg.setColor(0, 1, 1)
	lg.line(self.x, self.y, self.x + self.direction.x * 50, self.y + self.direction.y * 50)
	lg.setColor(1, 1, 1)
end
