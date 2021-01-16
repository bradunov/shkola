
red_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "3"};			

text_style = {["font_size"] = "16"}

include("terms")

prime = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97}
dim = 10                                    --[[25]]--

numb = {}
deg = {}

val = 2 + math.random(3)
start = 14 + math.random(5)
number = 1
for i = 1, val do
    numb[i] = start + i - 1
	number = number * numb[i]
end	

if (val == 5) then
    quest = msg[1]
else
    quest = msg[2]	
end	

answ = lib.check_number(numb[1],20) .. " * " .. lib.check_number(numb[2],20) .. " * " .. lib.check_number(numb[3],20)
if (val == 4) then
    answ = answ .. " * " .. lib.check_number(numb[4],20)
end
if (val == 5) then
    answ = answ .. " * " .. lib.check_number(numb[4],20) .. " * " .. lib.check_number(numb[5],20)
end	

max = 10
len = 70 

mycanvas = function()

  lib.start_canvas(300, 380, "center")

  v = 100
  w = 30
  ow = 5


  lib.add_text(2*w+ow, 4*ow, tostring(math.floor(number)), text_style) 
 
  x = w
  y = 2 * ow
  z = 6 * w + ow

  term1 = number 
  index = 0
  
  for i = 1, dim do
	  for j = 1, max do
		  term2 = math.floor(term1/prime[i])
		  rest = term1 - term2 * prime[i]
		  
          if (rest == 0) then		  
               lib.add_input(z, y, 40, 30, lib.check_number(prime[i],20))			   
               lib.add_input(x, y+w, 90, 30, lib.check_number(term2,len))	
               index = index + 1
			   deg[index] = prime[i]
	           term1 = term2
		       y = y + w
               len = len - 5
               x = x + 3			   
		  end
			  
      end   
  end
  
  lib.add_line(5*w, ow, 0, (index+1)*w, red_style, false, false) 
  
  lib.end_canvas()
end 
       
            
            
   
        
       
             
       