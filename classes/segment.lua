Segment = Class:extend('Segment')

function Segment:new(tentacle, position, length, angle)
	self.tentacle = tentacle
	self.length   = length
	self.angle    = angle
	self.a        = Vec2()
	self.b        = Vec2()

	if position == 1 then 
		self.a = Vec2(tentacle.x, tentacle.y)
	else
		self.a = self.tentacle.segments[position -1].b:copy()
	end

	self.b = self.a + Vec2.from_cartesian(self.length, self.angle)
end

function Segment:update(dt)
	local dx = self.length * math.cos(self.angle);
	local dy = self.length * math.sin(self.angle);
	self.b = Vec2(self.a.x+dx,self.a.y+dy);

	-- local _new_pos = self.target
	-- self.b = self.pos + Vec2.from_cartesian(self.len, self.b:angle_to(_new_pos))
	-- self.pos = _new_pos
end

function Segment:follow(target_x, target_y)
	local target = Vec2(target_x, target_y)
	local _dir = (target - self.a):normalized()
	self.angle = _dir:angle()
	_dir = _dir:scaled(self.length)
	self.a = target - _dir
end
