
Na začetku je bila cena izdelka @number@ @val@. 
Kolika je sedaj cena izdelka, če se je cena izdelka najprej povišala za @per@@proc@, nato pa se je cena znižala za @per@@proc@? 
@center@ Cena izdelka je @hspacept(3)@ @lib.check_number(price1,50)@ @valnew1@. 
@vspace@
Ali bi bila cena ista, če bi izdelek najprej pocenili za @per@@proc@, nato pa ga podražili za @per@@proc@? 
@center@ @lib.check_one_option_dropdown(reply, reply[1])@ 
@center@ Cena izdelka bi bila @hspacept(3)@ @lib.check_number(price2,50)@ @valnew2@.