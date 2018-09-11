path = string.sub(...,1,-5)

gamestate= require (path.."hump/gamestate")
mainFont = love.graphics.newFont("assets/xiheiti.ttf", 32)
--fix height
scaleY = love.graphics.getHeight()/640

scaleX = scaleY

fixX = (love.graphics.getWidth()/scaleX - 960)/2

print(fixX)

function love.load()
	local exists = love.filesystem.exists("game.data")
	if not exists then
		file = love.filesystem.newFile("game.data","w")
		file:close()
	end
	--print(exists)
    gameState={}
    for _,name in ipairs(love.filesystem.getDirectoryItems(path.."scene")) do
        gameState[name:sub(1,-5)]=require(path.."scene."..name:sub(1,-5))
    end
	--设置字体
	love.graphics.setFont(mainFont)
    gamestate.registerEvents()
    gamestate.switch(gameState.intro)
	--love.graphics.scale(scaleX,1)
end

function love.update(dt) 
	--delay:update(dt) 
end