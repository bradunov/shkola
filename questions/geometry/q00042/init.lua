
style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};

result = {8,6,6,4,3}

test = {3,4,5,6,7,8}

answ = lib.math.random_shuffle(test)

ind = math.random(5)

for i = 1,6 do
    if(answ[i] == result[ind]) then
	   index = i-1
	end
end	
		 

ow = 20
v = 80


mycanvas = function( )
  lib.start_canvas(300, 200, "center")
  
  lib.add_rectangle (ow, ow, 3*v, 2*v, style, false, false)
 
  if (ind == 1) then
     lib.add_straight_path (ow, ow+v, {{3*v, 0}}, style, false, false)
     lib.add_straight_path (ow + v, ow, {{0, 2*v}}, style, false, false)
     lib.add_straight_path (ow+2*v, ow, {{0, 2*v}}, style, false, false)
  end	

  if (ind == 2) then
     lib.add_straight_path (ow+v, ow+v, {{2*v, 0}}, style, false, false)
     lib.add_straight_path (ow + v, ow, {{0, 2*v}}, style, false, false)
     lib.add_straight_path (ow+2*v, ow, {{0, 2*v}}, style, false, false)
  end	  

  if (ind == 3) then
     lib.add_straight_path (ow, ow+v, {{v, 0}}, style, false, false)
     lib.add_straight_path (ow+2*v, ow+v, {{v, 0}}, style, false, false)    
     lib.add_straight_path (ow + v, ow, {{0, 2*v}}, style, false, false)
     lib.add_straight_path (ow+2*v, ow, {{0, 2*v}}, style, false, false)
  end
  
  if (ind == 4) then
     lib.add_straight_path (ow+v, ow+v, {{2*v, 0}}, style, false, false)
     lib.add_straight_path (ow+v, ow+v, {{0, v}}, style, false, false)
     lib.add_straight_path (ow+2*v, ow, {{0, 2*v}}, style, false, false)
  end	

  if (ind == 5) then
     lib.add_straight_path (ow, ow+v, {{3*v, 0}}, style, false, false)
     lib.add_straight_path (ow+v, ow+v, {{0, v}}, style, false, false)
     lib.add_straight_path (ow+2*v, ow+v, {{0, v}}, style, false, false)
  end	   

  lib.end_canvas()
end        
     