Entity_Mgr = Class:extend('Entity_Mgr')

function Entity_Mgr:new(id)
	self.id     = id or uid()
	self.timer  = Timer()
	self._queue = {}
	self._ents  = { All = {} }
end

function Entity_Mgr:update(dt)
	self.timer:update(dt)

	-- update and delete
	for _, ent in pairs(self._ents['All']) do 
		ent:update(dt)
	end

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
	for _, ent in pairs(self._ents['All']) do 
		if ent.draw then 
			ent:draw()
		end
	end
end

function Entity_Mgr:add(ent) self._queue[ent.id] = ent return self end
function Entity_Mgr:get(id) return self._ents['All'][id] end
function Entity_Mgr:kill(id) self:get(id):kill() return self end
function Entity_Mgr:is_entity(id) return self._ents['All'][id] ~= nil end
function Entity_Mgr:get_by_type(type) return self._ents[type] end
function Entity_Mgr:foreach(type, func) 
	if not self._ents[type] then return end
	for id, ent in pairs(self._ents[type]) do func(ent, id) end 
end
function Entity_Mgr:enter() end
function Entity_Mgr:leave() end
