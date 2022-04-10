
style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};

grid_style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};	
							
text_style = {["font_size"] = "16"}

meas =  {"cm", "cm\(\small^2\)"}

numb = {}


dim = math.random(5)
dim2 = dim * dim
root2 = lib.math.round_dec(math.sqrt(2),3)
root3 = lib.math.round_dec(math.sqrt(3),3)	
con = lib.math.round_dec(math.pi/180, 3)

ind = math.random(15)

if (ind == 1) then
    numb[1] = math.sqrt(4^2+6^2)
	numb[1] = lib.math.round_dec(numb[1],3)		
    numb[2] = 5
    numb[3] = math.sqrt(3^2+4^2)
	numb[3] = lib.math.round_dec(numb[3],3)	
    numb[4] = math.sqrt(3^2+6^2)
	numb[4] = lib.math.round_dec(numb[4],3)	
	numb[5] = 5
    numb[6] = 6 * root2 
	circ = 0
	for i = 1,6 do
        circ = circ + numb[i]
	end
    circ = circ * dim	
    area = 0.5 * 10 *(6 + 3) + 10 * 5
    area = area * dim2
end	
if (ind == 2) then
    numb[1] = math.sqrt(3^2+6^2)
	numb[1] = lib.math.round_dec(numb[1],3)		
    numb[2] = math.sqrt(10^2+6^2)
	numb[2] = lib.math.round_dec(numb[2],3)	
    numb[3] = math.sqrt(7^2+4^2)
	numb[3] = lib.math.round_dec(numb[3],3)	
    numb[4] = math.sqrt(6^2+2^2)
	numb[4] = lib.math.round_dec(numb[4],3)
    numb[5] = 2 
	circ = 0
	for i = 1,5 do
        circ = circ + numb[i]
	end
    circ = circ * dim	
    area = 0.5 * 13 * 6 + 0.5 * 4 * 7 + 0.5 * (4 + 2) * 6
    area = area * dim2	
end	
if (ind == 3) then
    numb[1] = math.sqrt(3^2+6^2)
	numb[1] = lib.math.round_dec(numb[1],3)	
    numb[2] = 14	
    numb[3] = math.sqrt(5^2+6^2)
	numb[3] = lib.math.round_dec(numb[3],3)	
    numb[4] = math.sqrt(3^2+4^2)
	numb[4] = lib.math.round_dec(numb[4],3)
    numb[5] = 11	
    numb[6] = math.sqrt(2^2+4^2)
	numb[6] = lib.math.round_dec(numb[6],3)
	circ = 0
	for i = 1,6 do
        circ = circ + numb[i]
	end
    circ = circ * dim	
    area = 0.5 * (14 + 6) * 6 + 0.5 * (6 + 11) * 4
    area = area * dim2	
end	
if (ind == 4) then
    numb[1] = math.sqrt(10^2+4^2)
	numb[1] = lib.math.round_dec(numb[1],3)	
    numb[2] = math.sqrt(2^2+7^2)
	numb[2] = lib.math.round_dec(numb[2],3)		
    numb[3] = math.sqrt(3^2+7^2)
	numb[3] = lib.math.round_dec(numb[3],3)	
    numb[4] = 10
    numb[5] = 14	
	circ = 0
	for i = 1,5 do
	    if (i == 2 or i == 3) then
		    coef = 2
		else
            coef = 1
        end			
        circ = circ + coef * numb[i]
	end
    circ = circ * dim	
    area = 0.5 * (14 + 10) * 10 - 5 * 7
    area = area * dim2	
end	
if (ind == 5) then
    numb[1] = math.sqrt(3^2+5^2)
	numb[1] = lib.math.round_dec(numb[1],3)		
    numb[2] = 11    
	circ = 4 * numb[1] + 2 * numb[2]
    circ = circ * dim	
    area = 11 * 10
    area = area * dim2
