Player = Entity:extend('Player')

function Player:new(id, x, y)
	self.super.new(self, id, x, y)

	self.r = 25
	self.speed = 300
	self.direction = Vec2(0, 1)
end

function Player:update(dt)
	self.super.update(self, dt)

	if love.keyboard.isDown("q") then self.x = self.x - self.speed * dt
	elseif love.keyboard.isDown("d") then self.x = self.x + self.speed * dt end
	if love.keyboard.isDown("z") then self.y = self.y - self.speed * dt
	elseif love.keyboard.isDown("s") then self.y = self.y + self.speed * dt end


	local mouse_vec = Vec2(love.mouse.getX() - self.x, love.mouse.getY() - self.y)
	self.direction = self.direction:lerp(mouse_vec:normalized(), .2):normalized()


	if love.keyboard.isDown('space') then 
		self.mgr:add(Bullet(_, self.x, self.y, self.direction))
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
