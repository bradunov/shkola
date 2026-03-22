
style = 
       {["off_color"] = "000",
        ["on_color"] = "000",
        ["line_color"] = "000",
        ["line_width"] = "2"};
		
point_style = 
       {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "1"};		

text_style = {["font_size"] = "14"}

pt = {}
dist = {}
number = {}

term = math.random(10) - 21
add = math.random(4) 

temp = term + 9 * add
if (temp <= 0) then
    add = 4
end

number[1] = term 
for i = 1, 9 do
    number[i+1] = (term + i*add)  
end	

first = "M"
mid = "O"
last = "N"
pt[1] = -math.random(11)
pt[2] = 1 + math.random(14)
pt[3] = (pt[2] + pt[1])/2
pt[4] = pt[2]/2
if (pt[4] == pt[3]) then
    pt[1] = pt[1] - 2
end
pt[3] = (pt[2] + pt[1])/2

for i = 1,2 do
    dist[i] = math.abs(pt[i])
end
dist[3] = math.abs(pt[4] - pt[3])

mycanvas = function(no)
  lib.start_canvas(320, 100, "center")

  hscale = 0.7
  vscale = 5

  lib.add_straight_path(30*hscale, 15*vscale, {{380*hscale, 0}}, style, false, true)
  for i = 1, 15 do  
	  x = 50 + (i-1)*25
          if ( i == 7) then
 lib.add_straight_path(x*hscale, 13*vscale, {{0, 20}}, style, false, true)
else
	  lib.add_straight_path(x*hscale, 14*vscale, {{0, 10}}, style, false, true)
end
  end  
  lib.add_text(100*hscale, 11*vscale, first, text_style) 
  lib.add_text(200*hscale, 11*vscale, mid, text_style)  
  lib.add_circle (200*hscale, 15*vscale, 3, point_style, false, false)
  lib.add_text(350*hscale, 11*vscale, last, text_style) 
   
  lib.end_canvas()
end     
       