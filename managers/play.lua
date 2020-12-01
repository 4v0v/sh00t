Play = Entity_Mgr:extend('Play')

function Play:new(id)
	self.super.new(self, id)

	self.wave_number = 1
	self.wave_enemies = 5
	self.score = 0
	self.state = 'waiting_wave_creation'

	self:add(Player('player', 0, 0))
	self:add(Text('score', 10, 10, '0', {scale = 3, outside_camera = true}))
	self:add(Rectangle('not_move'  , 100, 100, 300, 300))
	self:add(Rectangle('not_move_x', 450, 100, 600, 300, {line_width = 3}))
	self:add(Rectangle('not_move_y', 100, 450, 300, 600, {line_width = 3}))

	self:create_new_wave()
end

function Play:update(dt)
	self.super.update(self, dt)

	local player     = self:get('player')
	local score      = self:get('score')
	local not_move   = self:get('not_move')
	local not_move_x = self:get('not_move_x')
	local not_move_y = self:get('not_move_y')
	local trails     = self:get_all('Trail')
	local bullets    = self:get_all('Bullet')
	local enemies    = self:get_all('Enemy')

	if not_move && not_move:collide_with_point(player) then
		local _x, _y = not_move:center()
		self.camera:follow(_x, _y)
		self.camera:zoom(1.5)
	elseif not_move_x && not_move_x:collide_with_point(player) then
		local _, _y = not_move_x:center()
		self.camera:follow(player.x, _y)
		self.camera:zoom(0.8)
	elseif not_move_y && not_move_y:collide_with_point(player) then
		local _x, _ = not_move_y:center()
		self.camera:follow(_x, player.y)
		self.camera:zoom(2)
	else
		self.camera:follow(player.x, player.y)
		self.camera:zoom(1)
	end

	for trails do 
		it:set_target(player.x, player.y)
	end

	for bullet in bullets do
		for enemy in enemies do 
			if point_circ_collision(bullet, enemy) then 
				self:kill(bullet.id)
				if enemy.hp > 0 then 
					enemy.hp -= 1
					enemy:hit()
				else 
					for i = 1, math.random(3) do 
						self:add(Trail(_, enemy.x, enemy.y, player.x, player.y, fn() 
							self.score += 1
							score:set_text(tostring(self.score))
						end))
					end
					self:kill(enemy.id)
				end
			end
		end
	end

	local current_enemies_nb = self:count('Enemy')
	if current_enemies_nb == 0 && self.state == 'playing_wave' then
		self.state = 'waiting_wave_creation'
		self.wave_number += 1
		self.wave_enemies += 5
		self.timer:after(2, function() self:create_new_wave() end)
	end
end

function Play:draw()
	self.super.draw(self)
end

function Play:create_new_wave()
	self.state = 'creating_wave'
	self:add(Wave_title(_, 100, 100, self.wave_number, function()
		for i = 1, self.wave_enemies do 
			self:add(Enemy(_, 100, i * 100))
		end
		self.state = 'playing_wave'
	end))
end
