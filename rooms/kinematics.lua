Kinematics = Room:extend('Kinematics')

function Kinematics:new(id)
	self.super.new(self, id)
	self:zoom(0.5)

	local tentacle  = self:add('tentacle', Tentacle(0, 0, 5, 100))

end

function Kinematics:update(dt)
	self.super.update(self, dt)

	local mouse_x, mouse_y  = self.camera:getMousePosition()
	-- local _lerp_mouse = segment1.pos:lerp(Vec2(mouse_x, mouse_y), 0.1)

	local tentacle = self:get('tentacle')

	tentacle:follow(mouse_x, mouse_y)
end
