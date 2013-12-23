
-- main.lua

love.graphics.setBackgroundColor(0x6b,0x92,0xb9)
-- love.graphics.setBackgroundColor(0xee,0xe9,0xe9)
local particles = {}
local MAX_PARTICLES = 25
local MP = MAX_PARTICLES
local W = 800
local H = 600

function sim_load()
	for i=1,MAX_PARTICLES do
		particles[i] = {}
		local p = particles[i]
		p.x = math.random() * W
		p.y = math.random() * H
		p.r = math.random()*4 + 1
		p.d = math.random()* MP
	end
end

function love.load()
	sim_load()
end

local angle = 0.0 -- used in update
function love.update(dx)
	angle = angle + 0.01
	for i=1,MAX_PARTICLES do
		local p = particles[i]
		p.y = p.y + math.cos(angle + p.d) + 1 + p.r/2
		p.x = p.x + math.sin(angle) * 2

		if (p.x>W+5) or (p.x<-5) or (p.y>H) then
			if i % 3 > 0 then -- 66.67 % of flakes
				p.x = math.random()*W
				p.y = -10
			else
				if math.sin(angle) > 0 then
					p.x = -5
					p.y = math.random()*H
				else
					p.x = W + 5
					p.y = math.random()*H
				end
			end
		end
	end
end

function love.draw()
	love.graphics.clear()
	for i=1,MAX_PARTICLES do
		local p = particles[i]
		love.graphics.arc("fill", p.x,p.y,p.r,0,3.1415*2,10)
	end
end

