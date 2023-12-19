
include("terms")

style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
			
box_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "none",
        ["line_width"] = "2"};	

dif_style = {["line_color"] = "000",
        ["line_width"] = "0.5"};

line_style = {["line_color"] = "000",
        ["line_width"] = "1"};

text_style = {["font_size"] = "16"}	

pt = {"A", "B", "C", "D", "E", "F", "G", "H", "P", "Q", "R", "S"}
x = {}
y = {}

ch = math.random(2)

number = 2 + math.random(4)
arg = math.pi / number

ind = math.random(2*number)
point = pt[ind]
	
fct = math.random(2*number-1)
angle = fct*180/number
if (ch == 1) then
    rot = ind + fct
else
    rot = ind - fct
end	
if (rot > 2*number-1) then
    rot = rot - 2*number
end	
if (rot <= 0) then
    rot = rot + 2*number
end		
reply = pt[rot]

mycanvas = function(no)

  lib.start_canvas(300, 240, "center")  
  
	w = 60
	ow = 10
	ov = 130

	r = 100
	xc = w + r
	yc = 2*ow + r
	lib.add_circle (xc, yc, r, style, true, false)
	for i = 1, 2*number do
        dx = math.cos((i-1)*arg) 
 		dy = math.sin((i-1)*arg)
		x[i] = xc + r*dx
		y[i] = yc - r*dy			
		lib.add_line(xc, yc, r*dx, -r*dy, line_style, false, false)
	end	
	lib.add_circle (xc, yc, 2, line_style, true, false)		
    lib.add_rectangle (xc-ow, yc-ow, 2*ow, 2*ow, box_style, false, false)	
	lib.add_text(xc, yc, "O", text_style, false, false)
		
	for i = 1, 2*number do
	    if (i <= number) then
			sgy = -ow
		else
			sgy = ow
        end	
	    if (i <= math.ceil(number/2) or i > math.floor(3*number/2)) then
			sgx = ow
		else
			sgx = -ow
        end					
		lib.add_circle (x[i], y[i], 2, line_style, true, false)		
		lib.add_text(x[i]+sgx, y[i]+sgy, pt[i], text_style, false, false)	
	end
	
  lib.end_canvas()
  
end    