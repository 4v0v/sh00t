Play = Room:extend('Play')

function Play:new(id)
	Play.super.new(self, id)

	self.wave_number  = 1
	self.wave_enemies = 5
	self.wave_worms   = 1
	self.wave_spiders = 1
	self.score        = 0
	self.state        = 'waiting_wave_creation'

	self:add('player', Player( 0, 0))
	self:add('score', Text( 10, 10, '0', {scale = 3, out_cam = true, color = {0, 1, 1}}))
	self:add('not_move', Rectangle(100, 100, 300, 300, {z = 0, line_width = 10, centered = true, color = {1, 1, 0, 0.4}}))
	self:add('not_move_x', Rectangle( 450, 100, 600, 300, {z = 0, line_width = 10, color = {1, 0, 1, 0.4}}))
	self:add('not_move_y', Rectangle( 100, 450, 300, 600, {z = 0, line_width = 10, color = {0, 1, 1, 0.4}}))

	self:create_new_wave()
end

function Play:update(dt)
	Play.super.update(self, dt)

	local player      = self:get('player')
	local score       = self:get('score')
	local not_move    = self:get('not_move')
	local not_move_x  = self:get('not_move_x')
	local not_move_y  = self:get('not_move_y')
	local trails      = self:get_by_type('Trail')
	local bullets     = self:get_by_type('Bullet')

	local killables   = self:get_by_type('Enemy', 'Spider', 'Worm')
	local followables = self:get_by_type('Followable')

	if not_move && not_move:collide_with_point(player.pos) then
		local _x, _y = not_move:center()
		self.camera:follow(_x, _y)
		self.camera:zoom(1.5)
	elseif not_move_x && not_move_x:collide_with_point(player.pos) then
		local _, _y = not_move_x:center()
		self.camera:follow(player.pos.x, _y)
		self.camera:zoom(1)
	elseif not_move_y && not_move_y:collide_with_point(player.pos) then
		local _x, _ = not_move_y:center()
		self.camera:follow(_x, player.pos.y)
		self.camera:zoom(1.8)
	else
		self.camera:follow(player.pos.x, player.pos.y)
		self.camera:zoom(0.8)
	end

	for followables do 
		it:follow(player.pos.x, player.pos.y)
	end

	for bullet in bullets do
		for killable in killables do 
			if point_circ_collision(bullet.pos, {x = killable.pos.x, y = killable.pos.y, r = killable.r}) then 
				self:kill(bullet.id)
				if killable.hp > 0 then 
					killable.hp -= 1
					killable:hit()
				else 
					for i = 1, math.random(3) do 
						self:add(Trail(killable.pos.x, killable.pos.y, player.pos.x, player.pos.y, fn() 
							self.score += 1
							score:set_text(tostring(self.score))
						end))
					end
					self:kill(killable.id)
				end
			end
		end
	end

	local current_enemies_nb = self:count('Enemy', 'Spider', 'Worm')
	if current_enemies_nb == 0 && self.state == 'playing_wave' then
		self.state = 'waiting_wave_creation'
		self.wave_number += 1
		self.wave_enemies += 5
		self.wave_spiders += 1
		self.wave_worms += 1
		self.timer:after(2, function() self:create_new_wave() end)
	end
end

function Play:create_new_wave()
	self.state = 'creating_wave'
	self:add(Wave_title(lg.getWidth()/2, lg.getHeight()/2, self.wave_number, function()
		for i = 1, self.wave_enemies do 
			self:add(Enemy(math.random(1000), math.random(1000)))
		end

		for i = 1, self.wave_spiders do 
			self:add(Spider(math.random(1000), math.random(1000)))

		end

		for i = 1, self.wave_worms do 
			self:add(Worm(math.random(1000), math.random(1000), 15, 50))
		end
	
		self.state = 'playing_wave'
	end))
end
