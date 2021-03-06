--[[

]]
--TODO Export to constant
local enemyScaleVal = .2
local offset = 35

local segNum = 4
local fallcountdownValue = 1;
local moveDelay = .5

Enemy = Class{}

function Enemy:init(i, j, dir, TileGap, TileSize, InitBoardX, InitBoardY)
    self.moveclock = 0
    self.i = i
    self.j = j
    self.dir = dir
    self.tileGap = TileGap
    self.tileSize = TileSize
    self.state = "normal" --Can be normal, dead --TODO: Add faling state
    self.x = InitBoardX+self.i*TileGap+(self.i+.5)*TileSize
    self.y = InitBoardY+self.j*TileGap+(self.j+.5)*TileSize
    self.scale = enemyScaleVal
    self.fallcountdown = fallcountdownValue
end

function Enemy:isMoveTime()
    if self.moveclock >= moveDelay then
        self.moveclock = 0
        return true
    else
        return false
    end
end

function Enemy:update(dt)
    self.moveclock = self.moveclock+dt

    if self.state == "falling" then
        if self.fallcountdown <= 0 then
            self.state = "dead"
            --Reset
            -- self.tile_size = self.tile_start_size
            -- self.fallcountdown = fallcountdownValue
        else
            self.fallcountdown = self.fallcountdown - 1*dt
            self.scale = (self.fallcountdown/fallcountdownValue)*enemyScaleVal
        end
    end
end

function Enemy:setState(stateIn)
    self.state = stateIn
end

function Enemy:getState()
    return self.state
end

function Enemy:getI()
    return self.i
end
function Enemy:getJ()
    return self.j
end

function Enemy:move(dir, BoardCornerX, BoardCornerY)
    if self.state == "falling" or self.state == "dead" then
        return
    end

    if dir == "up" then
        self.j = self.j-1
    elseif dir == "down" then
        self.j = self.j+1
    elseif dir == "left" then
        self.i = self.i - 1
    elseif dir == "right" then
        self.i = self.i + 1
    end

    self.x = BoardCornerX+self.i*TileGap+(self.i+.5)*TileSize
    self.y = BoardCornerY+self.j*TileGap+(self.j+.5)*TileSize
end


function Enemy:autoMove(BoardCornerX, BoardCornerY)
    if self.state == "falling" or self.state == "dead" then
        return
    end

    
    if self.dir == "up" then
        self.j = self.j-1
    elseif self.dir == "down" then
        self.j = self.j+1
    elseif self.dir == "left" then
        self.i = self.i - 1
    elseif self.dir == "right" then
        self.i = self.i + 1
    end

    self.x = BoardCornerX+self.i*TileGap+(self.i+.5)*TileSize
    self.y = BoardCornerY+self.j*TileGap+(self.j+.5)*TileSize

    -- TODO: AI go brr
end

function Enemy:render()
    love.graphics.setColor(255,255,255)
    if self.dir == "left" then
        love.graphics.draw(gTextures['skull_left'], self.x, self.y, 0, self.scale, self.scale, offset, offset)
    else
        love.graphics.draw(gTextures['skull_right'], self.x, self.y, 0, self.scale, self.scale, offset, offset)
    end
    -- love.graphics.circle('fill', self.x, self.y, self.radius, segNum)
end