
@if ind == 1@
Za koliko je zbir brojeva @term1@ i @term2@ veći od broja @term3@?
@elif ind == 2@
Za koliko je zbir brojeva @term1@ i @term2@ manji od broja @term3@?
@elif ind == 3@
Za koliko je razlika brojeva @term1@ i @term2@ manja od broja @term3@?
@else@
Za koliko je razlika brojeva @term1@ i @term2@ veća od broja @term3@?
@endif@

Kojom jednačinom ćeš izračunati traženi broj? Oboj kružić pored tačnog odgovora.
@vspace@
@center@ @lib.check_one_option_radio(answ,ind-1,true)@ 
@vspace@ 
@center@ Rešenje jednačine je  @hspacept(5)@   x = @lib.check_number(solution)@.
 