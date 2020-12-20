
line_blue = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "0cf",
        ["line_width"] = "3"};

line_pink = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "f9c",
        ["line_width"] = "3"};
		
line_brown = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "c90",
        ["line_width"] = "3"};	
		
colour_style = {["off_color"] = "fff",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "0.1"};	

text_style = {["font_size"] = "16"}	

bracketl = "{"
bracketr = "}"
uni = "\(\cup\)"  
sect = "\(\cap\)"
dif = "\"

dim1 = 7
dim2 = 5
dim = dim1 * dim2

index = math.random(11)

q = {}
for i = 1,dim do
    q[i] = 0
end	

imin = 0
imax = 0
jmin = 0
jmax = 0
if (index == 1) then                  --[[(AuB)pC ]]--
    quest = "(A " .. uni .. " B) " .. sect .. " C"     
    for j = 3, 4 do 
	    if (j == 4) then
		    imax = 4
		else
            imax = 6		
		end	
	    for i = 3, imax do
		    k = (j-1)*dim1 + i
		    q[k] = 1
		end
    end		
end

if (index == 2) then                  --[[Ap(B\C) ]]--
    quest = "A " .. sect .. " (B " .. dif .. " C)"        
    q[11] = 1
end

if (index == 3) then                  --[[ Cu(ApB) ]]--
    quest = "C " .. uni .. " (A " .. sect .. " B)"     
	q[11] = 1
    for j = 3, 5 do 
	    for i = 3, 6 do
		    k = (j-1)*dim1 + i
		    q[k] = 1
		end
    end		
end

if (index == 4) then                  --[[ (A\B)pC ]]--
    quest = "(A " .. dif .. " B) " ..  sect .. " C"     
	q[17] = 1	
    q[24] = 1
    q[25] = 1	
end

if (index == 5) then                  --[[ (AuB)\C ]]--
    quest = "(A " .. uni .. " B) " ..  dif .. " C"  
    q[21] = 1   	
    for j = 1, 4 do 
	    if (j == 1) then
		    imin = 4
		else
            imin = 1		
		end	
	    if (j > 2) then
		    imax = 2
		else
		    imax = 7		
		end			
	    for i = imin, imax do
		    k = (j-1)*dim1 + i
		    q[k] = 1
		end
    end		
end

if (index == 6) then                  --[[ (C\A)u(B\C) ]]--
    quest = "(C " .. dif .. " A) " ..  uni .. " (B " ..  dif .. " C)"     	
    for j = 1, 5 do 
	    if (j < 3) then
		    imin = 4
		else
		    if (j == 5) then 
                imin = 3
            else
                imin = 5
            end				
		end	
	    if (j < 4) then
		    imax = 7
		else
		    imax = 6		
		end			
	    for i = imin, imax do
		    k = (j-1)*dim1 + i
		    q[k] = 1
		end
    end		
end

if (index == 7) then                  --[[ (ApB)\(BpC) ]]--
    quest = "(A " .. sect .. " B) " ..  dif .. " (B " .. sect .. " C)"
    q[11] = 1   		
end

if (index == 8) then                  --[[ (A\B)u(A\C) ]]--
    quest = "(A " .. dif .. " B) " ..  uni .. " (A " .. dif .. " C)"
    for j = 2, 4 do 
	    if (j == 3) then
		    imax = 3
		else
            imax = 4
        end			
	    for i = 1, imax do
		    k = (j-1)*dim1 + i
		    q[k] = 1
		end
    end	   		
end

if (index == 9) then                  --[[ (AuB)\(AuC) ]]--
    quest = "(A " .. uni .. " B) " ..  dif .. " (A " .. uni .. " C)"
    for j = 1, 3 do 
	    if (j == 1) then
		    imin = 4
		else
	        if (j == 2) then		
                imin = 5
			else
                imin = 7
            end				
        end			
	    for i = imin, 7 do
		    k = (j-1)*dim1 + i
		    q[k] = 1
		end
    end	   		
end

if (index == 10) then                  --[[ (ApB)u(A\C) ]]--
    quest = "(A " .. sect .. " B) " ..  uni .. " (A " .. dif .. " C)"
    q[18] = 1
    for j = 2, 4 do 
	    if (j == 2) then
		    imax = 4
		else
            imax = 2				
        end			
	    for i = 1, imax do
		    k = (j-1)*dim1 + i
		    q[k] = 1
		end
    end	   		
end

if (index == 11) then                  --[[  (AuB)\(ApC)\(BpC) ]]--
    quest = "(A " .. uni .. " B) " ..  dif .. " (A " .. sect .. " C)" ..  dif .. " (B " .. sect .. " C)"
    q[21] = 1
    for j = 1, 4 do 
	    if (j == 1) then
		    imin = 4
		else
            imin = 1				
        end	
	    if (j < 3) then
		    imax = 7
		else
            imax = 2				
        end					
	    for i = imin, imax do
		    k = (j-1)*dim1 + i
		    q[k] = 1
		end
    end	   		
end
 

mycanvas = function( )

  results = ""
  for i = 1,dim do  
    if (i > 1) then
      results = results .. "&& "
    end
    results = results .. "result[" .. tostring(i-1) .. "] == "
      if (q[i] == 1) then
        results = results .. "1 "
      else
        results = results .. "0 "
      end
  end


  lib.start_canvas(320, 250, "center", results)
  
  w = 5
  ow = 30
  v = 40
  ov = 10
 
  for j = 1,dim2 do
	  for i = 1,dim1 do
           lib.add_rectangle (ow+(i-1)*v, ov+(j-1)*v, v, v, colour_style, false, true)
	  end	  
  end

  lib.add_rectangle (ow, ov+v, 4*v, 3*v, line_blue, true,  false )
  lib.add_text(ov+w, 2*ow, "A", text_style, false, false)	
  lib.add_rectangle (ow+3*v, ov, 4*v, 3*v, line_pink, true,  false )
  lib.add_text(ov+3*v+w, 2*ov, "B", text_style, false, false)
  lib.add_rectangle (ow+2*v, ov+2*v, 4*v, 3*v, line_brown, true,  false )
  lib.add_text(ov+2*v+w, 5*v, "C", text_style, false, false)
  
  lib.end_canvas()
end
   