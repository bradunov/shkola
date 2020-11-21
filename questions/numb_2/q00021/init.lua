
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.5"};

text_style = {["font_size"] = "16"}

colour_style = {["off_color"] = "f90",
                ["font_size"] = "16"}


title = {}
title[1] = "cifra jedinica paran broj."
title[2] = "zbir cifara deljiv sa 3."
title[3] = "cifra jedinica 0 ili 5."
title[4] = "broj paran i zbir cifara mu je deljiv sa 3."
title[5] = "zbir cifara deljiv sa 9." 
title[6] = "cifara jedinica 0." 
title[7] = "dvocifreni završetak deljiv sa 4."

div = {2, 3, 5, 6, 9, 10, 4}

out = {}
index = {1,2,3,4,5,6,7}
out = lib.math.random_shuffle(index)

stampa = 5

mycanvas = function()

  lib.start_canvas(350, 300, "center")

  wh = 100
  wv = 40
  ow = 10
  
    lib.add_line(2, ow, 3*ow+3*wh+8, 0, style, false, false)

  for i = 1,stampa + 1 do
    lib.add_line(2, i*(wv+ow), 3*ow+3*wh+8, 0, style, false, false)
  end
  y = (3*stampa-1)*wv/2+ow
  lib.add_line(2, ow, 0, y, style, false, false)
  lib.add_line(4*ow, ow, 0, y, style, false, false)
  lib.add_line(4*ow+3*wh, ow, 0, y, style, false, false) 
  lib.add_text(wh-2*ow, 3*ow, "ako je ", text_style)

  
  for i = 1,stampa do
      lib.add_input(ow/2, ow+i*(wv+ow),30, 30, lib.check_number(div[out[i]],15))  
      lib.add_text(2*wh-ow, 2*ow+i*(wv+ow), title[out[i]], text_style, false, false)  
   
  end

  lib.end_canvas()
end
          