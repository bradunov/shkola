
include("names")
include("terms")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 
padez = musko_ime_dativ[r]

small = {2, 2, 3, 3, 4, 4, 5, 5, 5 ,5}
big  =  {7, 9, 7, 8, 7, 9, 6, 7, 8, 9}
dim = 10

fctb = {0}
fcts = {0}
op = {""}
text = {""}
quest = {""}

space = "\( \ \ \ \ \)"
option = {"<--", "-->", "-/-"}
draw = {"\(\bigg[ \)", "\(\bigg] \)", "\(\big[ \)", "\(\big] \)"}

total = 1 + math.random(8) 
ch = math.random(dim)

if (total < 5) then
	meas = msg[1]
else	    
	meas = msg[2]
end

ind = 1

tmp = math.floor(math.abs(big[ch] - total)/ small[ch])
if (math.abs(big[ch] - total) == small[ch] * tmp) then
    if (big[ch] - total >= 0) then
		ind = 1		
		fctb[1] = 1
		fcts[1] = tmp		
		if (tmp == 0) then
			op[1] = option[3]	
        else		
			op[1] = option[2]
		end
	else
		ind = 2	
		fctb[1] = 1
		fcts[1] = 0	
		op[1] = option[3]		
		fctb[2] = 0
		fcts[2] = tmp		
		sum = big[ch]
		op[2] = option[3]		
	end
end

tmp = math.floor(total/ small[ch])
if (total == small[ch] * tmp) then
 	ind = 1
	fctb[1] = 0
	fcts[1] = tmp		
	op[1] = option[3]	
end

if (ch == 3) then
    if (total == 2) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 3	
		op[1] = option[1]	
	end
    if (total == 5) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum = big[ch] - small[ch]		
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[2]				
	end	
    if (total == 8) then
		ind = 2		
		fctb[1] = 1
		fcts[1] = 0	
		op[1] = option[3]	
        sum = big[ch] 		
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[1]			
	end		
end
if (ch == 4) then
    if (total == 4) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[2]	
        sum = big[ch] - 2*small[ch]		
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[2]				
	end	
    if (total == 7) then
		ind = 2		
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum = big[ch] - small[ch] 		
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[2]			
	end		
end

if (ch == 5) then
    if (total == 2) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]	
        sum = 2*small[ch] - big[ch] 	
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[2]				
	end	
    if (total == 5) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = option[3]	
        sum = small[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]			
	end		
    if (total == 6) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1
		op[1] = option[2]	
        sum = big[ch] - small[ch]		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]			
	end		
    if (total == 9) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 2
		op[1] = option[3]	
        sum = 2 * small[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]			
	end				
end

if (ch == 6) then
    if (total == 2) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[2]	
        sum = big[ch] - 2*small[ch]	
		fctb[2] = 1
		fcts[2] = 2
		op[2] = option[2]				
	end	
    if (total == 3) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 3	
		op[1] = option[1]					
	end		
    if (total == 6) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 3
		op[1] = option[1]	
        sum = 3 * small[ch] - big[ch]		
		fctb[2] = 1
		fcts[2] = 3	
		op[2] = option[1]			
	end		
    if (total == 7) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = option[3]	
        sum = small[ch]		
		fctb[2] = 1
		fcts[2] = 3	
		op[2] = option[1]			
	end				
end

if (ch == 7) then
    if (total == 2) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum = big[ch] - small[ch]	
		fctb[2] = 1
		fcts[2] = 1
		op[2] = option[2]				
	end	
    if (total == 3) then
		ind = 3	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum = big[ch] - small[ch]	
		fctb[2] = 1
		fcts[2] = 1
		op[2] = option[2]	
        sum2 = sum + big[ch] - small[ch]		
	end	
    if (total == 4) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]					
	end			
    if (total == 7) then
		ind = 3	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = option[3]	
        sum = small[ch] 		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]	
        sum2 = sum + big[ch] - small[ch]		
	end		
    if (total == 8) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2
		op[1] = option[1]	
        sum = 2 * small[ch] - big[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]			
	end	
    if (total == 9) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = option[3]	
        sum = small[ch] 		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]			
	end		
end
if (ch == 8) then
    if (total == 2) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]			
	end	
    if (total == 3) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]				
	end	
    if (total == 4) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]
        sum = big[ch] - small[ch] 
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]		
	end			
    if (total == 6) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]		
        sum = 2 * small[ch] - big[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[2]			
	end		
    if (total == 8) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = option[3]	
        sum = small[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]			
	end	
    if (total == 9) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 0
		op[1] = option[3]	
        sum = big[ch] 		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]			
	end		
