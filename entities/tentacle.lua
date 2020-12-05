Tentacle = Entity:extend('Tentacle')

function Tentacle:new(x, y, segment_nb, segment_length)
	self.super.new(self, {x = x, y = y})

	self.segments = {}
	self.target = Vec2()

	for i = 1, segment_nb do
		local segment = Segment(self, i, segment_length, 0)
		table.insert(self.segments, segment)
	end
end

function Tentacle:update(dt)
	self.super.update(self, dt)

	self.segments[#self.segments]:follow(self.target.x, self.target.y)
	self.segments[#self.segments]:update()

	for i = #self.segments -1, 1, -1 do
		self.segments[i]:follow(self.segments[i+1].a.x, self.segments[i+1].a.y)
		self.segments[i]:update()
	end
	
	self.segments[1].a = self.pos:copy()
	self.segments[1]:update()
	
	for i = 2, #self.segments do 
		self.segments[i].a = self.segments[i-1].b:copy();
		self.segments[i]:update();
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
			lg.setColor(0, 1, 1)
			lg.points(it.a.x, it.a.y)
			lg.setColor(1, 0, 0)
			lg.points(it.b.x, it.b.y)
		else
			lg.setColor(0, 1, 1)
			lg.points(it.a.x, it.a.y)
		end
	end

	lg.setLineWidth(1)
	lg.setPointSize(1)
	lg.setColor(1, 1, 1)
end

function Tentacle:follow(x, y) 
	self.target.x, self.target.y = x, y
end