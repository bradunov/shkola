
style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "3"};

marker_style = 
	{["off_color"] = "fff",
        ["on_color"] = "6f6",
        ["line_color"] = "000",
        ["line_width"] = "1"};


mycanvas = function(result)

ow = 10
vo = 40
vs = 50
vp = 60
vc = 70

  lib.start_canvas(350, 330, "center", result)

--[[  petougao  ]]--
  lib.add_straight_path(2*ow, vs, {{vp, -vo}, {vp, vo}, {-3*ow, vp}, {-vp, 0}, {-3*ow, -vp}}, style,  false, false)
  lib.add_input(vc, 2*vp, 30, 30, lib.check_number(5, 15))  

--[[ sestougao  ]]--  
  lib.add_straight_path(4*vs, vo, {{vs, -3*ow}, {vs, 3*ow}, {0, vs}, {-vs, 3*ow}, {-vs, -3*ow}, {0, -vs}}, style,  false, false)
  lib.add_input(4*vp, 2*vp+ow, 30, 30, lib.check_number(6, 15))  

--[[  osmougao  ]]--
  lib.add_straight_path(vo, 5*vs, {{0, -vo}, {2*vo/3, -2*vo/3}, {vo, 0}, {2*vo/3, 2*vo/3}, {0, vo}, {-2*vo/3, 2*vo/3}, {-vo, 0}, {-2*vo/3, -2*vo/3}}, style,  false, false)
  lib.add_input(vc, 7*vo+ow, 30, 30, lib.check_number(8, 15))  

--[[ cetvorougao  ]]--  
  lib.add_straight_path(4*vs, 5*vs, {{3*vc/4, -vc}, {vc/4, vc}, {-3*vc/4, vc}, {-vc/4, -vc}}, style,  false, false)
  lib.add_input(4*vp, 7*vo+ow, 30, 30, lib.check_number(4, 15))  
  
  lib.end_canvas()
end            
          
