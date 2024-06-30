
@repeat(2)@
V silosu je @total@@"kg"@ pšenice. Koliko kilogramov pšenice lahko @quest[ITEM]@ @text@ kot @number@@"t"@ pšenice?                   
Postavi neenačbo in jo reši.            
            
@center@ @lib.check_number(total,60)@ @lib.check_string(sign,15)@ @lib.check_string("x",15)@ @lib.check_one_option_dropdown(answ,compneq)@ @lib.check_number(numberkg,60)@@"kg"@, 
@center@   x @lib.check_one_option_dropdown(answ,comp)@ @lib.check_number(solution,60)@@"kg"@
@vspace@      
@/repeat@   
