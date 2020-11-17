Play = Entity_Mgr:extend('Play')

function Play:new(id)
	self.super.new(self, id)


end

function Play:update(dt)
	self.super.update(self, dt)

	self:foreach("Bullet", function(bullet)
		self:foreach("Zombie", function(zombie) 

			if circle_circle_collision(bullet.x, bullet.y, bullet.r, zombie.x, zombie.y, zombie.r) and not zombie.dead then 
				zombie:kill()
				bullet:kill()
				self:add(Zombie(_, love.math.random(0, 800),  love.math.random(0, 600)))
			end
	
		end)
	
	end)


end

function Play:draw()
	self.super.draw(self)

end
