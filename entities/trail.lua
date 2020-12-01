Trail = Entity:extend('Trail')

function Trail:new(id, x, y, target_x, target_y, on_kill)
	Trail.super.new(self, id, x, y)

	self.target      = Vec2(target_x, target_y)
	self.speed       = math.random(100)
	self.turn_speed  = 0
	self.on_kill     = on_kill
	self.trail = {
		position  = Vec2(x, y), 
		direction = Vec2(math.random(-1, 1), math.random(-1, 1)):normalized(),
		points    = {}
	}
	
	for 10 do 
		table.insert( self.trail.points, {x = self.trail.position.x, y = self.trail.position.y})
	end

	self.timer:tween(0.5, self, {speed = 1500}, 'linear')
	self.timer:tween(1, self, {turn_speed = 5}, 'out-quad')
end

function Trail:update(dt)
	Trail:super().update(self, dt)

	local _target_direction = (self.target - self.trail.position):normalized()
	local direction_difference = _target_direction - self.trail.direction
	self.trail.direction += (direction_difference * (self.turn_speed / 100))
	self.trail.position  += self.trail.direction * self.speed * dt

	table.remove( self.trail.points )
	local _point = {
		x = math.ceil(self.trail.position['x']), 
		y = math.ceil(self.trail.position['y']),
	}
	table.insert( self.trail.points,1, _point)

	if point_circ_collision(self.trail.position, {x = self.target.x, y = self.target.y, r = 20}) then 
		table.remove( self.trail.points )

		if #self.trail.points == 0 then
			self:on_kill()
			self:kill()
		end
	end 
end

function Trail:draw()
	love.graphics.setLineWidth(3)

	for i = 1, #self.trail.points do 
		if #self.trail.points > i +1 then 
			love.graphics.setColor(1,0,0,1)
			love.graphics.line(self.trail.points[i].x +2, self.trail.points[i].y +2, self.trail.points[i+1].x +2 , self.trail.points[i+1].y +2)
			love.graphics.setColor(1,1,1,1)
			love.graphics.line(self.trail.points[i].x, self.trail.points[i].y, self.trail.points[i+1].x, self.trail.points[i+1].y)
		end
	end

	love.graphics.setLineWidth(1)
	love.graphics.setColor(1,1,1,1)
end

function Trail:set_target(x, y) self.target.x, self.target.y = x, y  end