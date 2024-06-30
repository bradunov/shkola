
@repeat(2)@
Na brodu  je  @total@ putnika. Ako se određeni broj putnika @text1[ITEM]@ u luci,  na brodu @text2[ITEM]@ @number@ putnika. Koliko putnika se @text3[ITEM]@ u luci?
Postavi i reši jednačinu.
@center@ @lib.check_number(total,30)@ @lib.check_string(sign,10)@ @lib.check_string("x",30)@ = @lib.check_number(number,30)@, @hspacept(20)@   x = @lib.check_number(solution,30)@
@vspace@      
@/repeat@
