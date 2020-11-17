function uid() return ("xxxxxxxxxxxxxxxx"):gsub("[x]", function() local r = math.random(16) return ("0123456789ABCDEF"):sub(r, r) end) end
function lerp(a, b, x) return a + (b - a) * x end
function cerp(a, b, x) local f=(1-math.cos(x*math.pi))*.5 return a*(1-f)+b*f end
function clamp(low, n, high) return math.min(math.max(low, n), high) end
function is_colliding(r1, r2) return r1.x + r1.w >= r2.x and r1.x <= r2.x + r2.w and r1.y + r1.h >= r2.y and r1.y <= r2.y + r2.h end
function is_inside(r1, r2) return  r1.x >= r2.x and r1.y >= r2.y and r1.x + r1.w <= r2.x + r2.w and r1.y + r1.h <= r2.y + r2.h end
function table.size(t) local n = 0 for _ in pairs(t) do n = n + 1 end return n end
function table.keys(t) local l = {} for k, _ in pairs(t) do l[#l + 1] = k end return l end
function table.values(t) local l = {} for _, v in pairs(t) do l[#l + 1] = v end return l end
function table.print(t)
    for k,v in pairs(t) do if type(v) ~= 'table' then print(k .. ' : ' .. tostring(v)) end end
    for k,v in pairs(t) do if type(v) == 'table' then print(k .. ' : ' .. tostring(v)) end end
end
function random_item(table) return table[love.math.random(#table)] end

function circle_circle_collision(x1, y1, r1, x2, y2, r2)
	local dist = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)
	return dist < ((r1 + r2)*(r1 + r2))
end
