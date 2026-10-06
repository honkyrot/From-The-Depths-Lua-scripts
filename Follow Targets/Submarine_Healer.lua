-- code built for a submarine with heal tentacles that seek out friendly ships.
-- up to you to try it on other ships
-- sub will prioritize healing the friendly ship with the lowest health fraction that is below the HEAL_THRESHOLD.

-- Version 2.0
-- Follows flagship if no injured surface ships are found if in fleet

-- Version 1.0
-- initial

-- issues
-- ignores closer ships that are more injured when locked onto a target, no matter the distance!
-- airships cannot use six axis right now.

--global
local currentTargetId = -1
local follow_flagship = true -- follows flagship IF there's no targets.
local HEAL_THRESHOLD = 0.97 -- set your heal threshold
local write_to_hud = false -- set to true to write logs to the HUD, false to write to the console

function Update(I)
    I:ClearLogs()
    local myId = I:GetUniqueId()
    local myPos = I:GetConstructCenterOfMass()
    local bestTarget = nil
    
    -- stick to current target when applicable
    if currentTargetId ~= -1 then
        -- fetch the specific friendly by its ID
        local friendlyInfo = I:GetFriendlyInfoById(currentTargetId)
        
        -- check if it still exists and still needs healing
        if friendlyInfo.Valid and friendlyInfo.HealthFraction < HEAL_THRESHOLD then
            bestTarget = friendlyInfo
        else
            -- if valid or full health, reset target
            currentTargetId = -1
        end
    end
    
    -- scan for new targets if we don't have a valid one
    if currentTargetId == -1 then
        local lowestHealth = 1.0
        local friendlyCount = I:GetFriendlyCount()
        
        for i = 0, friendlyCount - 1 do
            local friendly = I:GetFriendlyInfo(i)
            
            if friendly.Valid and friendly.Id ~= myId then
                local alt = friendly.CenterOfMass.y
                
                -- checks for only surface ships (altitude between -10 and 20 meters)
                if alt > -10 and alt < 20 then
                    -- only pick the friendly with the lowest health fraction that is below the heal threshold
                    if friendly.HealthFraction < lowestHealth and friendly.HealthFraction < HEAL_THRESHOLD then
                        lowestHealth = friendly.HealthFraction
                        bestTarget = friendly
                    end
                end
            end
        end
        
        -- save the best target's ID for next update
        if bestTarget ~= nil then
            currentTargetId = bestTarget.Id
        end
    end

    -- if we do not have a valid target, start 'follow_flagship' behavior
    -- check if we are in a fleet
    local fleetInfo = I.Fleet
    local flagship = fleetInfo.Flagship

    if bestTarget == nil and follow_flagship and flagship.Valid then
        -- flagship cannot be itself
        if flagship.Id ~= myId then
            I:Log("Following Flagship: " .. flagship.BlueprintName)
            bestTarget = flagship
            currentTargetId = flagship.Id
        else
            I:Log("Flagship is self, not following.")
        end
    end
    
    -- movement to our target
    if bestTarget ~= nil then
        I:TellAiThatWeAreTakingControl()

        if write_to_hud then
            I:LogToHud("Locked on & Healing: " .. bestTarget.BlueprintName .. " (" .. math.floor(bestTarget.HealthFraction * 100) .. "%)")
        else
            I:Log("Locked on & Healing: " .. bestTarget.BlueprintName .. " (" .. math.floor(bestTarget.HealthFraction * 100) .. "%)")
        end

        local targetPos = bestTarget.CenterOfMass
        local dx = targetPos.x - myPos.x
        local dz = targetPos.z - myPos.z
        local dist = math.sqrt(dx*dx + dz*dz)
        
        local myRight = I:GetConstructRightVector()
        local dirX = dx / dist
        local dirZ = dz / dist
        
        local yawCommand = (dirX * myRight.x) + (dirZ * myRight.z)
        yawCommand = math.max(-1, math.min(1, yawCommand * 5))
        
        I:SetPropulsionRequest(5, yawCommand)
        
        -- speed control based on distance to target
        if dist > 50 then
            I:SetPropulsionRequest(6, 1)
        else
            I:SetPropulsionRequest(6, 0.1)
        end
        
    else
        -- idle behavior when no target is found
        if write_to_hud then
            I:LogToHud("No injured surface ships found.")
        else
            I:Log("No injured surface ships found.")
        end
    end
end