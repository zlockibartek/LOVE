Character = Object:extend()

function Character:new(x,y,health,speed)
  self.x=x
  self.y=y
  self.health=health
  self.speed=speed
end
