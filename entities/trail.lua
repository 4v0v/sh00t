Trail = Entity:extend('Trail')

function Trail:new(id, x, y, target_x, target_y, on_kill)
    Trail.super.new(self, id, x, y)

    self.target      = Vec2(target_x, target_y)
    self.speed       = math.random(100)
		self.turn_speed  = 0
		self.on_kill       = on_kill

    self.trail = {}

		self.trail.position   = Vec2(x, y)
		self.trail.direction = Vec2(math.random(-1, 1), math.random(-1, 1))
		self.trail.points    = {}
		for 6 do 
			table.insert( self.trail.points, self.trail.position.x)
			table.insert( self.trail.points, self.trail.position.y)
		end

    self.timer:tween(0.5, self, {speed = 1500}, 'linear')
    self.timer:tween(1, self, {turn_speed = 5}, 'out-quad')
end


function Trail:update(dt)
    Trail:super().update(self, dt)

		local _target_direction = (self.target - self.trail.position):normalize()
		local direction_difference = _target_direction - self.trail.direction
		self.trail.direction += (direction_difference * (self.turn_speed / 100))
		self.trail.position  += self.trail.direction * self.speed * dt
		table.remove( self.trail.points )
		table.remove( self.trail.points )
		table.insert( self.trail.points,1, math.ceil(self.trail.position['y']))
		table.insert( self.trail.points,1, math.ceil(self.trail.position['x']))

		if point_circ_collision(self.trail.position, {x = self.target.x, y = self.target.y, r = 20}) then 
				table.remove( self.trail.points )
				table.remove( self.trail.points )

				if #self.trail.points == 0 then
					self:on_kill()
					self:kill()
				end
		end 
end

function Trail:draw()
		love.graphics.setLineWidth(3)
		if #self.trail.points > 4 then 
				love.graphics.setColor(1,0,0,1)
				love.graphics.line(self.trail.points[1] +2, self.trail.points[2] +2, self.trail.points[3] +2 , self.trail.points[4]+2)
				love.graphics.setColor(1,1,1,1)
				love.graphics.line(self.trail.points[1], self.trail.points[2], self.trail.points[3], self.trail.points[4])
		end
		
		if #self.trail.points > 6 then 
				love.graphics.setColor(1,0,0,1)
				love.graphics.line(self.trail.points[3] +2, self.trail.points[4] +2, self.trail.points[5] +2 , self.trail.points[6]+2)
				love.graphics.setColor(1,1,1,1)
				love.graphics.line(self.trail.points[3], self.trail.points[4], self.trail.points[5], self.trail.points[6])
		end

		if #self.trail.points > 8 then 
				love.graphics.setColor(1,0,0, 0.6)
				love.graphics.line(self.trail.points[5] +2, self.trail.points[6] +2, self.trail.points[7] +2 , self.trail.points[8]+2)
				love.graphics.setColor(1,1,1,0.6)
				love.graphics.line(self.trail.points[5], self.trail.points[6], self.trail.points[7], self.trail.points[8])
		end

		if #self.trail.points > 10 then 
				love.graphics.setColor(1,0,0, 0.6)
				love.graphics.line(self.trail.points[7] +2, self.trail.points[8] +2, self.trail.points[9] +2, self.trail.points[10]+2)
				love.graphics.setColor(1,1,1,0.6)
				love.graphics.line(self.trail.points[7], self.trail.points[8], self.trail.points[9], self.trail.points[10])
		end

		if #self.trail.points > 12 then 
				love.graphics.setColor(1,0,0, 0.2)
				love.graphics.line(self.trail.points[9] +2, self.trail.points[10] +2, self.trail.points[11] +2 , self.trail.points[12]+2)
				love.graphics.setColor(1,1,1,0.2)
				love.graphics.line(self.trail.points[9], self.trail.points[10], self.trail.points[11] , self.trail.points[12])
		end
		love.graphics.setLineWidth(1)
    love.graphics.setColor(1,1,1,1)
end

function Trail:set_target(x, y) self.target.x, self.target.y = x, y  end