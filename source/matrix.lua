function Matrix(c, r, value)
    local matrix = {}
    for i = 1, c do
        matrix[i] = {}
        for j = 1, r do
            matrix[i][j] = value
        end
    end
    return matrix
end
