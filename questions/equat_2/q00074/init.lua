
include("terms")
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
numb = 2
columns = 3
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
sol = ""

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

if (coef[out[1]][2]*coef[out[2]][1] == coef[out[1]][1]*coef[out[2]][2]) then
	sing = 1
else
	sing = 0		
end		
for i = 1,columns do
    q[i-1] = {""}
	point[i] = "("
	choice = math.random(2)	
	if (i == 3 and sing == 0) then    
		xbroj[i] = coef[out[1]][3]*coef[out[2]][2] - coef[out[2]][3]*coef[out[1]][2]
		ybroj[i] = coef[out[1]][3]*coef[out[2]][1] - coef[out[2]][3]*coef[out[1]][1]
		yimen[i] = coef[out[1]][2]*coef[out[2]][1] - coef[out[1]][1]*coef[out[2]][2] 	
	else
		xbroj[i] = max_range - math.random(2*max_range)
		ybroj[i] = -coef[out[i]][choice]*xbroj[i] + coef[out[i]][3]
		yimen[i] = coef[out[i]][3-choice] 
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
	if (i == 3 and sing == 0) then	
	    xim = -yimen[i]
		qq = lib.math.gcd(xbroj[i], xim)
		xbroj[i] = math.floor(xbroj[i]/qq)
		xim = math.floor(xim/qq)		
		if (xim < 0) then
			xbroj[i] = -xbroj[i]
			xim = -xim
		end	  
		qq = lib.math.gcd(ybroj[i], yimen[i])
		ybroj[i] = math.floor(ybroj[i]/qq)
		yimen[i] = math.floor(yimen[i]/qq)
		if (yimen[i] < 0) then
			ybroj[i] = -ybroj[i]
			yimen[i] = -yimen[i]
		end
		sol = "( "
  		if (xim == 1) then
			point[i] = "( " .. tostring(xbroj[i]) .. ", " 
			sol = sol .. lib.check_number(xbroj[i]) .. ", "
		else
			point[i] = "( "  .. "\(\frac{" .. tostring(xbroj[i]) .. "}{" .. tostring(xim) .. "}\)" .. ", " 	
			sol = sol .. lib.check_fraction_simple(xbroj[i],xim) .. ", "
        end			
		if (yimen[i] == 1) then
			point[i] = point[i] .. tostring(ybroj[i]) 
			sol = sol .. lib.check_number(ybroj[i]) 
		else
			point[i] = point[i] .. "\(\frac{" .. tostring(ybroj[i]) .. "}{" .. tostring(yimen[i]) .. "}\)"	
			sol = sol .. lib.check_fraction_simple(ybroj[i],yimen[i]) 			
		end		
		point[i] = 	point[i] .. ")"	
		sol = sol .. ")"
        for j = 1,rows do
	    	q[i-1][j] = answ[1]
		end		
	else
		qq = lib.math.gcd(ybroj[i], yimen[i])
		ybroj[i] = math.floor(ybroj[i]/qq)
		yimen[i] = math.floor(yimen[i]/qq)
		if (yimen[i] < 0) then
			ybroj[i] = -ybroj[i]
			yimen[i] = -yimen[i]
		end
  		if (choice == 1) then
			point[i] = "( " .. tostring(xbroj[i]) .. ", " 
			if (yimen[i] == 1) then
				point[i] = point[i] .. tostring(ybroj[i]) 
			else
				point[i] = point[i] .. "\(\frac{" .. tostring(ybroj[i]) .. "}{" .. tostring(yimen[i]) .. "}\)"				
			end		
			point[i] = 	point[i] .. ")"
		else
			point[i] = ", " .. tostring(xbroj[i]) .. ")" 
			if (yimen[i] == 1) then
				point[i] = tostring(ybroj[i]) .. point[i]  
			else
				point[i] = "\(\frac{" .. tostring(ybroj[i]) .. "}{" .. tostring(yimen[i]) .. "}\)" .. point[i] 				
			end		
			point[i] = 	"(" .. point[i] 
		end			
		for j = 1,rows do
			if( choice == 1) then
				tmp = (-coef[out[j]][1]*xbroj[i] + coef[out[j]][3])/coef[out[j]][2] 
				if (tmp == ybroj[i]/yimen[i]) then
					q[i-1][j] = answ[1]
				else
					q[i-1][j] = answ[2]
				end
			else
				tmp = (-coef[out[j]][2]*xbroj[i] + coef[out[j]][3])/coef[out[j]][1] 
				if (tmp == ybroj[i]/yimen[i]) then
					q[i-1][j] = answ[1]
				else
					q[i-1][j] = answ[2]
				end
			end
		end
    end		
end  

if (coef[out[2]][1] ~= 0) then
    comp = coef[out[1]][1]/coef[out[2]][1]
else
    comp = coef[out[1]][2]/coef[out[2]][2]
end	
if (coef[out[1]][1]*coef[out[2]][2] == coef[out[1]][2]*coef[out[2]][1]) then
    if (coef[out[1]][3]/coef[out[2]][3] == comp or coef[out[2]][3]/coef[out[1]][3] == comp) then
		ind = 2
    else
        ind = 3
    end
else
    ind = 1	
end

addition_table = function()

  style = {}
  style["text-align"] = "center"
  style["width"] = "90px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("(x,y) \ f", style)  
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
      