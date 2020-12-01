Entity_Mgr = Class:extend('Entity_Mgr')

function Entity_Mgr:new(id)
	self.id     = id or uid()
	self.timer  = Timer()
	self.camera = Camera()
	self._queue = {}
	self._ents  = { All = {} }
end

function Entity_Mgr:update(dt)
	self.timer:update(dt)
	self.camera:update(dt)

	-- update 
	for _, ent in pairs(self._ents['All']) do 
		ent:update(dt)
	end

	-- delete
	for _, ent in pairs(self._ents['All']) do 
		if ent.dead then
			ent.timer:destroy()
			ent.mgr = nil
			self._ents['All'][ent.id] = nil
			self._ents[ent.type][ent.id] = nil
			ent = {}
		end
	end

	-- push from queue
	for _, ent in pairs(self._queue) do
		ent.mgr = self
		if not self._ents[ent.type] then 
			self._ents[ent.type] = {}
		end
		self._ents[ent.type][ent.id] = ent
		self._ents['All'][ent.id] = ent
		ent:init()
	end
	self._queue = {}
end

function Entity_Mgr:draw()
	self.camera:draw(function()
		for _, ent in pairs(self._ents['All']) do 
			if ent.draw then ent:draw() end
		end
	end)

	for _, ent in pairs(self._ents['All']) do 
		if ent.draw_outside_camera then 
			ent:draw_outside_camera()
		end
	end
end

function Entity_Mgr:add(ent) 
	self._queue[ent.id] = ent 
	return self 
end

function Entity_Mgr:kill(id) 
	local entity = self:get(id)
	if entity then entity:kill() end
end

function Entity_Mgr:get(id) 
	local entity = self._ents['All'][id]
	if not entity or entity.dead then return nil end
	return entity
end

function Entity_Mgr:get_all(type)
	if not self._ents[type] then return {} end
	local entities = {}
	for _, ent in pairs(self._ents[type]) do 
		if not ent.dead then table.insert(entities, ent) end
	end
	return entities
end

function Entity_Mgr:count(type)
	if not self._ents[type] then return 0 end
	local entities = {}
	for _, ent in pairs(self._ents[type]) do 
		if not ent.dead then table.insert(entities, ent) end
	end
	return #entities
end

function Entity_Mgr:foreach(type, func) 
	if not self._ents[type] then return end
	for id, ent in pairs(self._ents[type]) do 
		if not ent.dead then func(ent, id) end 
	end 
end

function Entity_Mgr:enter() end
function Entity_Mgr:leave() end
