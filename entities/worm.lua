Worm = Entity:extend('Worm')

function Worm:new(x, y, segment_nb, segment_length)
	Worm.super.new(self, {x = x, y = y, types = {'Followable'}})

	self.segment_length = segment_length
	self.r          = segment_length / 2
	self.hp         = 50
	self.speed      = 400
	self.red_color  = 0
	self.turn_speed = 50
	self.dir        = Vec2()
	self.target     = Vec2()
	
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

function Worm:update(dt)
	Worm.super.update(self, dt)

	local _target_dir = (self.target - self.pos):normalized()
	local _diff       = _target_dir - self.dir
	self.dir += _diff * self.turn_speed * dt
	self.pos += self.dir * self.speed * dt


	local last  = self.segments[#self.segments]
	last:b_follow(self.pos.x, self.pos.y)
	
	for i = #self.segments -1, 1, -1 do
		local current = self.segments[i]
		local next    = self.segments[i+1]
		current:b_follow(next.a.x, next.a.y)
	end
	
	-- local first = self.segments[1]
	-- first:set_a(self.pos.x, self.pos.y)
	
	-- for i = 2, #self.segments do
	-- 	local current = self.segments[i]
	-- 	local prev    = self.segments[i-1]
	-- 	current:set_a(prev.b.x, prev.b.y)
	-- end
end

function Worm:draw()
	lg.setColor(self.red_color, 1 - self.red_color, 0)
	for self.segments do
		lg.circle('line', it.a.x, it.a.y, self.segment_length/2)
	end
	lg.setColor(1, 1, 1)
end

function Worm:follow(x, y) 
	self.target.x, self.target.y = x, y
end


function Worm:hit()
	self.red_color = 1
	if self.timer:get('hit') then self.timer:remove('hit') end
	self:tween(.1, self, {red_color = 0}, 'linear', 'hit')
end

