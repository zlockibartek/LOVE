Player=Character:extend()
local pi=math.pi
local rad=math.rad

function Player:new(x,y,health,speed)
  self.image = love.graphics.newImage("panda.png")
  self.immune = false
  Player.super.new(self,x,y,health,speed)
  self.width = self.image:getWidth()/2
  self.height = self.image:getHeight()/2
  self.rotation = 0
  self.gun_x = self.x
  self.gun_y = self.y+self.height
  self.collision = false
end

function Player:draw()
  love.graphics.draw(self.image,self.x,self.y,self.rotation,0.5,0.5,self.width,self.height)
end

function Player:update(dt)
  
  
  if love.keyboard.isDown("left") and love.keyboard.isDown("up") then
    self.x = self.x - self.speed * dt
    self.y = self.y - self.speed * dt
    self.rotation = rad(135)
    self.gun_x = self.x - self.width/2
    self.gun_y = self.y + self.height/2
    
  elseif love.keyboard.isDown("left") and love.keyboard.isDown("down") then
    self.x = self.x - self.speed * dt 
    self.y = self.y + self.speed * dt
    self.rotation = rad(45)
    self.gun_x = self.x - self.width/2
    self.gun_y = self.y + self.height/2
  
  elseif love.keyboard.isDown("right") and love.keyboard.isDown("up") then
    self.y = self.y - self.speed * dt
    self.x = self.x + self.speed * dt
    self.rotation = rad(225)
    self.gun_x = self.x + self.width/2
    self.gun_y = self.y - self.height/2
  
  elseif love.keyboard.isDown("right") and love.keyboard.isDown("down") then
    self.y = self.y + self.speed * dt
    self.x = self.x + self.speed * dt
    self.rotation = rad(315)
    self.gun_x = self.x + self.width/2
    self.gun_y = self.y + self.height/2
  
  elseif love.keyboard.isDown("left") then
    self.x = self.x - self.speed * dt
    self.rotation = rad(90)
    self.gun_x = self.x - self.width/2
    self.gun_y = self.y

  elseif love.keyboard.isDown("right") then
    self.x = self.x + self.speed * dt
    self.rotation = rad(270)
    self.gun_x = self.x + self.width/2
    self.gun_y = self.y
  
  elseif love.keyboard.isDown("down") then
    self.y = self.y + self.speed * dt
    self.rotation = rad(0)
    self.gun_x = self.x
    self.gun_y = self.y + self.height/2
  
  elseif love.keyboard.isDown("up") then
    self.y = self.y - self.speed * dt
    self.rotation = rad(180)
    self.gun_x = self.x
    self.gun_y = self.y - self.height/2
    
  end
  
  local window_height = love.graphics.getHeight()
  local window_width = love.graphics.getWidth()
  
  if self.x < self.width/2 then
    self.x = self.width/2
  elseif self.x + self.width/2 > window_width then
    self.x = window_width - self.width/2
  end
  
  if self.y < self.height/2 then
    self.y = self.height/2
  elseif self.y + self.height/2 > window_height then
    self.y = window_height - self.height/2
  end
  
end

function Player:keyPressed(key)
    if key == "space" then
        table.insert(listOfBullets, Bullet(self.gun_x, self.gun_y))
    end
end

function Player:checkCollision(obj)
    local self_left = self.x
    local self_right = self.x + self.width
    local self_top = self.y
    local self_bottom = self.y + self.height

    local obj_left = obj.x
    local obj_right = obj.x + obj.width
    local obj_top = obj.y
    local obj_bottom = obj.y + obj.height

    if self_right > obj_left and
    self_left < obj_right and
    self_bottom > obj_top and
    self_top < obj_bottom then
      self.collision = true
    end
end