end
if (ch == 9) then
    if (total == 2) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]			
	end	
    if (total == 3) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]				
	end	
    if (total == 4) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]
        sum = 2 * small[ch] - big[ch]
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]		
	end			
    if (total == 6) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]		
        sum = big[ch] - small[ch] 		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]			
	end		
    if (total == 7) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = option[3]	
        sum = small[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]			
	end	
    if (total == 9) then
		ind = 3	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum = big[ch] - small[ch] 		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]	
        sum2 = sum + big[ch] - small[ch]		
	end		
end
if (ch == 10) then
    if (total == 2) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]	
        sum = 2 * small[ch] - big[ch]
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]			
	end	
    if (total == 3) then
		ind = 3	
		fctb[1] = 1
		fcts[1] = 2	
		op[1] = option[1]	
        sum = 2 * small[ch] - big[ch]
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]	
        sum2 = sum + 2 * small[ch] - big[ch]		
	end	
    if (total == 4) then
		ind = 1	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]
	end			
    if (total == 6) then
		ind = 2	
		fctb[1] = 0
		fcts[1] = 1	
		op[1] = option[3]		
        sum = small[ch] 		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]			
	end		
    if (total == 7) then
		ind = 3	
		fctb[1] = 0
		fcts[1] = 1
		op[1] = option[3]	
        sum = small[ch]		
		fctb[2] = 1
		fcts[2] = 2	
		op[2] = option[1]	
        sum2 = sum + 2 * small[ch] - big[ch]		
	end	
    if (total == 8) then
		ind = 2	
		fctb[1] = 1
		fcts[1] = 1	
		op[1] = option[2]	
        sum = big[ch] - small[ch] 		
		fctb[2] = 1
		fcts[2] = 1	
		op[2] = option[2]			
	end		
end

if (ind == 1) then
	quest[1] = lib.check_number(fctb[1],10) .. " " .. draw[1] .. " " .. lib.check_number(big[ch],20) .. " " .. draw[2] 
	quest[1] = quest[1] .. space .. lib.check_one_option_dropdown(option, op[1]).. space 
	quest[1] = quest[1] .. lib.check_number(fcts[1],10) .. " " .. draw[3] .. " " .. lib.check_number(small[ch],20) .. " " .. draw[4]  
	quest[1] = quest[1] .. " = " .. space .. lib.check_number(total,20)
	quest[2] = ""
	quest[3] = ""
else
	quest[1] = lib.check_number(fctb[1],10) .. " " .. draw[1] .. " " .. lib.check_number(big[ch],20) .. " " .. draw[2] 
	quest[1] = quest[1] .. space .. lib.check_one_option_dropdown(option, op[1]).. space 
	quest[1] = quest[1] .. lib.check_number(fcts[1],10) .. " " .. draw[3] .. " " .. lib.check_number(small[ch],20) .. " " .. draw[4]  
	quest[1] = quest[1] .. " = " .. space .. lib.check_number(sum,20)	
	quest[2] = lib.check_number(fctb[2],10) .. " " .. draw[1] .. " " .. lib.check_number(big[ch],20) .. " " .. draw[2] 
	quest[2] = quest[2] .. space .. lib.check_one_option_dropdown(option, op[2]).. space 
	quest[2] = quest[2] .. lib.check_number(fcts[2],10) .. " " .. draw[3] .. " " .. lib.check_number(small[ch],20) .. " " .. draw[4]  	
	text[1] = comment[1]
	text[2] = comment[2]	
    if (ind == 3) then
		quest[2] = quest[2] .. " = " .. space .. lib.check_number(sum2,20)		
		quest[3] = lib.check_number(fctb[2],10) .. " " .. draw[1] .. " " .. lib.check_number(big[ch],20) .. " " .. draw[2] 
		quest[3] = quest[3] .. space .. lib.check_one_option_dropdown(option, op[2]).. space 
		quest[3] = quest[3] .. lib.check_number(fcts[2],10) .. " " .. draw[3] .. " " .. lib.check_number(small[ch],20) .. " " .. draw[4]  
		quest[3] = quest[3] .. " = " .. space .. lib.check_number(total,20)	 
		text[3] = comment[3]  
    else
		quest[2] = quest[2] .. " = " .. space .. lib.check_number(total,20)		
		quest[3] = ""	
		text[3] = ""
    end
end       
            