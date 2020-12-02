Kinematics = Manager:extend('Kinematics')

function Kinematics:new(id)
	self.super.new(self, id)

	self:zoom(0.8)

	self:add(Spider('spider', 0, 0))
end

function Kinematics:update(dt)
	self.super.update(self, dt)

	local spider = self:get('spider')
	local mouse_x, mouse_y  = self.camera:getMousePosition()

	spider:follow(mouse_x, mouse_y)
end

