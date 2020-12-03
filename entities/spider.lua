Spider = Entity:extend('Spider')

function Spider:new(x, y)
	self.super.new(self, { x = x, y = y})

	self.hp         = 30
	self.speed      = 100
	self.turn_speed = 50
	self.dir        = Vec2()
	self.target     = Vec2()
	self.eye_width  = 25

	self.legs = {
		self:createLeg(Vec2(-55, 0), 75, 200, 45, true),
		self:createLeg(Vec2(-50, 0), 75, 150, 50, true),
		self:createLeg(Vec2(-35, 0), 75, 150, 60, true),
		self:createLeg(Vec2(-20, 0), 50, 110, 60, true),
		self:createLeg(Vec2(20, 0), 50, 110, 65),
		self:createLeg(Vec2(35, 0), 75, 150, 62),
		self:createLeg(Vec2(50, 0), 75, 150, 52),
		self:createLeg(Vec2(55, 0), 75, 200, 46),
	}

	self:every({1, 10}, function() 
		self:tween(0.05, self, {eye_width = 0}, 'linear', _, function()
			self:tween(0.05, self, {eye_width = 25}, 'linear')
		end)
	end)
end

function Spider:update(dt)
	self.super.update(self, dt)

	local _target_dir = (self.target - self.pos):normalized()
	local _diff       = _target_dir - self.dir
	self.dir += _diff * self.turn_speed * dt

	self.pos += self.dir * self.speed * dt

	for self.legs do self:updateLeg(it) end
end

function Spider:draw()
	for self.legs do
		lg.line(it.joint1.x, it.joint1.y, it.joint2.x, it.joint2.y)
		lg.circle("fill", it.foot.x, it.foot.y, 5)
		lg.line(it.joint2.x, it.joint2.y, it.foot.x, it.foot.y)
	end

	lg.setColor(1, 1, 1, .6)
	lg.circle("fill", self.pos.x, self.pos.y, 50)

	lg.setColor(0, 0, 0)
	lg.ellipse("fill", self.pos.x, self.pos.y, self.eye_width, 45)

	lg.setColor(1, 1, 1)
	local _target = (self.target - self.pos) / 10
	if _target:len() > 20 then _target = _target:normalized() * 20 end
	lg.circle("fill", self.pos.x + _target.x, self.pos.y + _target.y, 10)

	lg.setColor(1, 1, 1)
end

function Spider:follow(x, y) 
	self.target.x, self.target.y = x, y
end

function Spider:createLeg(offset, bone1Length, bone2Length, updateDist, flipped)
	local obj = {}
		obj.bone1Length  = bone1Length
		obj.bone2Length  = bone2Length
		obj.angle1       = 0
		obj.angle2       = 0
		obj.offset       = offset
		obj.joint1       = offset
		obj.joint2       = offset + Vec2(bone1Length, 0)
		obj.foot         = offset + Vec2(bone1Length + bone2Length, 0)
		obj.targetPos    = self:getTargetPos(offset)
		obj.curTargetPos = Vec2()
		obj.updateDist   = updateDist
		obj.flipped      = flipped or false
		
		self:updateLeg(obj)
	return obj
end

function Spider:getTargetPos(legOffset)
	return self.pos + legOffset * 4 + Vec2(0, 100)
end

function Spider:updateLeg(leg)
	local targetPos = self:getTargetPos(leg.offset)
	local targetDiff = (targetPos - leg.targetPos):length()

	-- to achieve a leg animation only update the leg position
	-- when a specified threshold/distance is reached (updateDist)
	if targetDiff > leg.updateDist then
		leg.curTargetPos = leg.targetPos
		local future = targetPos - leg.targetPos
		-- offset legs target position by random number to make it look more natural
		leg.targetPos = targetPos + (Vec2(math.random(), math.random()) * 20 - Vec2(10))
		leg.targetPos = leg.targetPos + future * .5
	end

	-- animate the leg over time
	local diff = leg.targetPos - leg.curTargetPos
	local speed = 15
	if diff:length() < speed then
		leg.curTargetPos = leg.targetPos
	else
		leg.curTargetPos = leg.curTargetPos + diff:normalize() * speed
	end

	-- using this explanation to calculate the angles between body - bone1
	-- and bone1 - bone2 https://www.alanzucconi.com/2018/05/02/ik-2d-1/
	leg.joint1 = self.pos + leg.offset
	local diff = leg.curTargetPos - leg.joint1
	local dist = (diff):length()
	local atan = math.atan2(diff.y, diff.x)

	if leg.bone1Length + leg.bone2Length < dist then
		leg.angle1 = atan
		leg.angle2 = leg.angle1 + 0
	else 
		local cosAngle0 = ((dist * dist) + (leg.bone1Length * leg.bone1Length) - (leg.bone2Length * leg.bone2Length)) / (2 * dist * leg.bone1Length)
		leg.angle1 = atan - math.acos(cosAngle0)

		local cosAngle1 = ((leg.bone2Length * leg.bone2Length) + (leg.bone1Length * leg.bone1Length) - (dist * dist)) / (2 * leg.bone2Length * leg.bone1Length)
		leg.angle2 = leg.angle1 + math.pi - math.acos(cosAngle1)

	end
	
	-- flipping the leg by mirroring the angles based on the angle of
	--  joint1 - targetPos
	if leg.flipped then
		local diff = leg.angle1 - atan
		leg.angle1 = atan - diff
		diff = leg.angle2 - atan
		leg.angle2 = atan - diff
	end

	-- calculating the angles https://www.alanzucconi.com/2018/05/02/ik-2d-2/
	leg.joint2 = leg.joint1 + Vec2(math.cos(leg.angle1), math.sin(leg.angle1)) * leg.bone1Length
	leg.foot = leg.joint2 + Vec2(math.cos(leg.angle2), math.sin(leg.angle2)) * leg.bone2Length
end
