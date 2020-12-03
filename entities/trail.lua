Trail = Entity:extend('Trail')

function Trail:new(x, y, target_x, target_y, on_kill)
	Trail.super.new(self, { x = x, y = y})

	self.target     = Vec2(target_x, target_y)
	self.on_kill    = on_kill
	self.points     = {}
	self.speed      = math.random(100)
	self.turn_speed = 0
	self.direction  = Vec2(math.random(-1, 1), math.random(-1, 1)):normalized()

	
	for 10 do table.insert( self.points, {x = self.pos.x, y = self.pos.y}) end

	self.timer:tween(0.5, self, {speed = 1500}, 'linear')
	self.timer:tween(1, self, {turn_speed = 80}, 'out-quad')
end

function Trail:update(dt)
	Trail.super().update(self, dt)

	local _target_direction = (self.target - self.pos):normalized()
	local direction_difference = _target_direction - self.direction
	self.direction += (direction_difference * (self.turn_speed * dt))
	self.pos       += self.direction * self.speed * dt

	table.remove( self.points )
	table.insert( self.points,1, {x = math.ceil(self.pos.x), y = math.ceil(self.pos.y) })

	if point_circ_collision(self.pos, {x = self.target.x, y = self.target.y, r = 20}) then 
		table.remove( self.points )

		if #self.points == 0 then
			self:on_kill()
			self:kill()
		end
	end 
end

function Trail:draw()
	lg.setLineWidth(3)

	for i = 1, #self.points do 
		if #self.points > i +1 then 
			lg.setColor(1,0,0,1)
			lg.line(self.points[i].x +2, self.points[i].y +2, self.points[i+1].x +2 , self.points[i+1].y +2)
			lg.setColor(1,1,1,1)
			lg.line(self.points[i].x, self.points[i].y, self.points[i+1].x, self.points[i+1].y)
		end
	end
	lg.setLineWidth(1)
	lg.setColor(1,1,1,1)
end

function Trail:follow(x, y) 
	self.target.x, self.target.y = x, y
end