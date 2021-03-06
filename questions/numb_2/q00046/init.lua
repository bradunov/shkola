
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
uni = "\(\small\cup\)"  
sect = "\(\small\cap\)"

q = {}
number = {} 
part = {}
qq = {} 
sort = {}
solut = {}
answ = {}

stampa = 3
nr = 2
dim = 7 * nr
for i = 1, dim do
    q[i] = i
end
number = lib.math.random_shuffle(q)

index = 0
for i = 1,7 do 
    part[i] = {}   	
	for j = 1,nr do
		index = index + 1
	    part[i][j] = number[index]
	end	
end

temp = {}
chc = {}
for i = 1, 6 do
    temp[i] = i
end
chc = lib.math.random_shuffle(temp)

for i = 1,stampa do
        solut[i] =  bracketl	
    if (chc[i] == 1) then                 --[[(AuB)pC]]--
	    mink = 6
		maxk = 7
		kk = 4
        answ[i] = "(A" .. uni .. "B)" .. sect .. "C = "
	end	
	if (chc[i] == 2 ) then      --[[Au(BpC)]]--
	    mink = 4
		maxk = 7				
		kk = 1			
        answ[i] = "A" .. uni .. "(B" .. sect .. "C) = " 	
	end	
    if (chc[i] == 3) then              --[[(ApB)uC]]--	
	    mink = 3
		maxk = 7
		kk = 0	
        answ[i] = "(A" .. sect .. "B)" .. uni .. "C = " 	
	end
    if (chc[i] == 4) then       --[[Ap(BuC)]]--	
	    mink = 4
		maxk = 5
		kk = 7	
        answ[i] = "A" .. sect .. "(B" .. uni .. "C) = " 	
	end	
    if (chc[i] == 5 or chc[i] == 6) then     --[[Ap(BpC), (ApB)pC]]--	
	    mink = 0
		maxk = 0
		kk = 7	
        if (chc[i] == 5) then         
            answ[i] = "A" .. sect .. "(B" .. sect .. "C) = " 	
        else
            answ[i] = "(A" .. sect .. "B)" .. sect .. "C = " 
        end			
	end
	
    qq[i] = {}
    ind = 0
	if (kk ~= 0) then
	    for j = 1,nr do
	        ind = ind + 1                
	        qq[i][ind] = part[kk][j]
        end 	
    end	
	if (maxk ~= 0) then	
        for k = mink,maxk do
		    for j = 1,nr do
	            ind = ind + 1
                qq[i][ind] = part[k][j]
            end 		   
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


mycanvas = function(no)
  lib.start_canvas(250, 200, "center")

  ov = 40
  ow = 15
   
      lib.add_rectangle(ov-ow, ow, 4*ov, 2*ov+ow, line_red, false, false)
      lib.add_text(ow, ov+2*ow, "A")
      lib.add_ellipse(4*ov+ow, 2*ov+ow, ov+ow, 2*ov, line_blue, false, false) 
      lib.add_text(6*ov, 2*ov+ow, "B")
      lib.add_circle(3*ov, 3*ov, 2*ov-ow, line_green, false, false)	  
      lib.add_text(ov+2*ow, 4*ov+ow, "C")	  
		  
      lib.add_text(ov+ow, ov+ow, part[1][1], text_style)  
      lib.add_text(3*ov-ow, 2*ow, part[1][2], text_style)  
  
      lib.add_text(5*ov, 2*ov-ow, part[2][1], text_style)    
      lib.add_text(5*ov, 2*ov+3*ow, part[2][2], text_style) 
   
      lib.add_text(2*ov, 3*ov+ow, part[3][1], text_style)  
      lib.add_text(2*(ov+ow), 4*ov, part[3][2], text_style)  

      lib.add_text(2*ov, 2*ov+ow, part[4][1], text_style)  
      lib.add_text(3*ov-ow, ov+2*ow, part[4][2], text_style)  
 
      lib.add_text(3*(ov+ow), 2*ow, part[5][1], text_style)  
      lib.add_text(4*ov, ov+ow, part[5][2], text_style)  

      lib.add_text(4*ov-ow, 2*ov+3*ow, part[6][1], text_style)  
      lib.add_text(4*ov, 3*ov+2*ow, part[6][2], text_style)  

      lib.add_text(3*ov+ow, 2*ov, part[7][1], text_style)  
      lib.add_text(4*ov, 2*ov+ow, part[7][2], text_style)  

  lib.end_canvas()
end         

       
         
                   
         
        
       
            
    
          
          
    
    
                  
                
                