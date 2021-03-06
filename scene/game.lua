require "towerPos"
require "gimage"
require "tower"
require "enemy"
require "bullet"
require "road"
local level1 = require "level1"

local scene = gamestate.new()
gtimer = require ("hump.timer")
momey = 30

function scene:enter()

	bg_texture = love.graphics.newImage("assets/bg-hd.png")
	spot_texture = love.graphics.newImage("assets/open_spot-hd.png")
	tow_texture = love.graphics.newImage("assets/tower-hd.png")
	bullet_texture = love.graphics.newImage("assets/bullet-hd.png")
	enemy_texture = love.graphics.newImage("assets/enemy-hd.png")
	
	bg_object = GImage.new(bg_texture,love.graphics.getWidth()/2,love.graphics.getHeight()/2,{0.5,0.5})
	
	spot_list = {}
	
	for key, value in ipairs(towerPosition) do 
		local tmpImage = GImage.new(spot_texture,value.x,value.y,{0.5,0.5}) --图片中心
		local tmpObj = {}
		tmpObj.image = tmpImage
		tmpObj.flag = false
		spot_list[key] = tmpObj
	end 
	
	tower_list = {}
	
	enemy_list = {}
	
	bullet_list = {}
	
	--测试 每隔T秒一波怪
	--[[
	gtimer.every(1, function() 
		local enemyImage = GImage.new(enemy_texture,road[1].x1,road[1].y1,{0.5,0.5}) --图片中心
		local enemyOjb = Enemy:new()
		enemyOjb:setImage(enemyImage)
		table.insert(enemy_list,#enemy_list+1,enemyOjb)
	end,5) --最后一个参数为总波数 --]]
	for key, value in ipairs(level1) do 
		local count = value.number
		local iterval = value.iterval
		local delay = value.delay
		
		gtimer.after(delay,function()
			gtimer.every(iterval, function() 
				local enemyImage = GImage.new(enemy_texture,road[1].x1,road[1].y1,{0.5,0.5}) --图片中心
				local enemyOjb = Enemy:new()
				enemyOjb:setImage(enemyImage)
				table.insert(enemy_list,#enemy_list+1,enemyOjb)
			end,count) 
		end)
	end
	

end


function scene:update(dt)
	gtimer.update(dt)
	for key, value in ipairs(tower_list) do  
		value:update(dt)
	end 
	
	for key, value in ipairs(enemy_list) do  
		if not value:update(dt) then
			table.remove(enemy_list,key)
		end
	end 
	
	for key, value in ipairs(bullet_list) do  
		if not value:update(dt) then
			table.remove(bullet_list,key)
		end
	end 
	
end

function scene:draw()
	love.graphics.setColor(255,255,255,255)
	--love.graphics.scale(scaleX,scaleY)
	--画出背景
	bg_object:draw()
	
	--love.graphics.draw(bg_texture,love.graphics.getWidth()/2,love.graphics.getHeight()/2,0,scaleX,scaleY,bg_texture:getData():getWidth()/2,bg_text--ure:getData():getHeight()/2)
	
	--画出放置点
	for key, value in ipairs(spot_list) do  
		value.image:draw()
	end 
	
	--画坦克
	for key, value in ipairs(tower_list) do  
		--print(key..","..value)
		value:draw()
	end 
	
	--画敌人
	for key, value in ipairs(enemy_list) do  
		--print(key..","..value)
		value:draw()
	end 
	
	--子弹
	for key, value in ipairs(bullet_list) do  
		--print(key..","..value)
		value:draw()
	end 
	
	--线路图
	love.graphics.setColor(255,127,0,255)
	for key, value in ipairs(road) do  
		love.graphics.line( value.x1, value.y1, value.x2, value.y2 )
	end
	
end

function scene:mousepressed(x, y, button, istouch)
   if button == 1 then -- 左键按下
		if(momey >= 10 ) then
			for key, value in ipairs(spot_list) do  
				local rx,ry,rw,rh = value.image:getRect()
				if(x >= rx and y >=ry and x<=rx+rw and y <= ry+rh and not value.flag) then
					value.flag = true
					--初始化一台坦克
					local posX,posY = value.image:getPosition()
					tankImage = GImage.new(tow_texture,posX,posY,{0.5,0.5}) --图片中心
					tankOjb = Tower:new()
					tankOjb:setImage(tankImage)
					table.insert(tower_list,#tower_list+1,tankOjb)
					tankOjb:setEmeryList(enemy_list)
					momey = momey - 10
					break;
				end
		end  --end if momey
		end
   end
end

return scene




