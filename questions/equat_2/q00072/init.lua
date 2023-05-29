
include("terms")
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
numb = 2
columns = 4
rows = 2

fun = {""}
enum = {}
denom = {}
ch = {}
coef = {}

index = {}
out = {}

xbroj = {}
ybroj = {}
yimen = {}
point = {""}

  q = {}

for i = 1, 4*numb do
    index[i] = i
end	

max_range = 5 

for i = 1,numb do
	enum[i] = {}
	denom[i] = {}
	ch[i] = {}
	for j = 1,2 do	   
		ch[i][j] = math.random(2) - 1
		enum[i][j] = max_range - math.random(2*max_range)
		if (j == 1 and enum[i][j] == 0) then
			enum[i][j] = math.random(max_range)
		end		
		if (ch[i][j] == 0) then
			denom[i][j] = 1 
		else
			denom[i][j] = 1 + math.random(max_range)
			qq = lib.math.gcd(enum[i][j], denom[i][j])
			enum[i][j] = math.floor(enum[i][j]/qq)
			denom[i][j] = math.floor(denom[i][j]/qq)
			if (denom[i][j] == 1) then
				ch[i][j] = 0
			else
				tmp = enum[i][j]/denom[i][j]
				rest = 10*tmp - math.floor(10*tmp)				
				if (rest == 0) then
					enum[i][j] = 10 * tmp
					denom[i][j] = 10
					ch[i][j] = 1
				else
					ch[i][j] = 2			
				end	
			end				
		end
	end
end		
for i = 1,2*numb do
	enum[i+numb] = {}
	denom[i+numb] = {}
	ch[i+numb] = {}
	for j = 1,2 do	
		ch[i+numb][j] = ch[i][j]
		denom[i+numb][j] = denom[i][j]
    end		
	if (i <= numb) then	
		enum[i+numb][1] = -enum[i][1] 
		enum[i+numb][2] = enum[i][1] 	
    else	
		enum[i+numb][1] = enum[i-numb][1] 
		enum[i+numb][2] = -enum[i-numb][1] 	
	end	
end
 
for i = 1,4*numb do	
  	fun[i] = ""
	coef[i] = {}	
	fct = 1 + math.random(4)
	eqv = 3*numb
	if (i > eqv) then
		coef[i][1] = fct * coef[i-eqv][1]
		coef[i][2] = fct * coef[i-eqv][2]	
		coef[i][3] = fct * coef[i-eqv][3]	
	else			
		coef[i][1] = enum[i][1] * denom[i][2]
		coef[i][2] = -denom[i][1] * denom[i][2]	
		coef[i][3] = -enum[i][2] * denom[i][1]	
		if (coef[i][1] < 0) then
			for j = 1,3 do
				coef[i][j] = -coef[i][j]
			end	
		end	
		q1 = lib.math.gcd(coef[i][1], coef[i][2])
		q2 = lib.math.gcd(coef[i][2], coef[i][3])
		qq = lib.math.gcd(q1, q2)
		for j = 1,3 do
			coef[i][j] = math.floor(coef[i][j]/qq)
		end	
	end
	termx = "x"				
	if (coef[i][1] ~= 1) then
		termx = tostring(coef[i][1]).. termx	
	end
	termy = "y"
	sgy = "+"
	if (coef[i][2] < 0) then
		sgy = "-"
	end
	tmpy = math.abs(coef[i][2])
	if(tmpy ~= 1) then
		termy = tostring(tmpy).. termy	
	end	
	termf = tostring(coef[i][3])	
	fun[i] = termx .. sgy .. termy .. " = " .. termf					
end	

out = lib.math.random_shuffle(index)
       
--[[ tacke]]--
nr = 0
for i = 1,columns do
    q[i-1] = {""}
	xbroj[i] = max_range - math.random(2*max_range)
	choice = math.random(rows+1)
    point[i] = "( " .. tostring(xbroj[i]) .. ", " 
	if (choice == rows+1) then
		ybroj[i] = max_range - math.random(2*max_range)	
		yimen[i] = 1 + math.random(max_range)
	else
		ybroj[i] = -coef[out[choice]][1]*xbroj[i] + coef[out[choice]][3]
		yimen[i] = coef[out[choice]][2] 
		if (yimen[i] < 0) then
			ybroj[i] = -ybroj[i]
			yimen[i] = -yimen[i]
		end
	end
	if (i > 1) then
		for k = 1,i-1 do
		    if (xbroj[i] == xbroj[k] and ybroj[i]/yimen[i] == ybroj[k]/yimen[k]) then
			    xbroj[i] = max_range - math.random(2*max_range)
				ybroj[i] = max_range - math.random(2*max_range)	
				yimen[i] = 1 + math.random(max_range)	
			end
		end
    end		
	qq = lib.math.gcd(ybroj[i], yimen[i])
	ybroj[i] = math.floor(ybroj[i]/qq)
	yimen[i] = math.floor(yimen[i]/qq)
	if (yimen[i] == 1) then
		point[i] = point[i] .. tostring(ybroj[i]) 
	else
		point[i] = point[i] .. "\(\frac{" .. tostring(ybroj[i]) .. "}{" .. tostring(yimen[i]) .. "}\)"				
	end		
    point[i] = 	point[i] .. ")"
    for j = 1,rows do
		tmp = (-coef[out[j]][1]*xbroj[i] + coef[out[j]][3])/coef[out[j]][2] 
        if (tmp == ybroj[i]/yimen[i]) then
            q[i-1][j] = answ[1]
        else
            q[i-1][j] = answ[2]
        end
    end	
    if (q[i-1][1] == answ[1] and q[i-1][2] == answ[1]) then	
	    nr = nr + 1
	end
end  

if (nr > 1) then
	ind = 1  
else	
	ind = 2
end
if ((out[2] == out[1] + 3*numb) or (out[1] == out[2] + 3*numb)) then
	ind = 1  
end
            
addition_table = function()

  style = {}
  style["text-align"] = "center"
  style["width"] = "90px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("(x,y)", style)  
  for j = 1, rows do    
	text = text .. lib.add_cell(fun[out[j]], style)
  end
  text = text .. lib.end_row()
  for c=0,columns-1 do
      text = text .. lib.start_row()
	  text = text .. lib.add_cell(point[c+1], style)  
	for j = 1, rows do    
		text = text .. lib.add_cell(lib.check_one_option_dropdown(answ, q[c][j]), style)	
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end                      
   