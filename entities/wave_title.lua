Wave_title = Entity:extend('Wave_title')

function Wave_title:new(id, x, y, wave_number, on_kill)
	self.super.new(self, id, x, y)
	self.wave_number = wave_number
	self.alpha = 0
	self.on_kill = on_kill

	self.timer:tween(1, self, {alpha = 1}, 'linear', _, function()
		self.timer:after(1, function() 
			self.timer:tween(1, self, {alpha = 0}, 'linear', _, function()
				self:on_kill()
				self:kill()			
			end)
		end)
	end)
end

function Wave_title:update(dt)
	self.super.update(self, dt)
end

function Wave_title:draw_outside_camera()
	love.graphics.setColor(1, 1, 1, self.alpha)
	love.graphics.print("wave " .. self.wave_number, self.x, self.y, _, 5, 5)
	love.graphics.setColor(1,1,1,1)
end
