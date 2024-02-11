
include("terms")

include("names")

style = 
	{["off_color"] = "none",
        ["on_color"] = "none",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
			
box_style = {["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "f30",
        ["off_line_color"] = "fff",		
        ["line_width"] = "0.2"};	

dif_style = {["line_color"] = "000",
        ["line_width"] = "0.5"};

line_style = {["line_color"] = "f30",
        ["line_width"] = "2"};

text_style = {["font_size"] = "16"}	

ime = {""}
rf = math.random(#zensko_ime_nom)
ime[1] = zensko_ime_nom[rf] 
rm = math.random(#musko_ime_nom)
ime[2] = musko_ime_nom[rm]

denom = { 2, 4, 5, 8, 10}
space = "\( \ \ \ \) " 

x = {}
y = {}
px = {}
py = {}
numb = {}
broj = {}
imen = {}
value = {}
arg = {}
quest = {""}
answ = {""}

for i = 1,2 do
	ch = math.random(5)
	imen[i] = denom[ch]	
	broj[i] = math.random(imen[i] - 1)
	if (i == 2 and imen[2] ~= 2) then 
		if (broj[2] == broj[1] and imen[2] == imen[1]) then
			broj[2] = broj[2] + 1
        end
    end	
	value[i] = broj[i] / imen[i]
    arg[i] = 2*math.pi / imen[i]	
    quest[i] = "\(\frac{" .. broj[i] .. "}{" .. imen[i] .. "}\)"	
end

answ = {ime[1], ime[2], msg[1]}
brojilac = broj[1] * imen[2] - broj[2] * imen[1]
imenilac = imen[1] * imen[2]
if (brojilac == 0) then
    ind = msg[1]
    reply = ""
else
    if (brojilac > 0) then 
		ind = ime[1]	 
    else
		ind = ime[2]
        brojilac = - brojilac		
	end	
	val = brojilac/imenilac
	qq = lib.math.gcd(imenilac, brojilac)
	condition = "is_ok = math.eq(numerator/denominator, "..tostring(val)..");"
	solution = "numerator="..tostring(brojilac/qq)..";denominator="..tostring(imenilac/qq)..";"			
    reply = msg[2] .. space .. lib.check_fraction_condition(condition, nil, nil, solution) 
end	
		
		
results = ""
  
for i = 1,imen[1] do  
    if (i > 1) then
        results = results .. "&& "
    end
    results = results .. "result[" .. tostring(i-1) .. "] == "
    if (i <= broj[1]) then
	    results = results .. "1 "
	else
	    results = results .. "0 "
	end	
end	
 
for i = 1,imen[2] do 
    j = i + imen[1]
    results = results .. "&& " .. "result[" .. tostring(j-1) .. "] == "
    if (i <= broj[2]) then
	    results = results .. "1 "
	else
	    results = results .. "0 "
	end	
end	  

mycanvas = function(no)

  lib.start_canvas(300, 150, "center", results)  
  
	w = 70
	ow = 10
	ov = 170
	r = 50
	
	x[1] = w 
	x[2] = ov + r
	y[1] = ow + r
	y[2] = y[1]
		
	for i = 1,2 do
	    px[i] = {}
	    py[i] = {}
		if (imen[i] ~= 2) then
			for j = 1, imen[i] do
				dx = math.cos(j*arg[i]) 
				dy = math.sin(j*arg[i])	
				px[i][j] = x[i] + r*dx 
				py[i][j]= y[i] - r*dy	
				if (j > 1) then			
					lib.add_straight_path (x[i], y[i], {{px[i][j-1]-x[i], py[i][j-1]-y[i]}, {px[i][j]-px[i][j-1], py[i][j]-py[i][j-1]}, {x[i]-px[i][j], y[i]-py[i][j]}}, box_style,  false, true)												
				else
					lib.add_straight_path (x[i], y[i], {{r, 0}, {px[i][1]-x[i]-r, py[i][1]-y[i]}, {x[i]-px[i][1], y[i]-py[i][1]}}, box_style,  false, true)												
				end			
			end
		else
        lib.add_curved_path (x[i]-r-5, y[i], {{r+5, -2*r, 2*r+ow, 0}}, box_style,  false, true)	        
        lib.add_curved_path (x[i]-r-5, y[i], {{r+5, 2*r, 2*r+ow, 0}}, box_style,  false, true)				
		end
    end

	for i = 1, 2 do		
		for j = 1, imen[i] do
			dx = math.cos((j-1)*arg[i]) 
			dy = math.sin((j-1)*arg[i])		
			lib.add_line(x[i], y[i], r*dx, -r*dy, dif_style, false, false)
		end	
		lib.add_circle (x[i], y[i], r, style, true, false)			
		lib.add_line(x[i], y[i], r, 0, line_style, false, false)		
		lib.add_text(x[i], y[i]+3*r/2, ime[i], text_style, false, false)		
	end	
	
  lib.end_canvas()
  
end                    
            