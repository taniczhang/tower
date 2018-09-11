require "class"

Tower = class()

function Tower:ctor()
	self.trueRad = 0
	self.rad = 0
	self.radius = 130*scaleX
	self.time = 0
	self.delay = 0.25
end

function Tower:setEmeryList(emeryList)
	self.emeryList = emeryList
end

function Tower:setImage(image)
	self.image = image
end

function Tower:update(dt)
	self.time = self.time + dt
	for key, value in ipairs(self.emeryList) do  
		local x1,y1 = self.image:getPosition()
		local x2,y2 = value.image:getPosition()
		
		if (math.pow(x2-x1,2) + math.pow(y2-y1,2) <= (self.radius+5)*(self.radius+5)) then
			--发射子弹
			if self.time >= self.delay then
				--计算角度 四个象限
				local tempRad = math.abs(math.atan((y1-y2)/(x1-x2)))
				if x2 < x1 and y2 > y1 then
				self.trueRad = math.rad(180) - tempRad - math.rad(10)*value.direct
				self.rad = self.trueRad  - math.rad(90)
				elseif x2 > x1 and y2 > y1 then
					self.trueRad = tempRad - math.rad(10)*value.direct
					self.rad = self.trueRad  - math.rad(90)
				elseif x2 > x1 and y2 < y1 then
					self.trueRad = math.rad(360) - tempRad + math.rad(10)*value.direct
					self.rad = self.trueRad  - math.rad(90)
				elseif x2 < x1 and y2 < y1 then
					self.trueRad =  math.rad(180) + tempRad + math.rad(10)*value.direct
					self.rad = self.trueRad  - math.rad(90)
				end
			
				self.time = 0
				local bulletOjb =  Bullet:new()
				local bulletImage = GImage.new(bullet_texture,x1,y1,{0.5,0.5}) 
				bulletOjb:setImage(bulletImage)
				bulletOjb:setInfo(self.trueRad, self.radius)
				bulletOjb:setEmeryList(self.emeryList)
				table.insert(bullet_list,#bullet_list+1,bulletOjb)
			end
		end
	end 
end

function Tower:draw()
	love.graphics.draw(self.image.resource,self.image.x,self.image.y,self.rad,scaleX,scaleY,self.image.ax*self.image.width,self.image.ay*self.image.width)
	local x,y = self.image:getPosition()
	love.graphics.circle("line", x, y, self.radius, 100) -- Draw white circle with 100 segments.
end

