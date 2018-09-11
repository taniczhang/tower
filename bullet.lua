Bullet = class()

function Bullet:ctor(rad)
	self.destoryed = false;
	self.speed = 300*scaleX
end

function Bullet:setImage(image)
	self.image = image
	self.x = self.image.x
	self.y = self.image.y
end

function Bullet:setEmeryList(emeryList)
	self.emeryList = emeryList
end

function Bullet:setInfo(rad,radious)
	self.rad = rad
	self.maxX = self.x + math.cos(self.rad) * radious
	self.maxY = self.y + math.sin(self.rad) * radious
end

function Bullet:draw()
	love.graphics.setColor(255,255,255,255)
	love.graphics.draw(self.image.resource,self.x,self.y,0,scaleX,scaleY,self.image.ax*self.image.width,self.image.ay*self.image.width)
	--love.graphics.line(self.x,self.y,self.maxX,self.maxY )
end

function Bullet:update(dt)
	--如果到了边缘
	if(math.pow(self.x - self.maxX ,2) + math.pow(self.y - self.maxY ,2)) <= 2  then
		self.destoryed = true;
		return false
	end
	self.x = self.x + math.cos(self.rad) * self.speed*dt
	self.y = self.y + math.sin(self.rad) * self.speed*dt
	
	for key, value in ipairs(self.emeryList) do  
		local x2,y2 = value.image:getPosition()
		
		if (math.pow(x2-self.x,2) + math.pow(y2-self.y,2) <= 18*18) then
			--print("hit emery")
			value.currentBlood = value.currentBlood - 1
			if value.currentBlood <= 0 then
				value.currentBlood = 0
				momey = momey+10
				table.remove(self.emeryList,key)
			end
		end
	end
	
	return true
end