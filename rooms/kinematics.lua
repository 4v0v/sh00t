Kinematics = Room:extend('Kinematics')

function Kinematics:new(id)
	Kinematics.super.new(self, id)

	self:add('tentacle', Tentacle(0, 0, 30, 20))
end

function Kinematics:update(dt)
	Kinematics.super.update(self, dt)

	local mouse_x, mouse_y  = self.camera:getMousePosition()
	local tentacle = self:get('tentacle')


	tentacle:follow(mouse_x, mouse_y)
end
