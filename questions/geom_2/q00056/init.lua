 
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};
								

meas = {"\(^\circ\)", "'"}
numb = {"\(\small\alpha\)", "\(\small\beta\)", "\(\small\gamma\)", "\(\small\alpha_1\)", "\(\small\beta_1\)", "\(\small\gamma_1\)" }

name = {"BC", "AB", "AC"}
answ = {"=", ">", "<"}
            
mycanvas = function(no)

  ow = 5
  w = 125
  ov = 75
  v = 20

  lib.start_canvas(250, 100, "center") 
          
           
    lib.add_straight_path(v, ov, {{w+v+5*ow, 0}, {-ov, -3*v}, {-ov, 3*v} }, style, true, false) 
    lib.add_line(w+ov-2*ow, ov, v, 0, style, false, false)
    lib.add_line(w-2*ow, v-ow, v, -v+4, style, false, false)  

    lib.add_input(ov+ow, 0, 50, 20, "A")
    lib.add_input(v, ov, 50, 20, "B") 
    lib.add_input(w+2*v, ov, 50, 20, "C") 

    lib.add_input(ov+3*ow, 3*ow, 50, 30, numb[1])
    lib.add_input(w-3*ow, ow, 50, 30, numb[4])	
    lib.add_input(2*v, ov-v, 50, 30, numb[2]) 
    lib.add_input(ow, ov-v, 50, 30, numb[5])
    lib.add_input(w+v-ow, ov-v, 50, 30, numb[3]) 	
    lib.add_input(w+2*(v+ow), ov-v, 50, 30, numb[6])	
    
  lib.end_canvas()
end    