end	
if (ind == 6) then
    numb[1] = 4 * root2	
    numb[2] = math.sqrt(14^2+4^2)
	numb[2] = lib.math.round_dec(numb[2],3)	
    numb[3] = math.sqrt(4^2+6^2)
	numb[3] = lib.math.round_dec(numb[3],3)	
	numb[4] = 6 
	numb[5] = 6	
	circ = 0
	for i = 1,5 do
        circ = circ + numb[i]
	end
    circ = circ * dim	
    area = 0.5 * (10 + 6) * 6 + 0.5 * 10 * 4
    area = area * dim2
end	
if (ind == 7) then
    numb[1] = math.sqrt(12^2+10^2)
	numb[1] = lib.math.round_dec(numb[1],3)		
    numb[2] = math.sqrt(10^2+2^2)
	numb[2] = lib.math.round_dec(numb[2],3)	
	numb[3] = 4	
    numb[4] = math.sqrt(2^2+4^2)
	numb[4] = lib.math.round_dec(numb[4],3)	 
	numb[5] = 2	
	circ = 0
	for i = 1,5 do
	    if ( i == 3 or i == 4) then 
	       coef = 2
		else
	       coef = 1
        end		
        circ = circ + coef * numb[i]
	end
    circ = circ * dim	
    area = 0.5 * 10 * 10 - 2 * 4
    area = area * dim2
end	
if (ind == 8) then
    numb[1] = math.sqrt(6^2+4^2)
	numb[1] = lib.math.round_dec(numb[1],3)	
    numb[2] = 4 
    numb[3] = 4 * root2	
    numb[4] = 2	
	circ = 0
	for i = 1,4 do
        circ = circ + numb[i]
	end
    circ = 2 * circ * dim	
    area = 14 * 10 - 4 * 4 - 4 * 6
    area = area * dim2	
end	
if (ind == 9) then
    numb[1] = math.sqrt(3^2+4^2)
	numb[1] = lib.math.round_dec(numb[1],3)	
    numb[2] = 4 
    numb[3] = 6 * root2	
    numb[4] = 2	
    numb[5] = math.sqrt(7^2+2^2)
	numb[5] = lib.math.round_dec(numb[5],3)	
    numb[6] = 5	
	circ = numb[5] + numb[6] 
	for i = 1,5 do
        circ = circ + numb[i]
	end
    circ = circ * dim	
    area = 14 * 10 - 7 * 2 - 0.5 * (6 * 6 + 4 * 3)
    area = area * dim2	
end	
if (ind == 10) then
    numb[1] = math.sqrt(5^2+2^2)
	numb[1] = lib.math.round_dec(numb[1],3)	
    numb[2] = 2 * root2	
    numb[3] = 6	
    circ = 4 * (numb[1] + numb[2]) + 2 * numb[3]
    circ = circ * dim	
    area = 14 * 10 - 2 * 2 * 2 - 10 * 2
    area = area * dim2	
end
if (ind == 11) then
    numb[1] = math.sqrt(2^2+6^2)
	numb[1] = lib.math.round_dec(numb[1],3)		
    numb[2] = 6
    numb[3] = math.sqrt(6^2+4^2)
	numb[3] = lib.math.round_dec(numb[3],3)	
    numb[4] = math.sqrt(12^2+4^2)
	numb[4] = lib.math.round_dec(numb[4],3)	
	circ = numb[1]
	for i = 1,4 do
        circ = circ + numb[i]
	end
    circ = circ * dim	
    area = 14 * 10 - 2 * 6 - 0.5 *(12 * 4 + 6 * 4)
    area = area * dim2
end	
if (ind == 12) then
    numb[1] = 2
	numb[2] = 10		
    numb[3] = 8
    numb[4] = 6
	numb[5] = 4	
    circ = 3 * numb[1] + 3 * numb[2] + numb[3] + 4 * numb[4] + numb[5] 
    circ = circ * dim	
    area = 10 * 10 -  2 * 2 * 6 - 2 * 4
    area = area * dim2
