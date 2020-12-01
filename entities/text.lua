Text = Entity:extend('Text')

function Text:new(id, x, y, text, opts)
	self.super.new(self, {id = id, x = x, y = y, out_cam = get(opts, 'out_cam')})

	self.text     = lg.newText(get(opts, 'font', lg.getFont()), text)
	self.scale    = get(opts, 'scale', 1)
	self.radian   = get(opts, 'radian', 0)
	self.color    = get(opts, 'color', {1, 1, 1})
	self.centered = get(opts, 'centered', false)
end

function Text:update(dt)
	self.super.update(self, dt)
end

function Text:draw()
	lg.setColor(self.color)
	local offset_x, offset_y
	if self.centered then
		offset_x, offset_y = self.text:getWidth() / 2, self.text:getHeight() / 2
	end
	lg.draw(self.text, self.x, self.y, self.radian, self.scale, _, offset_x, offset_y)
	lg.setColor(1, 1, 1, 1)
end

function Text:set_text(text)
	self.text:set(text)
end
