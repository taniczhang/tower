require "gimage"

local scene = gamestate.new()
local text = "塔防demo"
local text2 = "请按任意键开始"
local quad = love.graphics.newQuad(104, 577, 270, 136, 1024, 768)


function scene:enter()
	start_texture = love.graphics.newImage("assets/start.png")
	start_object = GImage.new(start_texture,love.graphics.getWidth()/2,love.graphics.getHeight()/2,{0.5,0.5})
end


function scene:draw()
	start_object:draw()
	--love.graphics.setColor(255,255,255,255)
	--love.graphics.printf(text, 0, 200, 800, "center")
	--love.graphics.printf(text2, 0, 250, 800, "center")
	--love.graphics.rectangle("fill",love.graphics.getWidth()/2 - 400/2,love.graphics.getHeight() - 100,400,10)
end


function scene:keypressed(key, unicode)
   --gamestate.switch(gameState.game)
end

function scene:update(dt)
	
end

function scene:mousepressed(x, y, button)
	local rx,ry,rw,rh = start_object:getRect()
	if(x >= rx and y >=ry and x<=rx+rw and y <= ry+rh) then
		gamestate.switch(gameState.game)
	end
end

function scene:mousereleased(x, y, button)
   --gamestate.switch(gameState.game)
end


return scene