end	
if (ind == 13) then
    numb[1] = math.sqrt(4^2+5^2)
	numb[1] = lib.math.round_dec(numb[1],3)		
    numb[2] = math.sqrt(10^2+5^2)
	numb[2] = lib.math.round_dec(numb[2],3)		
	circ = 0
	for i = 1,2 do
        circ = circ + numb[i]
	end
    circ = 2 * circ * dim	
    area = 0.5 * 14 * 10 
    area = area * dim2	
end
if (ind == 14) then
    numb[1] = math.sqrt(4^2+3^2)
	numb[1] = lib.math.round_dec(numb[1],3)	
	numb[2] = 4
	numb[3] = 4 * root2	
    numb[4] = math.sqrt(4^2+6^2)
	numb[4] = lib.math.round_dec(numb[4],3)	
	numb[5] = 2
    numb[6] = math.sqrt(4^2+2^2)
	numb[6] = lib.math.round_dec(numb[6],3)	
    numb[7] = math.sqrt(2^2+5^2)
	numb[7] = lib.math.round_dec(numb[7],3)			
	circ = 0
	for i = 1,7 do
        circ = circ + numb[i]
	end
    circ = circ * dim	
    area = 12 * 10 - 0.5 * (3 * 4 + 4 * 4 + 4 * 6 + 2 * 4 + 2 * 5) - 2 * 2
    area = area * dim2	
end
if (ind == 15) then
    numb[1] = math.sqrt(3^2+2^2)
	numb[1] = lib.math.round_dec(numb[1],3)		
    circ = 10 * numb[1] * dim	
    area = 5 * (0.5 * 6 * 4 - 0.5 * 6 * 2)
    area = area * dim2
end

circ = lib.math.round_dec(circ, 1)
area = lib.math.round_dec(area, 1)	

