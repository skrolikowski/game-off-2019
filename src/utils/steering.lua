local Modern   = require 'modern'
local Steering = Modern:extend()

function Steering:new(host)
    self.host = host
end

function Steering:follow()
    local target, last = self.host:nextTarget()
    local steer = Vec2()

    if last then
        steer = self:arrive(target)
    else
        steer = self:seek(target)
    end

    return self.host:applyForce(steer)
end

function Steering:seek(target)
    local desired, steer

    desired = target - self.host.pos
    desired:normalize()
    desired:scale(self.host.maxSpeed)

    steer = desired - self.host.vel
    steer:limit(self.host.maxForce)

    return steer
end

function Steering:arrive(target)
    if target then
        local desired  = target - self.host.pos
        local distance = desired:magnitude()
        local stopDist = Config.map.cell.size / 2
        local maxSpeed = self.host.maxSpeed
        local steer

        if distance <= stopDist then
            maxSpeed = _:mapTo(distance, 0, stopDist, 0, maxSpeed)
        end

        desired:normalize()
        desired:scale(maxSpeed)

        steer = desired - self.host.vel
        steer:limit(self.host.maxForce)

        return steer
    end
end

return Steering