Tentacle = Entity:extend('Tentacle')

function Tentacle:new(x, y, segment_nb, segment_length)
	Tentacle.super.new(self, {x = x, y = y})

	self.target = Vec2()
	
	self.segments = {}
	for i = 1, segment_nb do
		local _temp
		if i == 1 then 
			_temp = self.pos
		else
			_temp = self.segments[i -1].b:copy()
		end
		table.insert(self.segments, Segment(_temp.x, _temp.y, segment_length, 0))
	end
end

function Tentacle:update(dt)
	Tentacle.super.update(self, dt)

	local last  = self.segments[#self.segments]
	local first = self.segments[1]

	last:b_follow(self.target.x, self.target.y)

	for i = #self.segments -1, 1, -1 do
		local current = self.segments[i]
		local next    = self.segments[i+1]
		current:b_follow(next.a.x, next.a.y)
	end

	first:set_a(self.pos.x, self.pos.y)
	
	for i = 2, #self.segments do
		local current = self.segments[i]
		local prev    = self.segments[i-1]
		current:set_a(prev.b.x, prev.b.y)
	end

end

function Tentacle:draw()
	lg.setPointSize(5)
	lg.setLineWidth(3)

	for self.segments do
		lg.setColor(1, 1, 1)
		lg.line(it.a.x, it.a.y, it.b.x, it.b.y)

		if key == 1 then 
			lg.setColor(0, 1, 0)
			lg.points(it.a.x, it.a.y)
		elseif key == #self.segments then
			lg.setColor(1, 0, 0)
			lg.points(it.b.x, it.b.y)
		end
	end

	lg.setLineWidth(1)
	lg.setPointSize(1)
	lg.setColor(1, 1, 1)
end

function Tentacle:follow(x, y) 
	self.target.x, self.target.y = x, y
end

function Tentacle:move(x, y) 
	self.pos.x, self.pos.y = x, y
end