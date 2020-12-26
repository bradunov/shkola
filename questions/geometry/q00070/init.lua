include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "0.3"};
			   
red_style = {["off_color"] = "fff",
               ["on_color"] = "f30",
               ["line_color"] = "000",
               ["line_width"] = "3"};	

text_style = {["font_size"] = "14"}	

circ = {22, 16, 24}

out = {}
reply = {}

sol = {}
sol[1] = {""}
sol[2] = {""}
sol[3] = {""}

line = {}
line[1] = {""}
line[2] = {""}
line[3] = {""}

line[1] = {"EF", "FE", "FG", "GF", "GH", "HG", "HE", "EH"}
line[2] = {"AB", "BA", "BC", "CB", "CD", "DC", "DA", "AD"}
line[3] = {"MN", "NM", "NP", "PN", "PM", "MP"}

out = lib.math.random_shuffle(fig)	

ind = math.random(3)

for i = 1,2 do
    reply[i] = "answer == '" .. line[i][1] .. "' "  ..
           "|| answer == '" .. line[i][2] .. "'" ..
           "|| answer == '" .. line[i][3] .. "'" ..
           "|| answer == '" .. line[i][4] .. "'" ..	
           "|| answer == '" .. line[i][5] .. "'" ..
           "|| answer == '" .. line[i][6] .. "'" ..
           "|| answer == '" .. line[i][7] .. "'" ..			   
           "|| answer == '" .. line[i][8] .. "'" ; 
   for j = 1,4 do
       jj = 2*j-1
       sol[i][j] = "answer = '" .. line[i][jj] .. "' " 
   end 
end

reply[3] = "answer == '" .. line[3][1] .. "' "  ..
           "|| answer == '" .. line[3][2] .. "'" ..
           "|| answer == '" .. line[3][3] .. "'" ..
           "|| answer == '" .. line[3][4] .. "'" ..	
           "|| answer == '" .. line[3][5] .. "'" ..
           "|| answer == '" .. line[3][6] .. "'" ;
for j = 1,3 do
    jj = 2*j-1
    sol[3][j] = "answer = '" .. line[3][jj] .. "' " 
end 
   
if (ind == 3) then
    ans = lib.check_string(reply[ind], 20, sol[3][1]) .. ", " .. lib.check_string(reply[ind], 20, sol[3][2]) .. ", " .. lib.check_string(reply[ind], 20, sol[3][3]) 
    remark = remark_str 
else
    ans = lib.check_string(reply[ind], 20, sol[ind][1]) .. ", " .. lib.check_string(reply[ind], 20, sol[ind][2]) .. ", " .. lib.check_string(reply[ind], 20, sol[ind][3]) .. ", " .. lib.check_string(reply[ind], 20, sol[ind][4])
	remark = " "
end	


mycanvas = function()

if (ind == 1) then
   results = "result[0] == 0 && result[1] == 1 && result[2] == 0" 
end
if (ind == 2) then
   results = "result[0] == 1 && result[1] == 0 && result[2] == 0" 
end
if (ind == 3) then
   results = "result[0] == 0 && result[1] == 0 && result[2] == 1" 
end     

  lib.start_canvas(280, 280, "center", results)


  w = 18
  ow = 10
  v = 5

  lib.add_rectangle (ow+2*w, ow+w, 4*w, 4*w, red_style,  false, true)
  lib.add_text(ow+w+v, ow+5*w, "A", text_style, false, false)
  lib.add_text(2*ow+6*w, ow+5*w, "B", text_style, false, false)
  lib.add_text(2*ow+6*w, ow+w, "C", text_style, false, false)
  lib.add_text(ow+w+v, ow+w, "D", text_style, false, false)

  lib.add_rectangle (ow+9*w, ow+w, 4*w, 7*w, red_style,  false, true)
  lib.add_text(2*ow+8*w-v, ow+8*w, "E", text_style, false, false)
  lib.add_text(2*ow+13*w, ow+8*w, "F", text_style, false, false)
  lib.add_text(2*ow+13*w, ow+w, "G", text_style, false, false)
  lib.add_text(2*ow+8*w-v, ow+w, "H", text_style, false, false)

  lib.add_straight_path (ow+2*w, ow+13*w, {{8*w,0}, {-8*w, -6*w}, {0,6*w}}, red_style, false, true) 
  lib.add_text(ow+w+v, ow+13*w, "M", text_style, false, false)
  lib.add_text(2*ow+10*w, ow+13*w, "N", text_style, false, false)
  lib.add_text(ow+w+v, ow+7*w, "P", text_style, false, false)  

  for i = 1,15 do
    lib.add_line(ow, ow+(i-1)*w, 14*w, 0, style, false, false)
  end

  for i = 1,15 do
    lib.add_line(ow+(i-1)*w, ow, 0, 14*w, style, false, false)
  end

  lib.end_canvas()
end   
 