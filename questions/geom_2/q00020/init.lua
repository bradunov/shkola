
style = 
	{["off_color"] = "cff",
        ["on_color"] = "cff",
        ["line_color"] = "000",
        ["line_width"] = "1"};
		
dot_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2",};

text_style = {["font_size"] = "16"}		

x = {}
y = {}
mark = {}
qq = {}

mark = {"P", "Q", "R", "S", "T"}

symb = "\(\angle\)"

qq[1] = {"TPS", "SPQ", "TPQ"}
qq[2] = {"PQR"}
qq[3] = {"QRT", "TRS", "QRS"}
qq[4] = {"RSP", "PST", "RST"}
qq[5] = {"STR", "RTP", "STP"}


ind = math.random(5)

point = mark[ind]
reply = ""
for i = 1,5 do
    if (i == ind) then
	    if (ind == 2) then
            reply = "answer == '" .. qq[i][1] .. "'" ;	
            ans = "answer = '" .. qq[i][1] .. "' ";		
		else
            reply = "answer == '" .. qq[i][1] .. "," .. qq[i][2] .. "," .. qq[i][3] .. "' "  ..
                "|| answer == '" .. qq[i][1] .. "," .. qq[i][3] .. "," .. qq[i][2] .. "' "  ..
                "|| answer == '" .. qq[i][2] .. "," .. qq[i][1] .. "," .. qq[i][3] .. "' "  ..
                "|| answer == '" .. qq[i][2] .. "," .. qq[i][3] .. "," .. qq[i][1] .. "' "  ..
                "|| answer == '" .. qq[i][3] .. "," .. qq[i][1] .. "," .. qq[i][2] .. "' "  ..		
                "|| answer == '" .. qq[i][3] .. "," .. qq[i][2] .. "," .. qq[i][1] .. "'" ;		
            ans = "answer = '" .. qq[i][1] .. "," .. qq[i][2] .. "," .. qq[i][3] .. "' ";
		end	
	end
end	


mycanvas = function(no)

ow = 20
w = 10
v = 70
ov = 100

  lib.start_canvas(300, 200, "center")

  xx = v
  yy = v + ow
  x[1] = v-ow
  y[1] = -v  
  x[2] = v
  y[2] = 0  
  x[3] = v-ow
  y[3] = v  
  x[4] = -v-ow
  y[4] = v
  x[5] = -v-ow/2
  y[5] = -v  
   
  lib.add_straight_path(xx, yy, {{x[1], y[1]}, {x[2], y[2]}, {x[3], y[3]}, {x[4], y[4]}, {x[5], y[5]}}, style, true, false)

  xp = xx 
  yp = yy 
  for i = 1,5 do
      if (i <= 3) then 
          cor = -w
      else
          cor = w 
      end
      if (i == 3) then
         lib.add_text(xp+w, yp+cor, mark[i], text_style, false, false)
      else
         lib.add_text(xp+cor, yp+cor, mark[i], text_style, false, false)
      end
      lib.add_circle (xp, yp, 2, dot_style, false, false)
      xp = xp + x[i]
      yp = yp + y[i]
  end

  lib.add_straight_path(xx, yy, {{x[1]+x[2]+x[3], y[1]+y[2]+y[3]}}, style, true, false)
  lib.add_straight_path(xx+x[1]+x[2], yy+y[1]+y[2], {{x[3]+x[4], y[3]+y[4]}}, style, true, false)
		
  lib.end_canvas()
end
        