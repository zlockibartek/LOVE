local sin = math.sin
local cos = math.cos
local atan2 =math.atan2
local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()
local player_health = 10
local player_speed = 200
local zombie_health = 2
local zombie_speed = 100


function love.load()
  love.window.setFullscreen(true, "desktop")
  Object = require"classic"
  require"character"
  require"player"
  require"zombie"
  require"bullet"
  player=Player(window_width/2,window_height/2,player_health,player_speed)
  listOfBullets={}
  listOfEnemies={Zombie(325,400,zombie_health,zombie_speed+40),Zombie(325,300,zombie_health,zombie_speed),Zombie(325,600,zombie_health,zombie_speed),Zombie(325,500,zombie_health,zombie_speed+10),Zombie(325,100,zombie_health,zombie_speed+20),Zombie(325,200,zombie_health,zombie_speed+30)}
end


function love.update(dt)
    player:update(dt)
    local angle 
    
    if player.immune > 0 then  
      for i,v in ipairs(listOfEnemies) do
        player:checkCollision(v)
        angle = atan2(player.y - v.y, player.x - v.x)
        if player.collision then
           player.health=player.health-1
           v:update(dt,-cos(angle),-sin(angle))
           player.immune = 100
           break
        end
      end
    end
    
    for i,v in ipairs(listOfEnemies) do
        angle = atan2(player.y - v.y, player.x - v.x)
        v:update(dt,cos(angle),sin(angle))
        for j,k in ipairs(listOfEnemies) do
        if i ~= j then
          v:checkCollision(k)
          if v.collision then
            v:update(dt,-cos(angle),-sin(angle))
            v.collision = false
            break
          end
        end
      end
    end
  
    for i,v in ipairs(listOfBullets) do
      v:update(dt,player.rotation)
      for j,l in ipairs(listOfEnemies) do
        v:checkCollision(l)
        
        if v.dead then
          table.remove(listOfBullets, i)
          table.remove(listOfEnemies, j)
          break
        end
    
        if v.off_screen then 
          table.remove(listOfBullets, i)
          break
        end
        
      end
    end
end

function love.draw()
    love.graphics.setBackgroundColor(153/255,102/255, 54/255, 1)
    love.graphics.print("x: " .. player.x, 10, 10)
    love.graphics.print("y: " .. player.y, 10, 20)
    love.graphics.print("immune: " .. player.immune, 10, 30)
    if (player.health>0) then
      if player.immune%2==0 then 
      player:draw()
      end
    
      for i,v in ipairs(listOfEnemies) do
        v:draw()
      end
      
      for i,v in ipairs(listOfBullets) do
        v:draw()
      end
    else
      love.graphics.print("GAME OVER", window_width/2, window_height/2)
    end
end

function love.keypressed(key)
    player:keyPressed(key)
    if key == "escape" then
        love.event.quit()
    end
end