
brown_style = 
	{["off_color"] = "c90",
        ["on_color"] = "c90",
        ["line_color"] = "000",
        ["line_width"] = "2"};	
				
yelow_style = {["off_color"] = "ff0",
        ["on_color"] = "ff0",
        ["line_color"] = "000",
        ["line_width"] = "2"};		


dif_style = {["off_color"] = "fff",
        ["on_color"] = "f30",
        ["line_color"] = "000",
        ["line_width"] = "1"};		

index = {}
out = {}
for i = 1,6 do
    index[i] = i
end
out = lib.math.random_shuffle(index)	
		
mycanvas = function()

  ind = math.random(6)

  results = ""

  for i = 1, 6 do
	if i > 1 then
		results = results .. " && "
	end
	results = results .. "result[" .. tostring(i-1) .. "] == "
	if (out[i] == ind) then
	  results = results .. "1"
	else
	  results = results .. "0"
	end
  end		


  lib.start_canvas(300, 260, "center", results)

    ov = 150 
	ow = 10
    v = 5
	hr = 40
	wr = 20
	ht = 20
	wt = 20
	
	shiftx =  wr + 2*wt + 4*ow	
	shifty =  80 
	
	xsabl = 80
	
	for i = 1,6 do 
		level = math.floor((i-1)/3)
		shift_x =  (i-1-3*level)*shiftx	
		shift_y =  level*shifty		
		x = 3*ow + shift_x
		y = ov + shift_y 			
		if (out[i] < 3) then
			xx = x		
			if (out[i] == 1) then
				style1 = brown_style
				style2 = yelow_style
			else
				style1 = yelow_style
				style2 = brown_style
			end
            if (out[i] == ind) then			
				for j = 1,2 do
					lib.add_triangle(xsabl+(j-1)*(wr+2*wt), hr, wt, ht, style1, true, false)
					lib.add_triangle(xsabl+(j-1)*(wr+2*wt) +wt, hr, wt, ht, style2, true, false)
					lib.add_rectangle(xsabl+(j-1)*(wr+2*wt) +2*wt-ow, ow, wr, hr, yelow_style, true, false)	
				end	
            end				
			lib.add_triangle(xx, y-ht+ow, wt, ht, style1, true, false)
			lib.add_triangle(xx+wt, y-ht+ow, wt, ht, style2, true, false)
			lib.add_rectangle(xx+2*wt-ow, y-hr, wr, hr, yelow_style, true, false)
		else
			if (out[i] < 5) then
				xx = x
				if (out[i] == 3) then
					style1 = brown_style
					style2 = yelow_style
				else
					style1 = yelow_style
					style2 = brown_style
				end	
				if (out[i] == ind) then			
					for j = 1,2 do
						lib.add_triangle(xsabl+(j-1)*(wr+2*wt), hr, wt, ht, style1, true, false)
						lib.add_rectangle(xsabl+(j-1)*(wr+2*wt) +wt-ow, ow, wr, hr, yelow_style, true, false)				
						lib.add_triangle(xsabl+(j-1)*(wr+2*wt) +2*wt, hr, wt, ht, style2, true, false)
					end	
				end					
				lib.add_triangle(xx, y-ht+ow, wt, ht, style1, true, false)
				lib.add_rectangle(xx+wt-ow, y-hr, wr, hr, yelow_style, true, false)				
				lib.add_triangle(xx+2*wt, y-ht+ow, wt, ht, style2, true, false)
			else	
				xx = x
				if (out[i] == 5) then
					style1 = brown_style
					style2 = yelow_style
				else
					style1 = yelow_style
					style2 = brown_style
				end	
				if (out[i] == ind) then			
					for j = 1,2 do
						lib.add_rectangle(xsabl+(j-1)*(wr+2*wt)-ow, ow, wr, hr, yelow_style, true, false)				
						lib.add_triangle(xsabl+(j-1)*(wr+2*wt)+wt, hr, wt, ht, style1, true, false)
						lib.add_triangle(xsabl+(j-1)*(wr+2*wt)+2*wt, hr, wt, ht, style2, true, false)						
					end	
				end						
				lib.add_rectangle(xx-ow, y-hr, wr, hr, yelow_style, true, false)								
				lib.add_triangle(xx+wt, y-ht+ow, wt, ht, style1, true, false)
				lib.add_triangle(xx+2*wt, y-ht+ow, wt, ht, style2, true, false)
			end	
        end
		lib.add_circle (xx+wt, y+ow+v, 6, dif_style, false, true)		
	end

  lib.end_canvas()
end
      