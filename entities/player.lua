Player = Entity:extend('Player')

function Player:new(id, x, y)
	self.super.new(self, id, x, y)

	self.r = 25
	self.speed = 300
	self.direction = Vec2(0, 1)
	self.bullet_reload_timer = 0.05
end

function Player:update(dt)
	self.super.update(self, dt)

	if     love.keyboard.isDown("q") then self.x = self.x - self.speed * dt
	elseif love.keyboard.isDown("d") then self.x = self.x + self.speed * dt end
	if     love.keyboard.isDown("z") then self.y = self.y - self.speed * dt
	elseif love.keyboard.isDown("s") then self.y = self.y + self.speed * dt end

	local _x, _y = self.mgr.camera:getMousePosition()
	local mouse_direction = Vec2(_x - self.x, _y - self.y):normalized()
	self.direction = self.direction:lerp(mouse_direction, .2):normalized()

	if love.keyboard.isDown('space') then 
		if not self.timer:get('bullet_reload') then 
			local _bullet_spawn_position = Vec2(self.x, self.y) + self.direction * 25
			self.mgr:add(Bullet(_, _bullet_spawn_position.x, _bullet_spawn_position.y, self.direction))
			self.mgr.camera:shake(30)
			self.timer:after(self.bullet_reload_timer, function() end, 'bullet_reload')
		end
	end
end

function Player:draw()
	self.super.draw(self)
	love.graphics.setColor(1, 0, 0)
	love.graphics.circle('fill', self.x, self.y, self.r)
	
	love.graphics.setColor(0, 1, 1)
	love.graphics.line(self.x, self.y, self.x + self.direction.x * 50, self.y + self.direction.y * 50)

	love.graphics.setColor(1, 1, 1)
end
