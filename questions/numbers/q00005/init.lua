
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};

different_style = 
	{["off_color"] = "fff",
        ["on_color"] = "faf",
        ["line_color"] = "000",
        ["line_width"] = "1"};


red_line = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f00",
        ["line_width"] = "3"};


text_style = {["font_size"] = "14"}

mycanvas = function(no)
  lib.start_canvas(350, 100, "center")

  hscale = 1.2
  vscale = 5
  ow = 25
  w = 20
  
  first = 0
  mid1 = 1
  last =  10   
  mid2 = 3 + math.random(4)

  numb1 = mid1 + math.random(mid2-mid1-1)
  numb2 = mid2 + math.random(last-mid2-1)


  lib.add_straight_path(20*hscale, 9*vscale, {{280*hscale, 0}}, style, false, true)
  
  for i = 1, 11 do 
      lib.add_straight_path((w+(i-1)*ow)*hscale, 8*vscale, {{0, 10}}, style, false, true)
  end

  lib.add_text((w+first*ow)*hscale, 6*vscale, first, text_style)
  lib.add_text((w+mid1*ow)*hscale, 6*vscale, mid1, text_style)
  lib.add_text((w+mid2*ow)*hscale, 6*vscale, mid2, text_style)  
  lib.add_text((w+last*ow)*hscale, 6*vscale, last, text_style)  
  
  lib.add_input((5+ow*numb1)*hscale, 3*vscale, 35, 30, lib.check_number(numb1,10))
  lib.add_input((5+ow*numb2)*hscale, 3*vscale, 35, 30, lib.check_number(numb2,10))  
  
  lib.end_canvas()
end   
           
     
          
            