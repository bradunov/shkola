
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
empty = "\(\small\emptyset\)"  
dif = "\"


q = {}
number = {}
part = {}
qq = {} 
sort = {}
solut = {}
answ = {""}

nr = 3
dim = 4 * nr
for i = 1, dim do
    q[i] = i
end
number = lib.math.random_shuffle(q)

index = 0
for i = 1,4 do 
    part[i] = {}   	
	for j = 1,nr do
		index = index + 1
	    part[i][j] = number[index]
	end	
end

opt = math.random(2)

if (opt == 1) then
    for i = 1,2 do
        qq[i] = {}
        ind = 0	
	    for j = 1,nr do
	        ind = ind + 1
            qq[i][ind] = part[1][j]		
        end		
		if (i == 1) then
            solut[i] = "A" .. " " .. dif .. " " .. "C = " .. bracketl		
		    sort = lib.math.argsort(qq[i])
            for j = 1, ind do
                tempn = qq[i][sort[j]]
		        if (j == ind) then
    	            solut[i] = solut[i] .. lib.check_number(tempn,15)	
		        else
    	            solut[i] = solut[i] .. lib.check_number(tempn,15) .. ","
                end			
            end	
		else	
            solut[i] = "C" .. " " .. dif .. " " .. "A = " .. bracketl
			for j = 1, ind do
                tempw = ""
    	        solut[i] = solut[i] .. lib.check_string(tempw,15)	
            end	
		end	
	    solut[i] = solut[i] .. bracketr			
    end	
    answ[1] = solut[2]	
	answ[2] = "C" .. " " .. dif .. " " .. "A = " .. empty
	indic = 1
else	 	
    for i = 1,2 do
        qq[i] = {}
        ind = 0
		if (i == 1) then
            solut[i] = "B" .. " " .. dif .. " " .. "C = " .. bracketl		
			for j = 1,nr do
	            ind = ind + 1
                qq[i][ind] = part[4][j]
            end 		   			
        else
            solut[i] = "C" .. " " .. dif .. " " .. "B = " .. bracketl
			for j = 1,nr do
	            ind = ind + 1
                qq[i][ind] = part[3][j]
            end 				
		end	
		sort = lib.math.argsort(qq[i])
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
    answ[1] = solut[2]	
	answ[2] = "C" .. " " .. dif .. " " .. "B = " .. empty
	indic = 0	
end	


mycanvas = function(no)
  lib.start_canvas(350, 250, "center")

  ov = 50
  ow = 20
 
  if (opt == 1) then 
      lib.add_rectangle(ov, ow, 4*ov+2*ow, 4*ov, line_red, false, false)
      lib.add_text(ov-ow, ov+2*ow, "A")

      lib.add_text(2*ov, ov, part[1][1], text_style)  
      lib.add_text(5*ov, 2*ov-ow, part[1][2], text_style)  
      lib.add_text(5*ov, 4*ov-ow, part[1][3], text_style) 

  else	  
      lib.add_ellipse(4*ov+ow, 2*ov+ow, ov+ow, 2*ov, line_blue, false, false) 
      lib.add_text(6*ov, 2*ov+ow, "B")

      lib.add_text(5*ov-ow, 2*(ov-ow), part[4][1], text_style)  
      lib.add_text(5*ov, 2*ov+ow, part[4][2], text_style)  
      lib.add_text(6*ov-4*ow, 2*ov+4*ow, part[4][3], text_style) 
  end	  
      lib.add_circle(3*ov, 3*ov-ow, ov+ow, line_green, false, false)	  
      lib.add_text(2*ov, 4*ov, "C")	  

      lib.add_text(3*ov+ow, 4*ow, part[2][1], text_style)  
      lib.add_text(3*ov+2*ow, 2*ov+ow, part[2][2], text_style) 
      lib.add_text(4*ov-ow, 3*ov+ow, part[2][3], text_style)  

      lib.add_text(3*ov-ow, 2*ov-ow, part[3][1], text_style)  
      lib.add_text(2*ov, 2*ov+ow, part[3][2], text_style)  	  
      lib.add_text(2*ov+ow, 3*ov+ow, part[3][3], text_style)    
    
  lib.end_canvas()
end                    
                        
                      
         
                 
               
        
       
            
    
          
          
    
    
                  
                
                