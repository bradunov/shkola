
@if ind == 1@
Za koliko je vsota števil @term1@ in @term2@ večja od broja @term3@?
@elif ind == 2@
Za koliko je vsota števil @term1@ in @term2@ manjša od broja @term3@?
@elif ind == 3@
Za koliko je razlika števil @term1@ in @term2@ manjša od broja @term3@?
@else@
Za koliko je razlika števil @term1@ in @term2@ večja od broja @term3@?
@endif@

S katero enačbo boš izračunal iskano število? Pobarvajte kroglico pri pravilnem odgovoru.
@vspace@
@center@ @lib.check_one_option_radio(answ,ind-1,true)@ 
@vspace@ 
@center@ Rešitev enačbe je  @hspacept(5)@   x = @lib.check_number(solution)@.