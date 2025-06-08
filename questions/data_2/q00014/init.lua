
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.2"};

text_style = {["font_size"] = "16"}
        
proc = "%"
index = {}
out = {}

per1 =  9 + math.random(7);

index = {1, 2, 4, 5, 8}
out = lib.math.random_shuffle(index)
per2 = out[1]

numb1 = 4 + math.random(7)
alk = numb1 * per1
numb2 = lib.math.round_dec(alk/per2, 2)
alk = lib.math.round_dec(alk/100, 2)
result = lib.math.round_dec(numb2 - numb1, 2)

mycanvas = function()

  lib.start_canvas(350, 180, "center")

  wh = 110
  wv = 40
  ow = 10

    lib.add_line(ow, ow, 3*wh, 0, style, false, false)
  for i = 1,3 do
    lib.add_line(ow, ow+(i+ 1)*wv, 3*wh, 0, style, false, false)
  end
  
  for i = 1,4 do
    lib.add_line(ow+(i-1)*wh, ow, 0, 4*wv, style, false, false)
  end  
  
  lib.add_input(3*ow, 2*ow, 80, 30, title[1])
  lib.add_input(3*ow, 4*ow, 80, 30, title[2]) 
  lib.add_input(3*ow, 6*ow, 80, 30, "l")  

  lib.add_input(3*ow+wh, 2*ow , 90, 30, title[3])
  lib.add_input(3*ow+wh, 4*ow , 90, 30, title[4]) 
  lib.add_input(3*ow+wh, 6*ow, 90, 30, proc)  

  lib.add_input(3*ow+2*wh, 2*ow , 80, 30, title[1])
  lib.add_input(3*ow+2*wh, 4*ow , 80, 30, title[4]) 
  lib.add_input(3*ow+2*wh, 6*ow, 80, 30, "l")  
  
  lib.add_text(6*ow, 3*wv-ow, tostring( numb1), text_style)
  lib.add_text(6*ow+wh, 3*wv-ow, math.floor(per1), text_style)
  lib.add_input(4*ow+2*wh, 3*wv-2*ow, 60, 40, lib.check_number(alk,40))
  
  lib.add_input(4*ow, 4*wv-2*ow, 60, 40, lib.check_number(numb2,40))  
  lib.add_text(6*ow+wh, 4*wv-ow, math.floor(per2), text_style)
  lib.add_input(4*ow+2*wh, 4*wv-2*ow, 60, 40, lib.check_number(alk,40))
  
  lib.end_canvas()
end
           