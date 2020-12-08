
style_green = 
	{["off_color"] = "6f6",
        ["on_color"] = "6f6",
        ["line_color"] = "6f6",
        ["line_width"] = "2"};

line_green = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "6f6",
        ["line_width"] = "3"};

text_style = {["font_size"] = "20"}

 
task = {"(zapisom od najmanjeg do najvećeg)", "(velikim slovima azbučnim redom)"}
bracketl = "{"
bracketr = "}"
 

descr_w = {"s su slova koja se pišu isto ćirilicom i latinicom", "s su samoglasnici"} 
word = {}      
word[1] = {"A", "E", "J", "K", "M", "O", "T"}     
word[2] = {"A", "E", "I", "O", "U"}
dim_word = {7, 5}

rel = "\(\leq\)"
rel2 = "\(\lt\)"
pos = "\(\in\)" 
descr_n = {rel, pos}
number = {}
number[1] = {6, 7, 9, 11}
number[2] = {4, 5, 6, 7, 8}
dim_numb = {4, 5}

ind = math.random(2)
index = math.random(2)

solut_1 = "S" .. " = " .. bracketl
if (ind == 1) then
    for i = 1, dim_numb[index] do
        tempn = number[index][i] 
		if (i == dim_numb[index]) then
    	    solut_1 = solut_1 .. lib.check_number(tempn,15) 	
		else
    	    solut_1 = solut_1 .. lib.check_number(tempn,15) .. ","		
		end	
    end	
else
    for i = 1, dim_word[index] do
        tempw = word[index][i] 
        reply = "answer == '" .. tempw .. "' "  ;
        ans = "answer = '" .. tempw .. "' ";		  		
		if (i == dim_word[index]) then
    	    solut_1 = solut_1 .. lib.check_string(reply,15,ans) 
		else
    	    solut_1 = solut_1 .. lib.check_string(reply,15,ans) .. ", "	
		end	
    end	
end	
solut_1 = solut_1 .. bracketr

solut_2 = "S" .. " = " .. bracketl .. " s | " 
if (ind == 1) then
    tempn = descr_n[index]  
    if (index == 1) then
        solut_2 = solut_2 .. "s-4" .. " " .. pos .. " " .. "P"
    	add = "P = " .. bracketl .. "2, 3, 5, 7" .. bracketr
	end
    if (index == 2) then
        solut_2 = solut_2 .. "4 " .. rel .. " s " .. rel2 .. " 9" 
        add = ""		
	end
else
    tempw = descr_w[index] 
    solut_2 = solut_2 .. tempw 
end	
    solut_2 = solut_2 .. bracketr  

q = {}

mycanvas = function(no)
  lib.start_canvas(350, 190, "center")

  ov = 50
  ow = 20
  
  lib.add_ellipse(4*ov-ow, 2*ov, 3*ov, 2*ov-ow, line_green, true, false)  

  if (ind == 1) then
      imax = dim_numb[index]
      if (dim_numb[index] < 6) then
          shift = 4
      else	  
          shift = 3
      end
	  q = number[index]
  else	  
      imax = dim_word[index]
      if (dim_word[index] < 6) then
          shift = 4
      else	  
          shift = 3
      end
	  q = word[index]	  
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
          lib.add_circle (x, y, 5, style_green, true, false) 
	  if (ind == 1) then
          lib.add_circle (x, y, 5, style_green, true, false) 
		  lib.add_input(x-15, y-3*ow/2, 30, 30, lib.check_string(q[i], 15))  		  
      else
          lib.add_circle (x, y, 5, style_green, true, false) 
          reply = "answer == '" .. q[i] .. "' "  ;
          ans = "answer = '" .. q[i] .. "' ";		  
		  lib.add_input(x-15, y-3*ow/2, 30, 30, lib.check_string(reply, 15, ans))                   
	  end
  end

  lib.end_canvas()
end  
     
      
            
        
   
       
            
    
          
          
    
    
                  
                
                