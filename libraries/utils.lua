function uid() 
	return ("xxxxxxxxxxxxxxxx"):gsub("[x]", function() 
		local r = math.random(16) return ("0123456789ABCDEF"):sub(r, r) 
	end) 
end

function lerp(a, b, x) 
	return a + (b - a) * x 
end

function cerp(a, b, x) 
	local f=(1-math.cos(x*math.pi))*.5 
	return a*(1-f)+b*f 
end

function clamp(low, n, high) 
	return math.min(math.max(low, n), high) 
end

function table.size(t)
	local n = 0 
	for _ in pairs(t) do n = n + 1 end 
	return n 
end

function table.keys(t) 
	local _keys = {} 
	for k, _ in pairs(t) do _keys[#_keys + 1] = k end 
	return _keys 
end

function table.values(t)
	local _values = {} 
	for _, v in pairs(t) do _values[#_values + 1] = v end 
	return _values 
end

function table.print(t)
	for k,v in pairs(t) do if type(v) == 'table' then 
		local n = 0 for _ in pairs(v) do n = n + 1 end 
		if n == 0 then print(k .. ' : {}') else print(k .. ' : {...}') end
	end end
	for k,v in pairs(t) do if type(v) ~= 'table' then print(k .. ' : ' .. tostring(v)) end end
end

function table.random_value(t) 
	local _values = {} 
	for _, v in pairs(t) do _values[#_values + 1] = v end
	return _values[math.random(#_values)]
end

function table.random_key(t) 
	local keys = {} 
	for k, _ in pairs(t) do keys[#keys + 1] = k end
	return keys[math.random(#keys)]
end

function circ_circ_collision(c1, c2)
	return (c2.x - c1.x)^2 + (c2.y - c1.y)^2 < ((c1.r + c2.r)^2)
end

function rect_rect_collision(r1, r2)
	return r1.x < r2.x + r2.w and r1.x + r1.w > r2.x and r1.y < r2.y + r2.h and r1.h + r1.y > r2.y
end

function circ_rect_collision(c, r)
	local _x, _y
  if c.x < r.x then _x = r.x elseif c.x > r.x + r.w then _x = r.x + r.w else _x = c.x end
  if c.y < r.y then _y = r.y elseif c.y > r.y + r.h then _y = r.y + r.h else _y = c.y end
	return math.sqrt( (c.x - _x)^2 + (c.y - _y)^2 ) <= c.r
end

function rect_circ_collision(r, c) 
	local _x, _y
  if c.x < r.x then _x = r.x elseif c.x > r.x + r.w then _x = r.x + r.w else _x = c.x end
  if c.y < r.y then _y = r.y elseif c.y > r.y + r.h then _y = r.y + r.h else _y = c.y end
	return math.sqrt( (c.x - _x)^2 + (c.y - _y)^2 ) <= c.r
end

function rect_point_collision(r, p)
	return p.x >= r.x and p.x <= r.x + r.w and p.y >= r.y and p.y <= r.y + r.h
end

function point_rect_collision(p, r)
	return p.x >= r.x and p.x <= r.x + r.w and p.y >= r.y and p.y <= r.y + r.h
end

function point_circ_collision(p, c)
  return math.sqrt( (p.x - c.x)^2 + (p.y - c.y)^2 ) <= c.r 
end

function circ_point_collision(c, p)
	return math.sqrt( (p.x - c.x)^2 + (p.y - c.y)^2 ) <= c.r 
end

function rect_rect_inside(r1, r2) 
	return r1.x >= r2.x and r1.y >= r2.y and r1.x + r1.w <= r2.x + r2.w and r1.y + r1.h <= r2.y + r2.h 
end

function rect_center(r)
	return r.x + r.w / 2, r.y + r.h / 2
end
