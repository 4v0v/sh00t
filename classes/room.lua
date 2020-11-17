Room = Class:extend('Room')

function Room:new(id, entity_mgr)
	self.id     = id or uid()
	self.timer  = Timer()
	self.entity_mgr = entity_mgr
end

function Room:update(dt)
	self.timer:update(dt)
	if self.entity_mgr then
		self.entity_mgr:update(dt)
	end
end

function Room:update(dt)
	self.timer:update(dt)
	if self.entity_mgr then
		self.entity_mgr:update(dt)
	end
end

function Room:add(ent) self._queue[ent.id] = ent return self end
function Room:get(id) return self._ents['All'][id] end
function Room:kill(id) self:get(id):kill() return self end
function Room:is_entity(id) return self._ents['All'][id] ~= nil end
function Room:get_by_type(type) return self._ents[type] end
function Room:foreach(type, func) for id, ent in pairs(self._ents[type]) do func(ent, id) end end
function Room:enter() end
function Room:leave() end
