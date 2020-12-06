Entity = Class:extend('Entity')

function Entity:new(opts)
	self.timer   = Timer()
	self.dead    = false
	self.room    = nil
	self.id      = nil
	self.types   = get(opts, 'types', {})
	self.pos     = Vec2(get(opts, 'x', 0), get(opts, 'y', 0))
	self.z       = get(opts, 'z', 10)
	self.out_cam = get(opts, 'out_cam', false)
	self.state   = get(opts, 'state', 'default')
end

function Entity:init() end
function Entity:draw() end

function Entity:update(dt) 
	self.timer:update(dt) 
end

function Entity:set_pos(x, y) 
	self.pos = Vec2(x, y) 
	return self 
end

function Entity:set_state(state) 
	self.state = state 
	return self 
end

function Entity:kill() 
	self.dead = true 
end

function Entity:after(...)
	self.timer:after(...)
end

function Entity:tween(...)
	self.timer:tween(...)
end

function Entity:every(...)
	self.timer:every(...)
end

function Entity:during(...)
	self.timer:during(...)
end

function Entity:once(...)
	self.timer:once(...)
end

function Entity:always(...)
	self.timer:always(...)
end