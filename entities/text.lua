Text = Entity:extend('Text')

function Text:new(id, x, y, text, opts)
	self.super.new(self, id, x, y)

	self.text   = text
	self.scale  = opts and opts.scale or 1
	self.radian = opts and opts.radian or 0
	self.color  = opts and opts.color or {1, 1, 1, 1}
	self.outside_camera = opts and opts.outside_camera or false
end

function Text:update(dt)
	self.super.update(self, dt)
end

function Text:draw()
	if !self.outside_camera then 
		lg.setColor(self.color)
		lg.print(self.text, self.x, self.y, self.radian, self.scale)
		lg.setColor(1, 1, 1, 1)
	end
end

function Text:draw_outside_camera()
	if self.outside_camera then 
		lg.setColor(self.color)
		lg.print(self.text, self.x, self.y, self.radian, self.scale)
		lg.setColor(1, 1, 1, 1)
	end
end

function Text:set_text(text)
	self.text = text
end
