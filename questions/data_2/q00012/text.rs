
Na početku je cena proizvoda  bila @number@ @val@. 
Kolika je sada cena proizvoda ako je proizvod  prvo poskupeo za @per@@proc@, a zatim pojeftinio za @per@@proc@? 
@center@Cena proizvoda je  @hspacept(3)@  @lib.check_number(price1,50)@ @valnew1@. 
@vspace@
Da li bi cena bila ista da je proizvod prvo pojeftinio za @per@@proc@, a zatim poskupeo za @per@@proc@?   
@center@ @lib.check_one_option_dropdown(reply, reply[1])@ 
@center@ Cena proizvoda bila bi   @hspacept(3)@  @lib.check_number(price2,50)@ @valnew2@.          
                     