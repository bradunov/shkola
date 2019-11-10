style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

full_style = 
	{["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

empty_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

check_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["off_line_color"] = "ccc",
        ["line_width"] = "2"};





--[[ Plot one element at (x, y):
     type == 1 (empty triangle), 2 (full triangle),
             3 (empty square), 4 (full square)
  ]]
element = function(x, y, type)
    if (type == 1 or type == 2) then
      mx = x + w/2
      my = y + w/2
      if (type == 1) then
        lib.add_triangle(mx, my, ow, ow, empty_style, false, false)
      else
        lib.add_triangle(mx, my, ow, ow, full_style, false, false)
      end
    else
      mx = x + (w-ow)/2
      my = y + (w-ow)/2
      if (type == 3) then
        lib.add_rectangle(mx, my, ow, ow, empty_style, false, false)
      else
        lib.add_rectangle(mx, my, ow, ow, full_style, false, false)
      end
    end
end


mycanvas = function()

  --[[ Construct random permutation of object for horiz and vertical inputs ]]
  test = {1, 2, 3, 4}
  horiz = lib.math.random_shuffle(test)
  vert = lib.math.random_shuffle(test)


  --[[ Construct results array by comparing where random permutations match ]] 
  results = ""
  for i = 1,4 do
    for j = 1,4 do
      ind = (i-1)*4 + (j-1)
      if ind > 0 then
        results = results .. "&& "
      end
      results = results .. "result[" .. tostring(ind) .. "] == "
      if (horiz[i] == vert[j]) then
        results = results .. "1 "
      else
        results = results .. "0 "
      end
    end
  end
  

  lib.start_canvas(500, 300, "center", results)

  w = 60
  ow = 40
  for i = 1,4 do
    lib.add_line(0, i*w, 5*w, 0, style, false, false)
    lib.add_line(i*w, 0, 0, 5*w, style, false, false)
    element(0, i*w, vert[i])
    element(i*w, 0, horiz[i])
  end

  for i = 1,4 do
    for j = 1,4 do
      x = i*w + (w-ow)/2
      y = j*w + (w-ow)/2
      lib.add_check_box(x, y, ow, ow, check_style, false, true)
    end
  end

  lib.end_canvas()
end


