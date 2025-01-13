
include("terms")

text = {""}

grane = 3 + math.random(5)
ng = math.random(grane - 2)
tmp = math.floor(grane/(grane - ng))
nv1 = 3 + math.random(4)
nv2 = nv1 * tmp + math.random(5)
vrane = nv2 * (grane - ng)     
vfree = vrane - nv1 * grane
if (vfree < 0) then
   fct = 1 + math.random(3)
   grane = nv2 * fct
   ng = (nv2 - nv1) * fct
   vrane = nv1 * grane
   vfree = 0
end

if (nv1 < 5) then
    if (nv1 < 2) then
		text[1] = msg[1]
	else
		text[1] = msg[2]	
	end
else
    text[1] = msg[3]
end	
tmp = math.abs(vfree)
if (tmp < 5) then
    if (tmp < 2) then
		text[2] = msg[1]
	else
		text[2] = msg[2]	
	end
else
    text[2] = msg[3]
end	
if (nv2 < 5) then
    if (nv2 < 2) then
		text[3] = msg[1]
	else
		text[3] = msg[2]	
	end
else
    text[3] = msg[3]
end	
if (ng < 5) then
    if (ng < 2) then
		text[4] = msg[4]
	else
		text[4] = msg[5]
    end		
else
    text[4] = msg[6]
end	

equ = ""
equ =  lib.check_number(nv1, 20) .. " " .. lib.check_string("g", 20) .. lib.check_string("+", 15) .. lib.check_number(vfree, 20).. " = " .. lib.check_number(nv2,20) .. "( " .. lib.check_string("g", 20) .. lib.check_string("-", 15) .. lib.check_number(ng,20) .. " )"              
          
            
           