Entity = Class:extend('Entity')

function Entity:new(opts)
	self.timer   = Timer()
	self.dead    = false
	self.mgr     = nil

	self.id      = get(opts, 'id', uid())
	self.type    = get(opts, 'type', self:class())
	self.x       = get(opts, 'x', 0)
	self.y       = get(opts, 'y', 0)
	self.z       = get(opts, 'z', 10)
	self.out_cam = get(opts, 'out_cam', false)
	self.state   = get(opts, 'state', 'default')
end

function Entity:init() end
function Entity:draw() end
function Entity:update(dt) self.timer:update(dt) end
function Entity:set_pos(x, y) self.x, self.y = x, y return self end
function Entity:set_state(state) self.state = state return self end
function Entity:kill() self.dead = true end