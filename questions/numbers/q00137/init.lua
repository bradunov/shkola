
pink_style = {["off_color"] = "fc9",
               ["on_color"] = "fc9",
               ["line_color"] = "000",
               ["line_width"] = "1"};	
			   
light_style = {["off_color"] = "f2ffcc",
               ["on_color"] = "f2ffcc",
               ["line_color"] = "000",
               ["line_width"] = "1"};	

orange_style = {["off_color"] = "ffecb3",
               ["on_color"] = "ffecb3",
               ["line_color"] = "000",
               ["line_width"] = "1"};				   
		 
blue_style = {["off_color"] = "ccf",
               ["on_color"] = "ccf",
               ["line_color"] = "000",
               ["line_width"] = "1"};
			   
violet_style = {["off_color"] = "ffcce6",
                ["on_color"] = "ffcce6",
                ["line_color"] = "000",
                ["line_width"] = "1"};			   
			   
green_style = {["off_color"] = "cfc",
                ["on_color"] = "cfc",
                ["line_color"] = "000",
                ["line_width"] = "1"};
				
yelow_style = {["off_color"] = "ff9",
               ["on_color"] = "ff9",
               ["line_color"] = "000",
               ["line_width"] = "1"};				
				
marker_style = 
	{["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "1"};			  		   
			   		
text1_style = {["font_size"] = "16"}
text2_style = {["font_size"] = "14"}		


moneta = {1000, 500, 200, 100, 50, 20, 10, 5}
dim = 8
init = math.random(4)
choice = moneta[init]

money = {}
ind = {}
temp = {}

stampa = 0
value = choice
summ = 0

for i = init + 1, dim-1 do
    if (value > 0) then	
	    op = math.random(2)
		for j = 1,op do
            if (value > 0) then
	            stampa = stampa + 1
                money[stampa] = moneta[i]
		        ind[stampa] = i
	            value = value - money[stampa]
	            summ = summ + money[stampa]
            end
		end
	end
end	


    for j = 4,5 do
        if (value >= moneta[j] and value < moneta[j-1]) then
	        stampa = stampa + 1
            money[stampa] = moneta[j]
		    ind[stampa] = j
	        value = value - money[stampa]
	        summ = summ + money[stampa]
        end
	end

if (value ~= 0) then	
    qq = math.floor(value/20)
	rest = value - qq * 20
	if (qq ~= 0) then
	    for i = 1, qq do
	        stampa = stampa + 1
            money[stampa] = moneta[6]
		    ind[stampa] = 6
	        value = value - money[stampa]
	        summ = summ + money[stampa]
        end	
    end		
	if (rest ~= 0) then	 
	    stampa = stampa + 1
        money[stampa] = moneta[7]
		ind[stampa] = 7
	    value = value - money[stampa]
	    summ = summ + money[stampa]	 
    end	
end	
	 
temp = lib.math.argsort(ind)

mycanvas = function()

 results = ""   
  
 for i = 1,6 do 
      index = i - 1
      if (index > 0) then
          results = results .. "&& "
      end
      results = results .. "result[" .. tostring(index) .. "] == "	  
      if ( i == init ) then
          results = results .. "1 "
	  else	  
          results = results .. "0 " 
	  end	 		  
  end	
  
  w = 10
  ow = 20
  ov = 50 
  
  
  lib.start_canvas(380, 350, "center", results)
  

   y = 6*ov
   
 --[[  markeri  ]]--
  lib.add_circle(ow+w, y, 7, marker_style, false, true) 
  lib.add_text(ow+w, y+ow, "1000", text2_style, false, false)   
  lib.add_circle(4*ow+w, y, 7, marker_style, false, true) 
  lib.add_text(4*ow+w, y+ow, "500", text2_style, false, false)   
  lib.add_circle(7*ow+w, y, 7, marker_style, false, true)
  lib.add_text(7*ow+w, y+ow, "200", text2_style, false, false)  
  lib.add_circle(10*ow+w, y, 7, marker_style, false, true)
  lib.add_text(10*ow+w, y+ow, "100", text2_style, false, false)   
  lib.add_circle(13*ow+w, y, 7, marker_style, false, true) 
  lib.add_text(13*ow+w, y+ow, "50", text2_style, false, false)     
  lib.add_circle(16*ow+w, y, 7, marker_style, false, true)
  lib.add_text(16*ow+w, y+ow, "20", text2_style, false, false)      

  x = ow
  y = ow
    
  for i = 1, stampa do      
      if ( i == 4) then
	     x = ow
	     y = 2*ov
	  end
	  if ( i == 7) then
	  	 x = ow
	     y = 3*ov+ow
	  end
	  if ( i == 10) then
	  	 x = ow
	     y = 4*ov + 2*ow
	  end	  
      if (ind[temp[i]] == 2) then	  
         lib.add_rectangle(x, y, 100, 50, light_style, true, false)
         lib.add_text(x+50, y+25, "500", text1_style, false, false) 
	  end
      if (ind[temp[i]] == 3) then	  
         lib.add_rectangle(x, y, 90, 45, orange_style, true, false)
         lib.add_text(x+45, y+22, "200", text1_style, false, false) 
	  end	  
      if (ind[temp[i]] == 4) then      	  
         lib.add_rectangle(x, y, 80, 40, blue_style, true, false)
         lib.add_text(x+40, y+20, "100", text1_style, false, false)
	  end	  
      if (ind[temp[i]] == 5) then	  
         lib.add_rectangle(x, y , 70, 35, violet_style, true, false)
         lib.add_text(x+35, y+17, "50", text1_style, false, false)
	  end
      if (ind[temp[i]] == 6) then      	  
         lib.add_rectangle(x, y, 60, 30, green_style, true, false)
         lib.add_text(x+30, y+ 15, "20", text1_style, false, false)
	  end
      if (ind[temp[i]] == 7) then	  
         lib.add_rectangle(x, y, 50, 25, yelow_style, true, false)
         lib.add_text(x+25, y+12, "10", text1_style, false, false)
      end
      if (ind[temp[i]] == 8) then	  
         lib.add_circle(x+ow, y+w, 15, gold_style, true, false)  
         lib.add_text(x+ow, y+w, "5", text2_style, false, false) 
	  end
	  if ( i > 7) then
	      x = x + 2*ov-ow	  
	  else
	      if ( i < 4) then
	         x = x + 2*ov+ow
		  else
	         x = x + 2*ov
          end 			 
	  end	  
  end	  
 

  lib.end_canvas()
  
end       
      
                  
              
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
            
            
            
            
            
            
            
            
            
            
            
            
               
      
    
      


            

                  
            
                  
              
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  