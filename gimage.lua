require "class"
 -- Meta class
GImage = class()
-- 基础类方法 new
function GImage:ctor(res,x,y,anchor)
	self.x = x
	self.y = y
	self.resource = res
	self.width = self.resource:getData():getWidth() 
	self.height = self.resource:getData():getHeight()
	
	if(anchor ~= nil) then
		self.ax = anchor[1]
		self.ay = anchor[2]
	else
		self.ax = 0
		self.ay = 0
	end
end

function GImage:draw ()
   love.graphics.draw(self.resource,self.x,self.y,0,scaleX,scaleY,self.ax*self.width,self.ay*self.height)
end

function GImage:getLeftPosition()
   return self.x - self.ax*self.width*scaleX, self.y - self.ay*self.height*scaleY
end

function GImage:getPosition()
   return self.x, self.y 
end

function GImage:getSize()
   return self.width*scaleX,self.height*scaleY
end

function GImage:getRect()
   local rx,ry = self:getLeftPosition()
   local rw,rh = self:getSize()
   return rx,ry,rw,rh
end
