Menu = Object:extend()
local window_width , window_height  = love.window.getDesktopDimensions()

function Menu:new()
  self.border_width = window_width/3
  self.border_height = window_height*(1/8)
  self.border_y = window_height*(1/16)
  self.new_game_x = window_width/3
  self.new_game_y = window_height*(1/16)
  self.continue_x = window_width/3
  self.continue_y = window_height*(5/16)
  self.instruction_x = window_width/3
  self.instruction_y = window_height*(9/16)
  self.quit_x = window_width/3
  self.quit_y = window_height*(13/16)
  self.player = love.graphics.newImage("panda.png")
  self.enemy = love.graphics.newImage("snake.png")
  self.menu_open = true
  self.instruction_open = false
  self.button = 0
  self.game = false
end

function Menu:update(dt)
  if self.button == 0 then
    self.border_y = window_height*(1/16)
  elseif self.button == 1 then
    self.border_y = window_height*(5/16)
  elseif self.button == 2 then
    self.border_y = window_height*(9/16)
  else
    self.border_y = window_height*(13/16)
  end
end

function Menu:draw()

  love.graphics.setColor({127,127,127})
  love.graphics.rectangle("fill",self.new_game_x,self.new_game_y,self.border_width,self.border_height)
  love.graphics.rectangle("fill",self.continue_x,self.continue_y,self.border_width,self.border_height)
  love.graphics.rectangle("fill",self.quit_x,self.quit_y,self.border_width,self.border_height)
  love.graphics.rectangle("fill",self.instruction_x,self.instruction_y,self.border_width,self.border_height)
  
  love.graphics.setColor({0,0,0})
  love.graphics.rectangle("line",self.border_width,self.border_y,self.border_width,self.border_height)
  love.graphics.rectangle("line",self.border_width+1,self.border_y+1,self.border_width-2,self.border_height-2)
  love.graphics.print("New Game", window_width*(4/9), window_height/8)
  love.graphics.print("Continue" , window_width*(4/9), window_height*(6/16))
  love.graphics.print("Instructions" , window_width*(4/9), window_height*(10/16))
  love.graphics.print("Quit" , window_width*(4/9), window_height*(14/16))
  
  love.graphics.setColor({127,127,127})
  love.graphics.draw(self.player,window_width/6,window_height/2)
  love.graphics.draw(self.enemy,window_width*(5/6),window_height/2)

end

function Menu:keyPressed(key)
    if key == "escape" then
      if self.game then
        self.menu_open = not self.menu_open
      end
    end
    
    if key == "return" then
      if self.button == 0 then
        self.menu_open = false
      elseif self.button == 1 then
        self.menu_open = false
      elseif self.button == 2 then
        self.menu_open = false
      else 
        love.event.quit()
      end
    end
    
    if key == "down" then
      self.button = (self.button + 1) % 4
    elseif key == "up" then
      self.button = (self.button - 1) % 4
  end
    
end