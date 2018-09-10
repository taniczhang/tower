path = string.sub(...,1,-5)

gamestate= require (path.."hump/gamestate")
mainFont = love.graphics.newFont("assets/xiheiti.ttf", 32)
scaleX,scaleY = love.graphics.getWidth()/960, love.graphics.getHeight()/640
function love.load()
    gameState={}
    for _,name in ipairs(love.filesystem.getDirectoryItems(path.."scene")) do
        gameState[name:sub(1,-5)]=require(path.."scene."..name:sub(1,-5))
    end
	--设置字体
	love.graphics.setFont(mainFont)
    gamestate.registerEvents()
    gamestate.switch(gameState.intro)
end

function love.update(dt) 
	--delay:update(dt) 
end