mycanvas = function()
	 		  
  lib.start_canvas(250, 180, "center")   
  
   w = 16
   ow = 12
   v = 5

  
  if (ind == 1) then  
      lib.add_straight_path(v, v+4*w, {{6*w,-4*w}, {5*w,0}, {3*w,4*w}, {-3*w,6*w}, {-5*w,0}, {-6*w,-6*w}}, style, true, false)      
   end

   if (ind == 2) then  
      lib.add_straight_path(v, v+6*w, {{3*w,-6*w}, {10*w,6*w}, {-7*w,4*w}, {-6*w,-2*w}, {0,-2*w}}, style, true, false)          
   end 
  
  if (ind == 3) then          
     lib.add_straight_path(v, v, {{14*w,0}, {-5*w,6*w}, {3*w,4*w}, {-11*w,0}, {2*w,-4*w}, {-3*w,-6*w}}, style, true, false)     
  end
  if (ind == 4) then  
     lib.add_straight_path(v, v+10*w, {{4*w,-10*w}, {2*w,7*w}, {3*w,-7*w}, {2*w,7*w}, {3*w,-7*w}, {0,10*w}, {-14*w,0}}, style, true, false)  
  end
  if (ind == 5) then  
  lib.add_straight_path (v+3*w, v+5*w, {{-3*w,-5*w}, {11*w, 0}, {3*w,5*w}, {-3*w,5*w}, {-11*w,0}, {3*w,-5*w}}, style, false, true) 
  end 
  if (ind == 6) then  
  lib.add_straight_path (v, v, {{14*w,4*w}, {-4*w,6*w}, {-6*w,0}, {0,-6*w}, {-4*w, -4*w}}, style, false, true)  
  end
  if (ind == 7) then 
     lib.add_straight_path (v+w, v+10*w, {{12*w,-10*w}, {-2*w,10*w}, {-4*w,0}, {2*w,-4*w}, {-2*w,0}, {-2*w,4*w}, {-4*w,0}}, style, false, true)
  end
  if (ind == 8) then 	
     lib.add_straight_path (v, v+4*w, {{6*w,-4*w}, {4*w,0}, {4*w,4*w}, {0, 2*w}, {-6*w,4*w}, {-4*w,0*w}, {-4*w,-4*w}, {0, -2*w,0}}, style, false, true)        
  end 
  if (ind == 9) then
     lib.add_straight_path (v+8*w, v, {{6*w,6*w},{0,2*w}, {-7*w,2*w}, {-7*w,-2*w}, {0,-5*w}, {4*w,-3*w}, {4*w,0}, }, style, true, false)  
  end 
  if (ind == 10) then
     lib.add_straight_path (v, v+2*w, {{2*w,-2*w}, {5*w,2*w}, {5*w,-2*w}, {2*w,2*w}, {0,6*w}, {-2*w,2*w}, {-5*w,-2*w}, {-5*w,2*w}, {-2*w,-2*w}, {0, -6*w}}, style, false, true)   
  end  
  if (ind == 11) then
    lib.add_straight_path (v+2*w, v, {{6*w,0}, {6*w,4*w}, {-2*w,6*w}, {-12*w,-4*w}, {2*w,-6*w}}, style, false, true)  
  end
  if (ind == 12) then
     lib.add_straight_path (v+10*w, v+2*w, {{-8*w,0}, {0,-2*w}, {10*w,0}, {0,10*w}, {-10*w,0}, {0,-6*w}, {6*w,0}, {0, 2*w}, {-4*w, 0}, {0, 2*w}, {6*w,0}, {0, -6*w} }, style, false, true)  
  end
  if (ind == 13) then
     lib.add_straight_path (v, v+5*w, {{4*w,-5*w}, {10*w,5*w}, {-10*w,5*w}, {-4*w,-5*w}}, style, false, true)  
  end
  if (ind == 14) then
     lib.add_straight_path (v+w, v+3*w, {{4*w,-3*w}, {4*w,0}, {4*w,4*w}, {-4*w, 6*w}, {-2*w,0}, {-4*w, -2*w}, {-2*w, -5*w}}, style, false, true)
  end
  if (ind == 15) then    
     lib.add_straight_path(v+2.2*w, v+3.5*w, {{3.6*w,0}, {1.2*w,-3.5*w}, {1.2*w,3.5*w}, {3.6*w,0}, {-3*w,2.1*w}, {1.2*w,3.4*w}, {-3*w,-2*w}, {-3*w,2*w}, {1.2*w,-3.3*w}, {-3*w,-2.2*w}}, style, true, false)           
     lib.add_circle (v+7*w, v+5*w, 2, grid_style, false, false)	   	  
	 lib.add_circle (v+7*w, v+5*w, 1.5*w, grid_style, false, false) 
	 lib.add_line(v+2.2*w, v+3.5*w, 9.6*w, 0, grid_style, false, false)
	 lib.add_line(v+2.2*w, v+3.5*w, 7.6*w, 5.5*w, grid_style, false, false)	  
	 lib.add_line(v+7*w, v, 2.9*w, 9*w, grid_style, false, false)
	 lib.add_line(v+7*w, v, -2.9*w, 9*w, grid_style, false, false)	 
	 lib.add_line(v+4.1*w, v+9*w, 7.8*w, -5.6*w, grid_style, false, false)  
     lib.add_straight_path(v+2.2*w, v+3.5*w, {{4.8*w,-3.5*w}, {4.8*w,3.5*w}, {-2*w,5.5*w}, {-5.7*w,0}, {-2*w,-5.5*w}}, grid_style, true, false)           
  end 
    
  for i = 1,11 do
    lib.add_line(v, v+(i-1)*w, 14*w, 0, grid_style, false, false)
  end
  for i = 1,15 do
    lib.add_line(v+(i-1)*w, v, 0, 10*w, grid_style, false, false)
  end

  lib.end_canvas()
end              
  