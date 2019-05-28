Zombie = Character:extend()

function Zombie:new(x,y,health,speed)
    self.image = love.graphics.newImage("snake.png")
    Zombie.super.new(self,x,y,health,speed)
    self.width = self.image:getWidth()*0.3
    self.height = self.image:getHeight()*0.3
    self.collision = false
end

function Zombie:update(dt,cos,sin)
    self.x = self.x + self.speed * dt * cos
    self.y = self.y + self.speed * dt * sin
    local window_width = love.graphics.getWidth()

    if self.x < 0 then
        self.x = 0
        self.speed=-self.speed
    elseif self.x + self.width > window_width then
        self.x = window_width - self.width
        self.speed=-self.speed
    end
end

function Zombie:draw()
    love.graphics.draw(self.image, self.x, self.y,0,0.3,0.3)
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
end