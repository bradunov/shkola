
include("terms")

term = {" "}
term[1] = "2 - 3b" 
term[2] = "3xy" 
term[3] = "a²b + a + 4" 
term[4] = "2 - 3x²"      
term[5] = "x² + y²"  
term[6] = "a² + 2ab + b²"     
term[7] = "x² - ay²"             
term[8] = "a³ - 3a²b² + b³" 
term[9] = "3x² - x + 9x²"  
term[10] = "x - 3xa³"      
term[11] = "a³ - 2"            
term[12] = "x³ + a² - 3a²x²"              
term[13] = "3xy²"             
term[14] = "axy⁵"            
term[15] = "xy + 3y² - 8"            
term[16] = "x³y²+x²y³"             
term[17] = "x³y²"
term[18] = "xa - y + 2" 
term[19] = "a²b²m + 4xy³" 
term[20] = "3+x²- y"                	 
term[21] = "-xy³ + 4x³y + 5xy³"
term[22] = "-k² + 0,2k²"
term[23] = "a² - ab + ab² + ab"
term[24] = "- k²m³n⁴p⁵"
term[25] = "p³ - 2 - 2p - 3p³ - p + 6"
term[26] = "ay³ - 3a² + 4ay² + 4 + 3a² - ay³"
term[27] = "2x³ - 2xy² + x - xy² - y² + 3xy² - x - 2x³"

solut = {2, 1, 3, 2, 2, 3, 2, 3, 2, 2, 2, 3, 1, 1, 3, 2, 1, 3, 2, 3, 2, 1, 2, 1, 3, 2, 1}
degr = {1, 2, 3, 2, 2, 2, 3, 4, 2, 4, 3, 4, 3, 7, 2, 5, 5, 2, 5, 2, 4, 2, 3, 14, 3, 3, 2}

dim = 27
stampa = 4

index = {}
ind = {}
qq = {}

quest = {""}
answ = {""}

for i = 1,dim do
    index[i] = i
end	
ind = lib.math.random_shuffle(index)

for i = 1,stampa do
   	quest[i] = term[ind[i]]	
	qq[i] = degr[ind[i]] 
	tmp = solut[ind[i]]
	answ[i] = name[tmp]	  
end  
    