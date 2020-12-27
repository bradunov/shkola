include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};

text_style = {["font_size"] = "16"}

colour_style = {["off_color"] = "f00",
        ["on_color"] = " f00",
        ["line_color"] = "f00",
                ["font_size"] = "16"}


dim = 6

number = {}
numround = {}
decade = {}
cifre = {}

for j = 1,dim do
    dig = 2 + math.random(5)
    cifre[dig] = math.random(9)
    number[j] = cifre[dig]
    for i = 1, dig-1 do
        cifre[dig-i] = math.random(10) - 1
        number[j] = number[j]  * 10 + cifre[dig - i]
    end	
	
    index = math.random(dig-1)
    decade[j] = 10^index	
    if (cifre[index] >= 5) then
        cifre[index+1] = cifre[index+1] + 1
    end	

    for i = 1, index do 
        cifre[i] = 0
    end	

    numround[j] = cifre[dig]
    for i = 1, dig-1 do    
        numround[j] = numround[j]  * 10 + cifre[dig - i]
    end
end		



mycanvas = function()

  lib.start_canvas(350, 320, "center")

  wh = 100
  wv = 40
  ow = 10
   v = 5
  
    lib.add_line(v, ow, 3*ow+3*wh, 0, style, false, false)

  for i = 1,dim+1 do
    lib.add_line(v, 2*ow+i*wv, 3*ow+3*wh, 0, style, false, false)
  end
  
  lib.add_line(v, ow, 0, 3*wh-ow, style, false, false)
  lib.add_line(v+ow+wh, ow, 0, 3*wh-ow, style, false, false)
  lib.add_line(v+2*(ow+wh), ow, 0, 3*wh-ow, style, false, false)
  lib.add_line(v+3*(ow+wh), ow, 0, 3*wh-ow, style, false, false)
  
  lib.add_text(ow+wv, 2*ow, header_arr[1], text_style)
  lib.add_text(ow+wv, 4*ow, header_arr[2], text_style) 
  lib.add_text(wh+wv+2*ow, 2*ow, header_arr[3], text_style)
  lib.add_text(wh+wv+2*ow, 4*ow, header_arr[4], text_style)   
  lib.add_text(2*(wh+wv), 2*ow, header_arr[5], text_style)
  lib.add_text(2*(wh+wv), 4*ow, header_arr[6], text_style)  

  x = wv + 2*ow  
  for i = 1,dim do
      y = (i+1)*wv
      if (i == 1) then
          lib.add_text(x, y, decade[i], colour_style)
   	  lib.add_text(x+wh, y, number[i], colour_style)	
    	  lib.add_text(x+2*wh+ow, y, numround[i], colour_style) 
      else
          lib.add_text(x, y, decade[i], text_style)
   	  lib.add_text(x+wh+ow, y, number[i], text_style)			  
	  lib.add_input(x+2*(wh-ow), y-ow,80, 40, lib.check_number(numround[i],60))
      end		  
  end 

  lib.end_canvas()
end
                                     
            
       