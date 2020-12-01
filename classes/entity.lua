Entity = Class:extend('Entity')

function Entity:new(id, x, y, type)
	self.id    = id or uid()
	self.timer = Timer()
	self.type  = type or self:class()
	self.x     = x or 0
	self.y     = y or 0
	self.dead  = false
	self.mgr   = nil
	self.state = 'default'
end

function Entity:init() end
function Entity:draw() end
function Entity:draw_outside_camera() end
function Entity:update(dt) self.timer:update(dt) end
function Entity:set_pos(x, y) self.x, self.y = x, y return self end
function Entity:set_state(state) self.state = state return self end
function Entity:kill() self.dead = true end