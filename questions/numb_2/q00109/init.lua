
include("terms")

term = {" "}
term[1] = "2 - 3b" 
term[2] = "3xy\(^{\small 4}\)" 
term[3] = "a\(^{\small 2}\)b + a + 4" 
term[4] = "1 - 3a\(^{\small 2}\)x"      
term[5] = "x\(^{\small 2}\) + y\(^{\small 2}\)"  
term[6] = "a\(^{\small 2}\) + 2ab + b\(^{\small 2}\)"     
term[7] = "x\(^{\small 2}\) - ay\(^{\small 2}\)"             
term[8] = "a\(^{\small 3}\) - 3a\(^{\small 2}\)b\(^{\small 2}\) + b\(^{\small 3}\)" 
term[9] = "3x\(^{\small 2}\) - x - 3x\(^{\small 2}\)"  
term[10] = "m - 3xa\(^{\small 3}\)"      
term[11] = "a\(^{\small 3}\)y\(^{\small 4}\) - a\(^{\small 4}\)y\(^{\small 3}\)"            
term[12] = "x\(^{\small 3}\)a\(^{\small 2}\) - 3a\(^{\small 2}\)x\(^{\small 2}\)"              
term[13] = "4xy\(^{\small 2}\) - b\(^{\small 6}\)"             
term[14] = "axy\(^{\small 5}\)"            
term[15] = "mabxy  - n"            
term[16] = "x\(^{\small 3}\)y\(^{\small 2}\)+x\(^{\small 2}\)y\(^{\small 4}\)"             
term[17] = "ax\(^{\small 4}\)y\(^{\small 4}\)"
term[18] = "ax - y + 2" 
term[19] = "a\(^{\small 2}\)b\(^{\small 2}\) + 4mxy\(^{\small 3}\)" 
term[20] = "a+x\(^{\small 6}\)y\(^{\small 6}\)"                	 
term[21] = "xy\(^{\small 3}\) + 4x\(^{\small 3}\)y\(^{\small 7}\)"
term[22] = "-k\(^{\small 4}\)n\(^{\small 4}\)"
term[23] = "a\(^{\small 9}\)b\(^{\small 3}\) + mx\(^{\small 3}\)y\(^{\small 3}\)"
term[24] = "- k\(^{\small 2}\)m\(^{\small 3}\)n\(^{\small 4}\)p\(^{\small 5}\)"
term[25] = "p\(^{\small 3}\) - p + 6"
term[26] = "a\(^{\small 9}\)y\(^{\small 4}\) - 1"
term[27] = "x\(^{\small 3}\)y\(^{\small 3}\)z(^{\small 3}\) - 3"

degr = {1, 5, 3, 4, 2, 2, 3, 4, 1, 4, 7, 5, 6, 7, 5, 6, 9, 2, 5, 12, 10, 8, 12, 14, 3, 13, 9}

index = {}
ind = {}
qq = {}
choice = {""}
value = {""}
out = {}
ch = {}
idx = {}
mix = {}
quest = {""}
result = {}

dim = 27
stampa = 5

for i = 1,dim do
    index[i] = i
end 
ind = lib.math.random_shuffle(index)
for i = 1,2*stampa do
    qq[i] = degr[ind[i]]
	choice[i] = term[ind[i]]
end	
ch = lib.math.argsort(qq)
nr = 1
out[1] = qq[ch[1]]
value[1] = choice[ch[1]]  
for i = 2,2*stampa do
    if (nr < stampa) then
		if (qq[ch[i]] > qq[ch[i-1]]) then
			nr = nr + 1
			out[nr] = qq[ch[i]]
			value[nr] = choice[ch[i]]
		end	
    end		
end	

form = math.random(2)
request = task[form] 

for i = 1,stampa do
    if (form == 1) then
        idx[i] = i
	else 
        idx[i] = stampa + 1 - i
    end		
end 
mix = lib.math.random_shuffle(idx)

for i=1,stampa do
    quest[i] = value[mix[i]]
    result[i] = idx[mix[i]]
end
              
         