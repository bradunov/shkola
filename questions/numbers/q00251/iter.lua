
include("terms")

numb = {}

numb[1] = 5110 + math.random(4000);
numb[2] = 1990 + math.random(3000);

ind = math.random(4)
ch = math.random(3) - 1
degr = lib.math.round(10^ch)
if (ind < 3) then
    numb[3] = numb[1] + 10^ch	
else	
    numb[3] = numb[1] - 10^ch
end	
if (ind == 1 or ind == 3) then
    numb[4] = numb[2] + 10^ch	
else	
    numb[4] = numb[2] - 10^ch
end	

sg = math.random(2)
if (sg == 1) then
    sign = "+"
	val_left = numb[1] + numb[2]
	val_right = numb[3] + numb[4]
else
    sign = "-"
	val_left = numb[1] - numb[2]
	val_right = numb[3] - numb[4]
end
if (val_left == val_right) then
    rel = ans[1]
else	
    rel = ans[2]
end	 
  