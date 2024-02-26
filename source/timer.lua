Timer = {}

function Timer.load()
    Timer.time = 0
    Timer.heap = {}
end

function Timer.insert(action, delay, recur)
    recur = recur or 0
    Timer.heap[#Timer.heap+1] = {action = action, time = Timer.time+delay, recur = recur}
    local u = #Timer.heap
    while u > 1 and Timer.heap[u].time < Timer.heap[math.floor(u/2)].time do
        Timer.heap[u], Timer.heap[math.floor(u/2)] = Timer.heap[math.floor(u/2)], Timer.heap[u]
        u = math.floor(u/2)
    end
end

function Timer.perform()
    Timer.heap[1].action()
    if Timer.heap[1].recur == 0 then
        Timer.heap[1] = Timer.heap[#Timer.heap]
        Timer.heap[#Timer.heap] = nil
    else
        Timer.heap[1].time = Timer.heap[1].time + Timer.heap[1].recur
    end

    local valid = false
    local u = 1
    while not valid do
        local max = u
        if 2*u <= #Timer.heap and Timer.heap[2*u].time < Timer.heap[max].time then
            max = 2*u
        end
        if 2*u+1 <= #Timer.heap and Timer.heap[2*u+1].time < Timer.heap[max].time then
            max = 2*u+1
        end
        valid = true
        if max ~= u then
            Timer.heap[u], Timer.heap[max] = Timer.heap[max], Timer.heap[u]
            u = max
            valid = false
        end
    end
end

function Timer.update(dt)
    Timer.time = Timer.time + dt
    while #Timer.heap > 0 and Timer.heap[1].time <= Timer.time do
        Timer.perform()
    end
end
