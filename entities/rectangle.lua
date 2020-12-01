Rectangle = Entity:extend('Rectangle')

function Rectangle:new(id, x, y, w, h, opts)
	self.super.new(self, id, x, y)
	self.w = w
	self.h = h

	self.line_width = opts and opts.line_width or 1
	self.color      = opts and opts.color or {1, 1, 1, 1}
	self.mode       = opts and opts.mode or 'line'
end

function Rectangle:update(dt)
	self.super.update(self, dt)
end

function Rectangle:draw()
	love.graphics.setColor(self.color)
	love.graphics.setLineWidth(self.line_width)
	love.graphics.rectangle(self.mode, self.x, self.y, self.w, self.h)
	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setLineWidth(1)
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