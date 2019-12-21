style = {["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "000",
        ["line_width"] = "2"};

check_style =
        {["off_color"] = "eee",
        ["on_color"] = "6f6",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

checked_style =
        {["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

line_style =
        {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "3"};



directions = {
    {"levo", "desno", "pravo"}, 
    {"pravo", "desno", "levo"}, 
    {"desno", "pravo", "levo"}, 
    {"desno", "levo", "pravo"}
}

all_indices = {
    {[3] = true, [16] = true, [20] = true},
    {[17] = true, [7] = true, [22] = true},
    {[4] = true, [5] = true, [19] = true},
    {[4] = true, [18] = true, [22] = true}
}


index = math.random(4)
print("I: ", index)


position = directions[index]
indices = all_indices[index]

results = ""
for i = 0,23 do
    if i > 0 then
        results = results .. " && "
    end
    if indices[i] then 
        results = results .. " result[" .. tostring(i) .. "] == 1 "
    else
        results = results .. " result[" .. tostring(i) .. "] == 0 "
    end
end




mycanvas = function(results)
    lib.start_canvas(390, 390, "center", results)

    lib.add_rectangle (30, 30, 350, 350, style, false, false)

    nx = 3
    ny = 3

    sqw = 50
    rw = 30
    rl = 70

    for x = 0,nx do
        for y = 0,(ny-1) do
            lib.add_rectangle(40+x*100, 70+y*100, rw, rl, check_style, false, true)
        end
    end

    for x = 0,(nx-1) do
        for y = 0,ny do
            lib.add_rectangle(70+x*100, 40+y*100, rl, rw, check_style, false, true)
        end
    end

    for x = 0,(nx-1) do
        for y = 0,(ny-1) do
            lib.add_rectangle (80+x*100, 80+y*100, sqw, sqw, style, true, false)
        end
    end

    lib.add_rectangle(70, 40+100, rl, rw, checked_style, true, false)
    lib.add_straight_path (100, 155, {{20, 0}, {0, -5}, {15, 5}, {-15, 5}, {0, -5}},
    line_style, true, false)

    lib.end_canvas()
end
