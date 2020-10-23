
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
				
gold_style = {["off_color"] = "fc0",
               ["on_color"] = "fc0",
               ["line_color"] = "000",
               ["line_width"] = "1"};			  		   
			   		
text1_style = {["font_size"] = "16"}
text2_style = {["font_size"] = "14"}		

include("names")
r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 

moneta = {500, 200, 100, 50, 20, 10, 5, 2, 1}
money = {}
ind = {}
answ = {}
out = {}
temp = {}
qq = {}


numb = 1 + math.random(5)
ind[1] = math.random(3)
money[1] = moneta[ind[1]]
summ = money[1]
stampa = 1

for i = 2, numb do
    ch = math.random(9)
	value = moneta[ch]
	add = summ + value
	if (add <= 1000) then
	    summ = add
	    stampa = stampa + 1
		ind[stampa] = ch
		money[stampa] = value
	end
end
	
out[1] = summ
out[2] = summ - 2 * math.random(4)
out[3] = summ + 2 * math.random(4)
out[4] = summ - 5 * math.random(4)
out[5] = summ + 5 * math.random(4)

for i = 2,5 do
    if(out[i] < 0) then
	   out[i] = - out[i] + 2
	end
    if(out[i] >= 1000) then
	   out[i] = out[i] - math.floor(summ/3)
	end	
end	
qq = lib.math.argsort(out) 
for i = 2,5 do
    if(out[qq[i]] == out[qq[i-1]]) then
	   out[qq[i]] = out[qq[i]] + 1
	end
end	 

answ = lib.math.random_shuffle(out)
index = 0
for i = 1,5 do
    if (answ[i] == summ) then
	   index = i - 1
	end   
end

temp = lib.math.argsort(ind)

mycanvas = function()

  w = 10
  ow = 20
  ov = 50 
  
  if (stampa > 3) then
     max = math.ceil(stampa/2)
  else
     max = stampa
  end
  

  lib.start_canvas(380, 170, "center")
  
  x = ow
  y = ow
  
  for i = 1, stampa do
      if ( max ~= stampa and i == max+1) then
	     x = ow
	     y = 2*ov
	  end
      if (ind[temp[i]] == 1) then	  
         lib.add_rectangle(x, y, 100, 50, light_style, true, false)
         lib.add_text(x+50, y+25, "500", text1_style, false, false) 
	  end
      if (ind[temp[i]] == 2) then	  
         lib.add_rectangle(x, y, 90, 45, orange_style, true, false)
         lib.add_text(x+45, y+22, "200", text1_style, false, false) 
	  end	  
      if (ind[temp[i]] == 3) then      	  
         lib.add_rectangle(x, y, 80, 40, blue_style, true, false)
         lib.add_text(x+40, y+20, "100", text1_style, false, false)
	  end	  
      if (ind[temp[i]] == 4) then	  
         lib.add_rectangle(x, y , 70, 35, violet_style, true, false)
         lib.add_text(x+35, y+17, "50", text1_style, false, false)
	  end
      if (ind[temp[i]] == 5) then      	  
         lib.add_rectangle(x, y, 60, 30, green_style, true, false)
         lib.add_text(x+30, y+ 15, "20", text1_style, false, false)
	  end
      if (ind[temp[i]] == 6) then	  
         lib.add_rectangle(x, y, 50, 25, yelow_style, true, false)
         lib.add_text(x+25, y+12, "10", text1_style, false, false)
      end
      if (ind[temp[i]] == 7) then	  
         lib.add_circle(x+ow, y+w, 15, gold_style, true, false)  
         lib.add_text(x+ow, y+w, "5", text2_style, false, false) 
	  end
      if (ind[temp[i]] == 8) then	  
         lib.add_circle(x+ow, y+w, 12, gold_style, true, false) 
         lib.add_text(x+ow, y+w, "2", text2_style, false, false)  
	  end
      if (ind[temp[i]] == 9) then	  
         lib.add_circle(x+ow, y+w, 10, gold_style, true, false) 
         lib.add_text(x+ow, y+w, "1", text2_style, false, false)     
	  end
	  x = x + 2*ov+ow
  end	  
 
  lib.end_canvas()
end
      
      
    
      


            

                  
            
                  
              
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  