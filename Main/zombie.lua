Zombie = Character:extend()
local window_width = love.graphics.getWidth()

function Zombie:new(x,y,health,speed)
    self.image = love.graphics.newImage("2.png")
    Zombie.super.new(self,x,y,health,speed)
    self.width = self.image:getWidth()*0.5
    self.height = self.image:getHeight()*0.5
    self.prev_x = x
    self.prev_y = y
    self.rotation = 0
    self.direction = "bottom"
    self.collision = false
end

function Zombie:update(dt,cos,sin,angle)
    self.prev_x = self.x
    self.prev_y = self.y
    self.x = self.x + self.speed * dt * cos
    self.y = self.y + self.speed * dt * sin
    self.rotation = angle
      
    if self.x < 0 then
        self.x = 0
        self.speed=-self.speed
    elseif self.x + self.width > window_width then
        self.x = window_width - self.width
        self.speed=-self.speed
    end
end

function Zombie:draw()
    love.graphics.draw(self.image, self.x, self.y,self.rotation,0.5,0.5,self.width,self.height)
    --love.graphics.rectangle("line",self.x,self.y,self.width,self.height)
end

function Zombie:checkCollision(obj)
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
      
    if self.collision then
      if self.prev_y + self.height < obj_top and
      self.prev_x + self.width < obj_left then
        self.direction = "bottom-right"
      elseif self.prev_y > obj_bottom and
      self.prev_x > obj_right then
        self.direction = "top-left"
      elseif self.prev_x + self.width < obj_left and 
      self.prev_y > obj_bottom then
        self.direction = "top-right"
      elseif self.prev_x > obj_right and 
      self.prev_y + self.height < obj_top then
        self.direction = "bottom-left"
      elseif self.prev_y + self.height < obj_top then
        self.direction = "bottom"
      elseif self.prev_y > obj_bottom then
        self.direction = "top"
      elseif self.prev_x + self.width < obj_left then
        self.direction = "right"
      elseif self.prev_x > obj_right then
        self.direction = "left"
      end
    end
end