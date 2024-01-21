
red_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["line_width"] = "3"};			

text_style = {["font_size"] = "16"}

prime = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97}
dim = 10                                    --[[25]]--

deg = {}


stampa = 10
numbmin = 50
numbmax = 10000

number = 1
sum = 0
for i = 1,dim do
    if (i < 5) then
	    max = 3
    else
        max = 2
    end		
    if (sum < stampa and number < numbmax) then	
        deg[i] = math.random(max) - 1
	else
        deg[i] = 0
    end		
	sum = sum + deg[i]
	if (deg[i] > 0) then
	    for j = 1,deg[i] do
            number = number * prime[i]
	    end
	end	
end

if (number < numbmin) then
    number = 1
	sum = 5
    temp = 2 + math.random(5)
    for i = 1,dim do
	    if (i >= temp and i <= temp + 4) then
		    deg[i] = 1
			number = number * prime[i]
		else 
            deg[i] = 0
        end	
    end		
end	

len = 15 + sum * 5

mycanvas = function()

  lib.start_canvas(300, 350, "center")

  v = 100
  w = 30
  ow = 10

  lib.add_line(5*w, ow, 0, (sum+1)*w, red_style, false, false)
 
  lib.add_text(2*w+ow, w, tostring(math.floor(number)), text_style) 

  term1 = number 
  x = w
  y = 2 * ow
  z = 6 * w + ow

  for i = 1, dim do
       if (deg[i] ~= 0) then
	       for j = 1, deg[i] do
		       term2 = term1/prime[i]
               lib.add_input(z, y, 40, 40, lib.check_number(prime[i],20))			   
               lib.add_input(x, y+w, 80, 40, lib.check_number(term2,len))	
               term1 = term2
			   y = y + w
             len = len - 5
             x = x + 5
           end
       end
   end	   
   
  lib.end_canvas()
end 
