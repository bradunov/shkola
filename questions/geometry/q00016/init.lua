
style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};
		
colour_style = {["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};		

square = 0
rect = 0

hor = {}
vert = {}
q = {}

for i = 1,3 do
    q[i] = {}
    for j = 1,3 do	
	    q[i][j] = math.random(2)
		if (q[i][j] == 2) then
		    square = square + 1
		end	
	end		
end

for i = 1,3 do
    hor[i] = q[1][i]
    for j = 2,3 do
        hor[i] = hor[i] * 10  + q[j][i]
	end	
end	

for i = 1,3 do
    vert[i] = q[i][1]
    for j = 2,3 do
        vert[i] = vert[i] * 10  + q[i][j]
	end	
end	

if (hor[2] ~= 111 or vert[2] ~= 111) then
    for i = 1,3 do
        if(hor[i] == 221 or hor[i] == 122) then
           rect = rect + 1
	    end
	    if(hor[i] == 222) then
           rect = rect + 3
	    end
    end

    for i = 1,3 do
        if(vert[i] == 221 or vert[i] == 122) then
           rect = rect + 1
	    end
	    if(vert[i] == 222) then
           rect = rect + 3
	    end
    end
end

if (hor[2] ~= 111 and vert[2] ~= 111) then
    for i = 1,2 do
        if(hor[i] == 221 and hor[i+1] == 221) then
           square = square + 1
	    end
        if(hor[i] == 122 and hor[i+1] == 122) then
           square = square + 1
	    end
    end
	for i = 1,2 do
        if(hor[i] == 222)then 
           if(hor[i+1] == 221 or hor[i+1] == 122) then
              square = square + 1
		   end	  
	    end		  
	end		
	for i = 1,2 do
	    j = 4 - i
        if(hor[j] == 222)then 
           if(hor[j-1] == 221 or hor[j-1] == 122) then
              square = square + 1
		   end	  
	    end		  
	end		
	for i = 1,2 do
        if(hor[i] == 222)then 
           if(hor[i+1] == 222) then
              square = square + 2
			  rect = rect + 1
		   end	  
	    end	
        if(vert[i] == 222)then 
           if(vert[i+1] == 222) then
			  rect = rect + 1
		   end	  
	    end			
	end	
    if(hor[1] == 222) then 
	   if(hor[2] == 222) then
	      if(hor[3] == 222) then  
             square = square + 1
		  end
	   end	  
    end
end

		 
w = 5
ow = 20
v = 80
ov = 240

mycanvas = function( )
  lib.start_canvas(300, 300, "center")
 
  for i = 1,3 do
      for j = 1,3 do
	      if(q[i][j] == 2) then
             lib.add_rectangle (ow+(i-1)*v, ow+(j-1)*v, v, v, colour_style, true, false)
	      else
             lib.add_rectangle (ow+(i-1)*v, ow+(j-1)*v, v, v, style, true, false)		  
		  end
	  end	  
  end
  
  lib.end_canvas()
end
    