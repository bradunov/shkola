@repeat(2)@
Na ladji je @total@ potnikov. Če se določeno število potnikov @text1[ITEM]@ v pristanišču, na ladji ostane @text2[ITEM]@ @number@ potnikov. Koliko potnikov se @text3[ITEM]@ v pristanišču? 
Postavi in reši enačbo.
@center@ @lib.check_number(total,30)@ @lib.check_string(sign,10)@ @lib.check_string("x",30)@ = @lib.check_number(number,30)@, @hspacept(20)@   x = @lib.check_number(solution,30)@
@vspace@      
@/repeat@