Rectangle = Entity:extend('Rectangle')

function Rectangle:new(id, x, y, w, h, opts)
	self.super.new(self, {id = id, x = x, y = y, z = get(opts, 'z'), out_cam = get(opts, 'out_cam')})
	
	self.w          = w
	self.h          = h
	self.line_width = get(opts, 'line_width', 1)
	self.color      = get(opts, 'color', {1, 1, 1, 1})
	self.mode       = get(opts, 'mode', 'line')
end

function Rectangle:update(dt)
	self.super.update(self, dt)
end

function Rectangle:draw()
	lg.setColor(self.color)
	lg.setLineWidth(self.line_width)
	lg.rectangle(self.mode, self.x, self.y, self.w, self.h)
	lg.setColor(1, 1, 1, 1)
	lg.setLineWidth(1)
end

function Rectangle:center()
	return rect_center(self)
end

function Rectangle:collide_with_point(p)
	return rect_point_collision(self, p)
end

function Rectangle:collide_with_circ(c)
	return rect_circ_collision(self, c)
end

function Rectangle:collide_with_rect(r)
	return rect_rect_collision(self, r)
end