Wave_title = Entity:extend('Wave_title')

function Wave_title:new(x, y, wave_number, on_kill)
	Wave_title.super.new(self, { x = x, y = y, out_cam = true})

	self.wave_number = wave_number
	self.alpha       = 0
	self.on_kill     = on_kill

	self:tween(1, self, {alpha = 1}, 'linear', _, function()
		self:after(1, function() 
			self:tween(1, self, {alpha = 0}, 'linear', _, function()
				self:on_kill()
				self:kill()			
			end)
		end)
	end)
end

function Wave_title:draw()
	lg.setColor(1, 1, 1, self.alpha)
	lg.print("wave " .. self.wave_number, self.pos.x, self.pos.y, _, 5, 5)
	lg.setColor(1,1,1,1)
end
