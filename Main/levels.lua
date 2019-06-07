Levels = Object:extend()
local window_width,window_height  = love.window.getDesktopDimensions()
local time = love.timer.getTime()
local timer = love.timer.getTime()
local timer1 = 0

function Levels:new()
  self.level = 0
end

function Levels:update(dt,enemies)
  
  time = love.timer.getTime()
  
  if enemies == 0 and timer1 == 0 then
    self.level = self.level + 1
    timer = love.timer.getTime() + 2
    timer1 = love.timer.getTime() + 2
  end
  
  if self.level == 1 and enemies == 0 and time > timer1 then
    player.health = 3
    player.rotation = 0
    player.immune = false
    player.x = window_width/2
    player.y = window_height/2
    for i=1, 8 do
        table.insert(listOfEnemies, Zombie(0,100 + i*100,2,100+i*10))
    end
    
    for i,v in ipairs(listOfBullets) do
      listOfBullets[i] = nil
    end
    timer1 = 0
    
  elseif self.level == 2 and enemies == 0 and time > timer1 then
    
    for i=1, 8  do
        table.insert(listOfEnemies, Zombie(0,100 + i*100,2,100))
        table.insert(listOfEnemies, Zombie(0 + i*100,0,2,100))
    end
    
    for i,v in ipairs(listOfBullets) do
      listOfBullets[i] = nil
    end
    timer1 = 0
    
  elseif self.level == 3 and enemies == 0 and time > timer1 then
    
    for i=1, 8  do
        table.insert(listOfEnemies, Zombie(0,100 + i*100,3,100))
        table.insert(listOfEnemies, Zombie(0 + i*100,0,2,100))
        table.insert(listOfEnemies, Zombie(0 + i*100,window_height,2,100))
    end
    
    for i,v in ipairs(listOfBullets) do
      listOfBullets[i] = nil
    end
    timer1 = 0
    
  elseif self.level == 4 and enemies == 0 and time > timer1 then
    
    for i=1, 8  do
        table.insert(listOfEnemies, Zombie(0,100 + i*100,3,100))
        table.insert(listOfEnemies, Zombie(0 + i*100,0,2,100))
        table.insert(listOfEnemies, Zombie(0 + i*100,window_height,2,100))   
        table.insert(listOfEnemies, Zombie(window_width,100 + i*100,3,100))
    end
    
    for i,v in ipairs(listOfBullets) do
      listOfBullets[i] = nil
    end
    timer1 = 0
    
  elseif self.level == 5 and enemies == 0 and time > timer1 then
    
    for i=1, 12  do
        table.insert(listOfEnemies, Zombie(0,100 + i*100,3,100))
        table.insert(listOfEnemies, Zombie(0 + i*100,0,2,100))
        table.insert(listOfEnemies, Zombie(0 + i*100,window_height,2,100))   
        table.insert(listOfEnemies, Zombie(window_width,100 + i*100,3,100))
    end
    
    for i,v in ipairs(listOfBullets) do
      listOfBullets[i] = nil
    end
    timer1 = 0
    
  else
    
  end
  
end

function Levels:draw()
  
  if timer>time then 
    love.graphics.printf("Level " .. self.level, 0, window_height/8,window_width , "center")
  end
  
end