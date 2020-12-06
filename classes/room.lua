Room = Class:extend('Room')

function Room:new(id)
	self.id     = id or uid()
	self.timer  = Timer()
	self.camera = Camera()
	self._queue = {}
	self._ents  = { All = {} }
end

function Room:update(dt)
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
			ent.room = nil
			self._ents['All'][ent.id] = nil
			for _, type in pairs(ent.types) do 
				self._ents[type][ent.id] = nil
			end
			ent = {}
		end
	end

	-- push from queue
	for _, ent in pairs(self._queue) do
		for _, type in ipairs(ent.types) do 
			if not self._ents[type] then 
				self._ents[type] = {}
			end
			self._ents[type][ent.id] = ent
		end
		self._ents['All'][ent.id]    = ent
		ent:init()
	end
	self._queue = {}
end

function Room:draw()
	local entities = {}
	for _, ent in pairs(self._ents['All']) do table.insert(entities, ent) end
	table.sort(entities, function(a, b) if a.z == b.z then return a.id < b.id else return a.z < b.z end end)

	self.camera:draw(function()
		for _, ent in pairs(entities) do 
			if ent.draw && !ent.out_cam then ent:draw() end
		end
	end)

	for _, ent in pairs(entities) do 
		if ent.draw && ent.out_cam then 
			ent:draw()
		end
	end
end

function Room:add(a, b, c)
	local id, types, entity

	if type(a) == 'string' and type(b) == 'table' and type(c) == 'nil' then  
		id = a
		types = {}
		entity = b
	elseif type(a) == 'string' and type(b) == 'table' and type(c) == 'table' then 
		id = a
		types = b
		entity = c
	elseif type(a) == 'table' and type(b) == 'table' and type(c) == 'nil' then 
		id = uid()
		types = a
		entity = b
	elseif type(a) == 'table' and type(b) == 'nil' and type(c) == 'nil' then
		id     = uid()
		types  = {}
		entity = a
	end

	table.insert(types, entity:class())

	entity.types    = types  
	entity.id       = id
	entity.room     = self
	
	self._queue[id] = entity
	return entity 
end

function Room:kill(id) 
	local entity = self:get(id)
	if entity then entity:kill() end
end

function Room:get(id) 
	local entity = self._ents['All'][id]
	if not entity or entity.dead then return nil end
	return entity
end

function Room:get_all(type)
	if not self._ents[type] then return {} end
	local entities = {}
	for _, ent in pairs(self._ents[type]) do 
		if not ent.dead then table.insert(entities, ent) end
	end
	return entities
end

function Room:count(type)
	if not self._ents[type] then return 0 end
	local entities = {}
	for _, ent in pairs(self._ents[type]) do 
		if not ent.dead then table.insert(entities, ent) end
	end
	return #entities
end

function Room:foreach(type, func) 
	if not self._ents[type] then return end
	for id, ent in pairs(self._ents[type]) do 
		if not ent.dead then func(ent, id) end 
	end 
end

function Room:enter() 
end

function Room:leave() 
end

function Room:after(...)
	self.timer:after(...)
end

function Room:tween(...)
	self.timer:tween(...)
end

function Room:every(...)
	self.timer:every(...)
end

function Room:during(...)
	self.timer:during(...)
end

function Room:once(...)
	self.timer:once(...)
end

function Room:always(...)
	self.timer:always(...)
end

function Room:zoom(...)
	self.camera:zoom(...)
end

function Room:shake(...)
	self.camera:shake(...)
end

function Room:follow(...)
	self.camera:follow(...)
end
