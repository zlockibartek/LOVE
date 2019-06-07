local sin = math.sin
local cos = math.cos
local atan2 = math.atan2
local floor = math.floor
local window_width,window_height  = love.window.getDesktopDimensions()
local player_health = 3
local player_speed = 200
local zombie_health = 2
local zombie_speed = 100
local time = love.timer.getTime()
local timer = love.timer.getTime()

function love.load()
  love.window.setFullscreen(true, "desktop")
  Object = require"classic"
  require"character"
  require"menu"
  require"player"
  require"zombie"
  require"bullet"
  require"levels"
  mapa = love.graphics.newImage("mapa.png")
  blood = love.graphics.newImage("blood.png")
  levels = Levels()
  menu = Menu()
  player = Player(window_width/2,window_height/2,player_health,player_speed)
  listOfBullets = {}
  listOfEnemies = {}
  listOfBlood = {}
end


function love.update(dt)
    
    time = love.timer.getTime()
    if not menu.menu_open then
      
      if menu.new_game then 
        for i,v in ipairs(listOfEnemies) do
          listOfEnemies[i] = nil
        end
        
        for i,v in ipairs(listOfBlood) do
          listOfBlood[i] = nil
        end
        
        
        menu.new_game = false
        levels.level = 0
      end
      
      levels:update(dt,#listOfEnemies)
      menu.game = true
      menu.button = 1
      
      if player.health == 0 then
        menu.new_game = true
        menu.menu_open = true
        menu.button = 0
        menu.game = false
      else
        player:update(dt)
        local angle 
        
        if time > timer  then
          player.immune = false
        end
        
        if not player.immune then
          for i,v in ipairs(listOfEnemies) do
            player:checkCollision(v)
            angle = atan2(player.y - v.y, player.x - v.x)
            if player.collision then
              player.health=player.health-1
              player.collision = false
              v:update(dt,-cos(angle),-sin(angle))
              player.immune = true
              timer = love.timer.getTime() + 3
              break
            end
          end
        end
        
        for i,v in ipairs(listOfBullets) do
          v:update(dt,player.rotation)
          for j,l in ipairs(listOfEnemies) do
            v:checkCollision(l)
            
            if v.dead then
              table.remove(listOfBullets, i)
              table.insert(listOfBlood, {listOfEnemies[j].x,listOfEnemies[j].y})
              table.remove(listOfEnemies, j)
              break
            end
        
            if v.off_screen then 
              table.remove(listOfBullets, i)
              break
            end
            
          end
        end
        
        for i,v in ipairs(listOfEnemies) do
          angle = atan2(player.y - v.y, player.x - v.x)
          v:update(dt,cos(angle),sin(angle),angle)
          for j,k in ipairs(listOfEnemies) do
            if i ~= j then
              v:checkCollision(k)
              if v.collision then
                v:update(dt,-cos(angle),-sin(angle),angle)
                if v.direction == "left" then
                  v:update(dt,1,sin(angle),angle)
                elseif v.direction == "right" then
                  v:update(dt,-1,sin(angle),angle)
                elseif v.direction == "top" then
                  v:update(dt,cos(angle),1,angle)
                elseif v.direction == "bottom" then
                  v:update(dt,cos(angle),-1,angle)
                end
                v.collision = false
                break
              end
            end
          end
        end
      end
    else 
      menu:update(dt)
   end
end

function love.draw()
    
    love.graphics.draw(mapa,0,0)
    if menu.menu_open then
      menu:draw()
    else
      levels:draw()
      for i,v in ipairs(listOfBlood) do
        love.graphics.draw(blood,v[1],v[2],0,1,1,60,60)      
      end
      for i,v in ipairs(listOfEnemies) do
    --    love.graphics.print("rabbit " .. listOfEnemies[i].direction, 10, 60+i*10)
      end
--[[      love.graphics.print("x: " .. player.x, 10, 10)
      love.graphics.print("y: " .. player.y, 10, 20)
      love.graphics.print("health: " .. player.health, 10, 30)
      love.graphics.print("width: " .. window_width, 10, 40)
      love.graphics.print("height: " .. window_height, 10, 50)--]]
      if (player.health>0) then
        
        for i,v in ipairs(listOfEnemies) do
          v:draw()
        end
        
        for i,v in ipairs(listOfBullets) do
          v:draw()
        end
        
        if player.immune then
          if floor(time*10) % 2 == 0 then
            player:draw()
          end
        else
          player:draw()
        end
        
      else
        love.graphics.print("GAME OVER", window_width/2, window_height/2)
      end
    end
end

function love.keypressed(key)
    
    
    if menu.menu_open then
      menu:keyPressed(key)
    else
      player:keyPressed(key)
    end
    
end