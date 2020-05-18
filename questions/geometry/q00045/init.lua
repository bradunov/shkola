include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

diff_style = 
	{["off_color"] = "fff",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
check_style =
        {["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "fff",
        ["line_width"] = "1"};		


choice = math.random(4)
place = array_position[choice] 

out = math.random(2)
figure = part[out]

include("shapes")

mycanvas = function()

  if (out == 1) then
      results = ""
      solutions = ""
      for i = 1,4 do  
          if (i > 1) then
              results = results .. "&& "
              solutions = solutions .. "; "
          end
          results = results .. "result[" .. tostring(i-1) .. "] == "
          solutions = solutions .. "solution[" .. tostring(i-1) .. "] = "
          if (i == choice) then
              results = results .. "1 "
              solutions = solutions .. "1 "
          else
              results = results .. "0 "
              solutions = solutions .. "0 "
          end       
      end
      results = results .. "&& result[4] == 0 && result[5] == 0 && result[6] == 0 && result[7] == 0 && result[8] == 0"	  
      solutions = solutions .. "; solution[4] = 0; solution[5] = 0; solution[6] = 0; solution[7] = 0; solution[8] = 0;"	  
  else
      results = "result[0] == 0 && result[1] == 0 && result[2] == 0 && result[3] == 0 "
      solutions = "solution[0] = 0; solution[1] = 0; solution[2] = 0; solution[3] = 0; "
      for i = 4,7 do  
          results = results .. "&& result[" .. tostring(i) .. "] == "
          solutions = solutions .. "; solution[" .. tostring(i) .. "] = "
          if (i == choice + 3) then
             results = results .. "1 "
             solutions = solutions .. "1 "
          else
             results = results .. "0 "
             solutions = solutions .. "0 "
          end
          if (i == 7 and choice == 4) then
              results = results .. "&& " .. "result[8] == " .. "1" 
              solutions = solutions .. "; " .. "solution[8] = " .. "1" 
          end         
       end
   end  

  -- Example of solution variable representing one valid solution to the question.
  -- solution[i] corrsponds to the same object as result[i]
  -- solution[i] == true means the object is selected, otherwise false
  -- given values of solution should (obviously) satisfy the result condition
  -- In this example, the following simpler version would also work:
  -- lib.start_canvas(300, 250, "center", results)
  -- but there are cases where deriving a solution from results is non-trivial 
  lib.start_canvas(300, 250, "center", results, solutions)

  w = 100
  ow = 40
  for i = 1,3 do
      lib.add_line(ow, ow+(i-1)*w, 2*w, 0, style, false, false)
      lib.add_line(ow+(i-1)*w, ow, 0, 2*w, style, false, false)
  end	

  lib.add_rectangle(ow+5, ow+5, w-10, w-10, check_style, false, true)
  lib.add_rectangle(ow+5, ow+5+w, w-10, w-10, check_style, false, true)
  lib.add_rectangle(ow+w+5, ow+5+w, w-10, w-10, check_style, false, true)
  lib.add_rectangle(ow+w+5, ow+5, w-10, w-10, check_style, false, true)		

  scale = 1.5

  lib.add_triangle (85, 80, 50, 50, diff_style, false, true)
  diamond(lib, 65, 190, scale, diff_style, false, true)
  lib.add_ellipse(190, 190, 35, 20, diff_style, false, true)
  heart(lib, 190, 120, scale, diff_style, false, true)

  lib.end_canvas()
end
                             