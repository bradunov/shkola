
include("terms")

term = {" "}
term[1] = "2 - 3b" 
term[2] = "3xy⁴" 
term[3] = "a²b + a + 4" 
term[4] = "1 - 3a²x"      
term[5] = "x² + y²"  
term[6] = "a² + 2ab + b²"     
term[7] = "x² - ay²"             
term[8] = "a³ - 3a²b² + b³" 
term[9] = "3x² - x - 3x²"  
term[10] = "m - 3xa³"      
term[11] = "a³y⁴ - a⁴y³"            
term[12] = "x³a² - 3a²x²"              
term[13] = "4xy² - b⁶"             
term[14] = "axy⁵"            
term[15] = "mabxy - n"            
term[16] = "x³y²+x²y⁴"             
term[17] = "ax⁴y⁴"
term[18] = "ax - y + 2" 
term[19] = "a²b² + 4mxy³" 
term[20] = "a+x⁶y⁶"                	 
term[21] = "xy³ + 4x³y⁷"
term[22] = "-k⁴n⁴"
term[23] = "a⁹b³ + mx³y³"
term[24] = "- k²m³n⁴p⁵"
term[25] = "p³ - p + 6"
term[26] = "a⁹y4 - 1"
term[27] = "x³y³z³ - 3"
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
              
         