Bullet=Object:extend()
local window_width = love.graphics.getWidth()
local window_height = love.graphics.getHeight()
local sin = math.sin
local cos = math.cos

function Bullet:new(x, y)
    self.image = love.graphics.newImage("bullet.png")
    self.x = x
    self.y = y
    self.speed = 300
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.direction = nil
    self.dead = false
    self.off_screen = false
end

function Bullet:update(dt,rotation)
    if not self.direction then
      self.direction = rotation
    end
    
    self.y = self.y + self.speed * dt * cos(self.direction)
    self.x = self.x + self.speed * dt * -sin(self.direction)
    if self.y > window_width or self.y < 0 or self.x > window_width or self.x < 0 then
        off_screen = true
    end
end

function Bullet:draw()
    love.graphics.draw(self.image, self.x, self.y,self.direction,1,1)
    --love.graphics.rectangle("line",self.x,self.y,self.width,self.height)
end

function Bullet:checkCollision(obj)
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
        self.dead = true
    end
end