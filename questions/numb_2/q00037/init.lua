
style_blue = 
	{["off_color"] = "0cf",
        ["on_color"] = "0cf",
        ["line_color"] = "0cf",
        ["line_width"] = "2"};

style_red = 
	{["off_color"] = "f30",
        ["on_color"] = "f30",
        ["line_color"] = "f30",
        ["line_width"] = "2"};

line_blue = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "0cf",
        ["line_width"] = "3"};

line_red = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "3"};

text_style = {["font_size"] = "20"}

word = {}  


include("terms")


bracketl = "{"
bracketr = "}"
rel = "\(\leq\)"
   
dim_word = {3, 7, 5, 6, 5}

number = {}
number[1] = {2, 3, 5, 7, 11, 13, 17, 19}
number[2] = {1, 10, 100, 1000}
number[3] = {2, 4, 6, 8, 10}
number[4] = {41, 43, 45, 47, 49}
dim_numb = {8, 4, 5, 5}

ind = math.random(2)
index = math.random(3 + ind)

solut_1 = "S" .. " = " .. bracketl
if (ind == 1) then
    for i = 1, dim_numb[index] do
        tempn = number[index][i] 
		if (i == dim_numb[index]) then
		    if (index == 2) then
    	        solut_1 = solut_1 .. lib.check_number(tempn,40)	
			else
    	        solut_1 = solut_1 .. lib.check_number(tempn,20) 
            end	
		else
		    if (index == 2) then
    	        solut_1 = solut_1 .. lib.check_number(tempn,30) .. ","	
			else
    	        solut_1 = solut_1 .. lib.check_number(tempn,20) .. ","
            end			
		end	
    end	
else
    for i = 1, dim_word[index] do
        tempw = word[index][i] 
		if (i == dim_word[index]) then
    	    solut_1 = solut_1 .. lib.check_string(tempw,15) 
		else
    	    solut_1 = solut_1 .. lib.check_string(tempw,15) .. ", "	
		end	
    end	
end	
solut_1 = solut_1 .. bracketr

solut_2 = "S" .. " = " .. bracketl .. " x | " .. "x je " 
if (ind == 1) then
    tempn = descr_n[index]  
    solut_2 = solut_2 .. lib.check_string(tempn,50) 
    if (index == 1) then
        solut_2 = solut_2 .. " " .. name[1] ..", x < " .. lib.check_number(20,20) 	
	end
    if (index == 2) then
        solut_2 = solut_2 .. " ".. tens[1] .. ", x " .. rel .. lib.check_number(1000,30) 	
	end
    if (index == 3) then
        solut_2 = solut_2 .. " " .. name[1] .. " " .. lib.check_string(adv[1],40) .. tens[2] 	
	end
    if (index == 4) then
        solut_2 = solut_2 .. name[1] .. " " .. lib.check_string(adv[2],40) .. tens[2]	
	end	
else
    tempw = descr_w[index] 
    solut_2 = solut_2 .. name[2] .. " " .. lib.check_string(tempw, 70) 
end	
    solut_2 = solut_2 .. bracketr  

q = {}

mycanvas = function(no)
  lib.start_canvas(350, 190, "center")

  ov = 50
  ow = 20
  
  if (ind == 1) then  
      lib.add_rectangle(2*ow, ow, 6*ov-ow, 2*ov+3*ow, line_red, true, false)
  else
      lib.add_ellipse(4*ov-ow, 2*ov, 3*ov, 2*ov-ow, line_blue, true, false)  
      lib.add_text(ov, ow/2, descr_w[index])
  end

  if (ind == 1) then
      imax = dim_numb[index]
      if (dim_numb[index] < 6) then
          shift = 4
      else	  
          shift = 3
      end
	  q = lib.math.random_shuffle(number[index])
  else	  
      imax = dim_word[index]
      if (dim_word[index] < 6) then
          shift = 4
      else	  
          shift = 3
      end
	  q = lib.math.random_shuffle(word[index])	  
  end
 
  for i = 1,imax do
	  mid = math.floor(imax/2)
	  if (imax == 3) then
	      mid = imax
		  y = 2*ov-ow
		  cor = i 
	          x = 3*ow +  cor * ov		  
	  else	  
	      if (i > mid) then
	          y = 2*(ov+ow)
		      cor = i - mid
	              x = shift*ow +  cor * ov
	      else
	          y = ov+ow
		      cor =  i
	              x = (shift+1)*ow +  cor * ov
	      end
      end	  
          lib.add_circle (x, y, 5, style_red, true, false) 
	  if (ind == 1) then
          lib.add_circle (x, y, 5, style_red, true, false) 
          lib.add_text(x, y-ow, q[i])
      else
          lib.add_circle (x, y, 5, style_blue, true, false) 
          lib.add_text(x, y-ow, q[i], text_style)
	  end
  end

  lib.end_canvas()
end          
       
            
    
          
          
    
    
                  
                
                