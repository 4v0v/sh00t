Segment = Entity:extend('Segment')

function Segment:new(x, y, len, angle)
	self.super.new(self, {x = x, y = y})

	self.len    = len
	self.b      = self.pos + Vec2.from_cartesian(len, angle)
	self.target = Vec2()

end

function Segment:update(dt)
	self.super.update(self, dt)

	local _new_pos = self.target
	self.b = self.pos + Vec2.from_cartesian(self.len, self.b:angle_to(_new_pos))
	
	self.pos = _new_pos
end

function Segment:draw()
	lg.setLineWidth(3)
	lg.line(self.pos.x, self.pos.y, self.b.x, self.b.y)
	lg.setLineWidth(1)
end

function Segment:follow(x, y) 
	self.target.x, self.target.y = x, y
end