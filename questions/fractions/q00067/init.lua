
include("names")

r = math.random(#zensko_ime_nom)
name = zensko_ime_nom[r]

style = {["off_color"] = "fff",
         ["on_color"] = "fff",
         ["line_color"] = "000",
         ["line_width"] = "1"};

red_style = {["off_color"] = "f30",
         ["on_color"] = "f30",
         ["line_color"] = "000",
         ["line_width"] = "2"};

blue_style = {["off_color"] = "cff",
               ["on_color"] = "cff",
               ["line_color"] = "000",
               ["line_width"] = "2"};

brown_style = {["off_color"] = "c60",
               ["on_color"] = "c60",
               ["line_color"] = "000",
               ["line_width"] = "2"};

                                                                                                                                                                                                                                                                                              
line_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f30",
        ["off_line_color"] = "000",
        ["line_width"] = "3"}; 

text_style = {["font_size"] = "12"}


numb = 1100 + 50 * math.random(15)
total = lib.math.round_dec(numb / 1000,2)
teg_s = 200 + 10 * (5 + math.random(15))
teg_b = teg_s + 10 * (10 + math.random(20))
rest = numb - teg_b - teg_s
	
mycanvas = function()
  
  lib.start_canvas(300, 150, "center")

  ow = 20
  ov = 50
  v = 5
  w = 100

lib.add_circle(2*(w+ow)-3, ov+v, ow+v, style, false, false)  
  
lib.add_straight_path(ov, 2*(ov+v), {{2*w-v, 0}}, line_style, false, true)

  lib.add_circle (ov+v, w, 2*v, brown_style, false, false)
  lib.add_rectangle (ow-v, w-ow, ov+ow+v, ow/2, brown_style, false, false)
  lib.add_circle (2*(w+ow), w, 2*v, brown_style, false, false)
  lib.add_rectangle (2*w, w-ow, ov+ow+v, ow/2, brown_style, false, false)
  lib.add_triangle (w+ov, 3*ov-ow, ov-ow, ov-ow, brown_style, false, true)
  lib.add_circle (w+ov, w+2*v, v, style, false, false)

  lib.add_rectangle(ow, ov-ow, ov-ow, ov, blue_style, false, false)
  lib.add_circle(ov-ow+v, ow+v-3, v+3, blue_style, true, false)
  lib.add_text(2*ow-v, ov, tostring(teg_b), text_style, false, false)
  lib.add_rectangle(3*ow, 3*ow-v, ow+v, ow+v, blue_style, false, false)
  lib.add_circle(3*ow+2*v+3, 2*(ow+v), v, blue_style, true, false)
  lib.add_text(ov+ow+3, ow+ov, tostring(teg_s), text_style, false, false)

  
lib.add_straight_path (2*w+v, 2*ow, {{2*v, 2*ow}, {ov-v,0}, {2*v, -2*ow}, {-ov-ow+v,0}}, red_style, false, false)

  lib.end_canvas()
end       