
line_blue = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "0cf",
        ["line_width"] = "2"};

line_red = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "2"};
		
line_green = 
	{["off_color"] = "none",
        ["on_color"] = "fff",
        ["line_color"] = "6f6",
        ["line_width"] = "2"};	

	
text_style = {["font_size"] = "14"}


bracketl = "{"
bracketr = "}"

q = {}
number = {} 
sort = {}
solut = {}

dim = 20
for i = 1, dim do
    q[i] = i
end
number = lib.math.random_shuffle(q)

part1 = {}
part2 = {}
part3 = {}
qq = {}

index = 0
for i = 1,3 do 
    part1[i] = {}   	
	for j = 1,3 do
		index = index + 1
	    part1[i][j] = number[index]
	end	
end
for i = 1,3 do 
    part2[i] = {}
	for j = 1,2 do
		index = index + 1
	    part2[i][j] = number[index]		
	end	
end
for j = 1,2 do
	index = index + 1
	part3[j] = number[index]
end	

for i = 1,3 do
    qq[i] = {}
	ind = 0
	for j = 1,3 do
	    ind = ind + 1
        qq[i][ind] = part1[i][j]	
	end
    for j = 1,2 do
	    ind = ind + 1
        qq[i][ind] = part2[i][j]
	    ind = ind + 1
		if (i == 3) then 
           qq[i][ind] = part2[1][j]	
        else
           qq[i][ind] = part2[i+1][j]	
        end 		   
    end
    for j = 1,2 do
	    ind = ind + 1
        qq[i][ind] = part3[j]		
    end	
end	
	
for i = 1,3 do
    sort = lib.math.argsort(qq[i])
    solut[i] = bracketl
    for j = 1, ind do
        tempn = qq[i][sort[j]]
		if (j == ind) then
    	    solut[i] = solut[i] .. lib.check_number(tempn,15)	
		else
    	    solut[i] = solut[i] .. lib.check_number(tempn,15) .. ","
        end			
    end	
	solut[i] = solut[i] .. bracketr
end	


mycanvas = function(no)
  lib.start_canvas(350, 250, "center")

  ov = 50
  ow = 20
   
      lib.add_rectangle(ov-ow, ow, 4*ov, 2*ov+ow, line_red, false, false)
      lib.add_text(ow, ov+2*ow, "A")
      lib.add_ellipse(4*ov+ow, 2*ov+ow, ov+ow, 2*ov, line_blue, false, false) 
      lib.add_text(6*ov, 2*ov+ow, "B")
      lib.add_circle(3*ov, 3*ov, 2*ov-ow, line_green, false, false)	  
      lib.add_text(ov+2*ow, 4*ov+ow, "C")	  
		  
      lib.add_text(ov+ow, ov, part1[1][1], text_style)  
      lib.add_text(3*ov-ow, 2*ow, part1[1][2], text_style)  
      lib.add_text(ov, 2*ov+ow, part1[1][3], text_style)  
      lib.add_text(5*ov, 2*(ov-ow), part1[2][1], text_style)  
      lib.add_text(5*ov, 2*ov+ow, part1[2][2], text_style)  
      lib.add_text(5*ov, 2*ov+4*ow, part1[2][3], text_style)  
      lib.add_text(2*(ov+ow), 2*ov+3*ow, part1[3][1], text_style)  
      lib.add_text(ov+2*ow, 3*ov+ow, part1[3][2], text_style)  
      lib.add_text(3*ov, 5*ov-2*ow, part1[3][3], text_style)  

      lib.add_text(2*ov, 2*ov+ow, part2[1][1], text_style)  
      lib.add_text(3*ov-ow, ov+2*ow, part2[1][2], text_style)  

  
      lib.add_text(3*(ov+ow), 2*ow, part2[2][1], text_style)  
      lib.add_text(4*ov, ov+ow, part2[2][2], text_style)  

      lib.add_text(4*ov-ow, 2*ov+3*ow, part2[3][1], text_style)  
      lib.add_text(4*ov, 3*ov+2*ow, part2[3][2], text_style)  

      lib.add_text(3*ov+ow, 2*ov, part3[1], text_style)  
      lib.add_text(4*ov, 2*ov+ow, part3[2], text_style)  

  lib.end_canvas()
end           
          
                   
         
        
       
            
    
          
          
    
    
                  
                
                