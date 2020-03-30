style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

check_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f90",
        ["line_color"] = "fff",
        ["line_width"] = "1"};

text_style = {["font_size"] = "14"}


term = {} 
factor = {}
horiz = {}
vert = {}
q = {}


term[1] = 9 + math.random(17);
term[2] = term[1] + math.random(17);
term[3] = term[2] + math.random(17);
term[4] = term[3] + math.random(17);
term[5] = term[4] + math.random(17);

factor = {2, 5, 10}


mycanvas = function()

  --[[ Construct random permutation of object for horiz and vertical inputs ]]

  horiz = lib.math.random_shuffle(factor)
  vert = lib.math.random_shuffle(term)
  

  --[[ Construct results array by comparing where random permutations match ]] 
  ind = 0
  results = ""
  for i = 1,5 do
    for j = 1,3 do
	  numb = vert[i]/horiz[j]
	  rest = math.floor(numb)
	  q[ind] = numb - rest
      if ind > 0 then
        results = results .. "&& "
      end
      results = results .. "result[" .. tostring(ind) .. "] == "
      if (q[ind] == 0) then
        results = results .. "1 "
      else
        results = results .. "0 "
      end
      ind = ind + 1
    end
  end
  

  lib.start_canvas(250, 350, "center", results)

  w = 50
  ow = 30

  for i = 1,5 do
    answ = tostring(math.floor(vert[i]))
    lib.add_line(ow, ow+i*w, 4*w, 0, style, false, false)
    lib.add_text(ow+20, ow+i*w+29,  answ, text_style, false, false)
  end
  lib.add_line(ow, ow+6*w, 4*w, 0, style, false, false)

  for i = 1,3 do
    answ = tostring(math.floor(horiz[i]))
    lib.add_line(ow+i*w, ow, 0, 6*w, style, false, false)
    lib.add_text(ow+i*w+20, ow+20, answ, text_style, false, false)
  end
  lib.add_line(ow+4*w, ow, 0, 6*w, style, false, false)  

  ind = 0
  example_set = false
  for i = 1,5 do
    for j = 1,3 do
      x = i*w + ow + 5
      y = j*w + ow + 5
      if (q[ind] == 0 and not example_set) then
        example_set = true
        lib.add_rectangle(y, x, ow+5, ow+5, check_style, true, true)
      else
        lib.add_rectangle(y, x, ow+5, ow+5, check_style, false, true)
      end
      ind = ind + 1
    end
  end

  lib.end_canvas()
end

      
        
  