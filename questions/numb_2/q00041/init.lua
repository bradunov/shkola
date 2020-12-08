
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

text_style = {["font_size"] = "16"}

bracketl = "{"
bracketr = "}"

und = "\(\subset\)"  
empt = "\(\emptyset\)"
oper = "\(\leq\)" 


descr_w = {"banana", "sveska", "visibaba", "ananas", "internet"} 
word = {}      
word[1] = {"a","b", "n"}     
word[2] = {"a", "v", "e", "k", "s"}
word[3] = {"a", "b", "i", "s", "v"}
word[4] = {"a", "n", "s"}
word[5] = {"e", "i", "n", "r", "t"}
dim_word = {3, 5, 5, 3, 5}


descr_n = { "dekadna", "prost", "paran", "cifra broja"} 
number = {}
number[1] = {1, 10, 100, 1000}
number[2] = {2, 3, 5, 7}
number[3] = {2, 4, 6, 8, 10}
number[4] = {}
cifra = {}
value = 0
for i = 1,9 do
    cifra[i] = 2*math.random(4) - 1
    value = value*10 + cifra[i]
end	
cc = lib.math.argsort(cifra)
number[4][1] = cifra[cc[1]]
br = 1
for i = 2,9 do
    if (cifra[cc[i]] ~= cifra[cc[i-1]]) then
	    br = br + 1
		number[4][br] = cifra[cc[i]]
	end
end	

if (br < 3) then 
    jmax = 3 - br
    for j = 1, jmax do
	    br = br + 1
		number[4][br] = 2*j
		value = value * 10 + number[4][br]
	end
end		

dim_numb = {4, 4, 5, br}


ind = math.random(2)
index = math.random(3 + ind)

solut_1 = bracketl
if (ind == 1) then
    min = math.random(dim_numb[index]-2)
	max = min + math.random(dim_numb[index]-min)
    for i = min, max do
        tempn = number[index][i] 
		if (i == max) then
    	    solut_1 = solut_1 .. " " .. tempn	
		else
    	    solut_1 = solut_1 .. " " .. tempn .. ","	
		end	
    end	
else
    min = math.random(dim_word[index]-2)
	max = min + math.random(dim_word[index]-min)
    for i = min, max do
        tempw = word[index][i] 
		if (i == max) then
    	    solut_1 = solut_1 .. " " .. tempw 
		else
    	    solut_1 = solut_1 .. " " .. tempw .. ", "	
		end	
    end	
end	
solut_1 = solut_1 .. " " .. bracketr

solut_2 = bracketl .. " s | " .. "s je " 
if (ind == 1) then 
    solut_2 = solut_2 .. descr_n[index] 
    if (index == 1) then
        solut_2 = solut_2 .. " jedinica" .. " " .. oper .. " " .. tostring(1000)	
	else
        if (index < 4) then    
            solut_2 = solut_2 .. " broj prve desetice" 	
		else
            solut_2 = solut_2 .. " " .. tostring(value) 
        end			
	end
else 
    solut_2 = solut_2 .. "slovo reči " .. descr_w[index]
end	
    solut_2 = solut_2 .. bracketr  

q = {}
option = math.random(2)
  
mycanvas = function(no)
  lib.start_canvas(350, 110, "center")

  ov = 50
  ow = 20
   v = 5
  
  if (ind == 1) then  
      lib.add_ellipse(4*ov-ow, ov+v, 3*ov, ov,  line_red, true, false)
  else
      lib.add_ellipse(4*ov-ow, ov+v, 3*ov,  ov, line_blue, true, false)  
  end

  if (ind == 1) then
	  q = lib.math.random_shuffle(number[index])
	  imax = dim_numb[index]
  else	  
	  q = lib.math.random_shuffle(word[index])	
	  imax = dim_word[index]	  
  end
 
  if (option == 2) then
      imax = imax + 1
      if (ind == 1) then
          if (index == 1) then
              q[imax] = 0
          end
          if (index == 2) then
              q[imax] = 11
          end
          if (index == 3) then
              q[imax] = 1
          end
          if (index == 4) then
              q[imax] = 9
          end
      else	
          if (index == 1) then
              q[imax] = "e"
          end
          if (index == 2) then
              q[imax] = "c"
          end
          if (index == 3) then
              q[imax] = "n"
          end
          if (index == 4) then
              q[imax] = "o"
          end	
          if (index == 5) then
              q[imax] = "a"
          end
      end
  end	  
	   
  x = 2*ov + 15
  y = ov - v
  sign = 1
  if (imax < 5) then
      step = 3
  else
      step = 2
      x = x - ow	  
  end   
  for i = 1,imax do
      if (ind == 1) then
          lib.add_circle (x, y, 5, style_red, true, false) 
          lib.add_text(x, y-ow, q[i], text_style)
      else	  
          lib.add_circle (x, y, 5, style_blue, true, false) 
          lib.add_text(x, y-ow, q[i])
      end
	  x = x + step * ow
	  y = y + sign * (ov - ow)
	  sign = - sign
  end

  lib.end_canvas()
end 
           
name = {"P", "R", "S", "T"} 
choice =  {1,2,3,4}                
qq = lib.math.random_shuffle(choice) 

reply = {""}

nr = 0
for i = 1,3 do
    for j = i+1,4 do
	    rel = math.random(2)
		term = 0
		if (rel == 1) then
		    relat = und	
            if (qq[i] <= qq[j])	then		
		        term = 1
			end                		
     		if (option == 1 and qq[i] == 4 and qq[j] == 3) then	
		           term = 1				   
			end   
            if (min == 1) then
	            if ((ind == 1 and max == dim_numb[index]) or (ind == 2 and max == dim_word[index])) then
	                if (qq[i] == 3 and qq[j] == 2) then
		                term = 1
                    end		
	                if (option == 1 and qq[i] == 4 and qq[j] == 2) then
		                term = 1
                    end								
			    end	
			end			
        else
            relat = " = "
            if (option == 1) then 
			    if ((qq[i] == 4 and qq[j] == 3) or (qq[i] == 3 and qq[j] == 4)) then	
		           term = 1		   
				end 
			end	
            if (min == 1) then
	            if ((ind == 1 and max == dim_numb[index]) or (ind == 2 and max == dim_word[index])) then
	                if ((qq[i] == 3 and qq[j] == 2) or (qq[i] == 2 and qq[j] == 3)) then
		                term = 1
                    end			                							
                    if (option == 1) then 
			            if ((qq[i] == 4 and qq[j] == 2) or (qq[i] == 2 and qq[j] == 4)) then	
		                    term = 1		   
				        end
                    end						
                end						
			end			
        end	
		nr = nr + 1
        if (term == 0) then
            check = "n"
        else
            check = "t"  
        end     		
		reply[nr] = lib.check_string(check, 15) .. " " .. name[qq[i]] .. " " .. relat .. " " .. name[qq[j]] 
	end
end       
 
 

 


          
          
    
    
                  
                
                