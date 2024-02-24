Animation = {}

function Animation.load()
    Animation.time = 0
end

function Animation.update(dt)
    Animation.time = (Animation.time + dt) % 100
end

function Animation.getPhase(phaseTime, maximalPhase, phaseOffset, timeOffset)
    phaseOffset = phaseOffset or 0
    timeOffset = timeOffset or 0
    local phase  = math.floor((Animation.time + timeOffset) / phaseTime)
    phase = phase + phaseOffset
    phase = phase % maximalPhase
    phase = phase + 1
    return phase
end
