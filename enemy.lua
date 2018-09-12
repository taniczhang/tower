require "class"
require "road"

Enemy = class()

function Enemy:ctor()
	self.baseRad  = 180
	self.rad = 180
	self.speed = 100*scaleX
	self.path = 1
	self.destoryed = false
	self.direct = 0
	self.totalBlood = 100
	self.currentBlood = 100
end

function Enemy:setImage(image)
	self.image = image
end

function Enemy:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.image.resource,self.image.x,self.image.y,math.rad(self.rad),scaleX,scaleY,self.image.ax*self.image.width,self.image.ay*self.image.width)
	--血条
	local lx,ly = self.image:getLeftPosition()
	local length = 75*scaleX
	local process = self.currentBlood/self.totalBlood
	love.graphics.setColor(255,0,0,255)
	love.graphics.rectangle("fill", lx + 10, ly + 10 , length, 6 )
	love.graphics.setColor(0,255,0,255)
	love.graphics.rectangle("fill", lx + 10, ly + 10 , process*length, 6 )
end

function Enemy:update(dt)
	if(road[self.path] == nil) then
		self.destoryed = true
		return false
	end
	local dx = road[self.path].x2-road[self.path].x1
	local dy = road[self.path].y2-road[self.path].y1
	
	local rad = 0
	if(dx == 0) then
		if dy > 0 then
			rad = 90
		else
			rad = -90
		end
		self.direct = 0  --特殊情况
		self.image.y = self.image.y + self.speed*dt
	else
		rad = math.atan(dy/dx)
		if(dy ~= 0) then
			self.image.x = self.image.x + math.cos(rad) * self.speed*dt
			self.image.y = self.image.y + math.sin(rad) * self.speed*dt
		else
			if dx > 0 then
				self.direct = 1
				self.image.x = self.image.x + self.speed*dt
			else
				rad = -180
				self.direct = -1
				self.image.x = self.image.x - self.speed*dt
			end
			
		end
	end
	
	self.rad = self.baseRad + rad;
	
	
	if math.pow(self.image.y - road[self.path].y2, 2) + math.pow(self.image.x - road[self.path].x2, 2) < math.pow(2*scaleX,2) then
		self.image.y = road[self.path].y2
		self.image.x = road[self.path].x2
		self.path = self.path + 1;
	end
	
	return true
	
end