
style = {["off_color"] = "3c3",
        ["on_color"] = "3c3",
        ["line_color"] = "000",
        ["line_width"] = "2"};		

dif_style = {["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "000",
        ["line_width"] = "2"};				

px = {}
py = {}
pdx = {}
pdy = {}

numb = {}
quest = {""}
meas = {"cm", "m", "m²", "kg" } 
pi = 3.1416

numb[3] = 79 + math.random(19)
numb[1] = numb[3] + 50 + math.random(100)
numb[4] = 179 + math.random(21)
numb[2] = 5*(75 + math.random(25))
numb[5] = numb[1] - 60 - math.random(50)
numb[1] = lib.math.round_dec(numb[1]/100,1)
numb[2] = lib.math.round_dec(numb[2]/100,1)
numb[4] = lib.math.round_dec(numb[4]/100,1)
numb[5] = lib.math.round_dec(numb[5]/100,1)

area_b = 3 * numb[1] * numb[1] * math.sqrt(3) - numb[3] * numb[4]/100
area_m = 5 * numb[1] * numb[2] - 0.5 *numb[5] * numb[5] * pi
area = area_b + area_m

unit = 0.5 * (10 + math.random(10))
result = lib.math.round_dec(area / unit, 1)
unit = lib.math.round_dec(unit,1)

mycanvas = function(no)

  lib.start_canvas(240, 170, "center")

	w = 64
	ow = 8
	v = 56
	ov =  104

        py[1] = 2*ow
		px[1] = w
		py[2] = w + 2*ow
		px[2] = w
		py[3] = w + 2*ow
		px[3] = 2*w
		py[4] = 2*ow
		px[4] = 2*w					
		py[5] = ov
		px[5] = w
		py[6] = ov + v
		px[6] = w
		py[7] = ov + v 
		px[7] = 2*w
		py[8] = ov
		px[8] = 2*w		
		py[9] = w
		px[9] = 4*ow
		py[10] = ov + 2*ow
		px[10] = 4*ow
		py[11] = ov + 2*ow
		px[11] = ov + v
		py[12] = w
		px[12] = ov + v
		lib.add_straight_path (px[1], py[1], {{px[2]-px[1], py[2]-py[1]}, {px[3]-px[2], py[3]-py[2]}, {px[4]-px[3], py[4]-py[3]}, {px[1]-px[4], py[1]-py[4]}}, style, true, false)
		lib.add_straight_path (px[1], py[1], {{px[2]-px[1], py[2]-py[1]}, {px[10]-px[2], py[10]-py[2]}, {px[9]-px[10], py[9]-py[10]}, {px[1]-px[9], py[1]-py[9]}}, style, true, false)
		lib.add_straight_path (px[4], py[4], {{px[12]-px[4], py[12]-py[4]}, {px[11]-px[12], py[11]-py[12]}, {px[3]-px[11], py[3]-py[11]}, {px[4]-px[3], py[4]-py[3]}}, style, true, false)
		lib.add_straight_path (px[10], py[10], {{px[2]-px[10], py[2]-py[10]}, {px[3]-px[2], py[3]-py[2]}, {px[11]-px[3], py[11]-py[3]}, {px[7]-px[11], py[7]-py[11]}, {px[6]-px[7], py[6]-py[7]}, {px[10]-px[6], py[10]-py[6]}}, style, true, false)

        pdx[1] = w + 2*ow
		pdy[1] = ov + v
        pdx[2] = w + 2*ow
		pdy[2] = w + 5*ow 
        pdx[3] = 2*w - ow
		pdy[3] = w + 5*ow 
        pdx[4] = 2*w - ow
		pdy[4] = ov + v	
		lib.add_straight_path(pdx[1], pdy[1], {{pdx[2]-pdx[1], pdy[2]-pdy[1]}, {pdx[3]-pdx[2], pdy[3]-pdy[2]}, {pdx[4]-pdx[3], pdy[4]-pdy[3]}}, dif_style,  false, false)	

        pwx1 = w - 2*ow
        pwx2 = 2*w + 2*ow
		pwy = w+5
		lib.add_circle (pwx1, pwy, 15, dif_style, true, false)
		lib.add_circle (pwx2, pwy, 15, dif_style, true, false)	

  lib.end_canvas()
  
end          
           