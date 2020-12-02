Rectangle = Entity:extend('Rectangle')

function Rectangle:new(id, x, y, w, h, opts)
	self.super.new(self, {id = id, x = x, y = y, z = get(opts, 'z'), out_cam = get(opts, 'out_cam')})
	
	self.centered   = get(opts, 'centered', false)
	if self.centered then 
		self.pos.x -= w / 2
		self.pos.y -= h / 2
	end
	self.w          = w
	self.h          = h
	self.color      = get(opts, 'color', {1, 1, 1, 1})
	self.mode       = get(opts, 'mode', 'line')
	self.line_width = get(opts, 'line_width', 1)
end

function Rectangle:update(dt)
	self.super.update(self, dt)
end

function Rectangle:draw()
	lg.setColor(self.color)
	lg.setLineWidth(self.line_width)
	lg.rectangle(self.mode, self.pos.x, self.pos.y, self.w, self.h)
	lg.setColor(1, 1, 1, 1)
	lg.setLineWidth(1)
end

function Rectangle:center()
	return rect_center({x = self.pos.x, y = self.pos.y, w = self.w, h = self.h})
end

function Rectangle:move(x, y)
	if self.centered then 
		x -= self.w /2
		y -= self.h /2
	end
	self.pos.x = x
	self.pos.y = y
end

function Rectangle:collide_with_point(p)
	return rect_point_collision({x = self.pos.x, y = self.pos.y, w = self.w, h = self.h}, p)
end

function Rectangle:collide_with_circ(c)
	return rect_circ_collision({x = self.pos.x, y = self.pos.y, w = self.w, h = self.h}, c)
end

function Rectangle:collide_with_rect(r)
	return rect_rect_collision({x = self.pos.x, y = self.pos.y, w = self.w, h = self.h}, r)
end