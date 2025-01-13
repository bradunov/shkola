                                                                                                                                                                                                                                                                               
@if ind == 1@
Od kog broja treba oduzeti broj @term@ da bi se dobio broj @value@?
@elif ind == 2@
Kom broju treba dodati broj @term@ da bi se dobio broj @value@?
@elif ind == 3@
Koji broj treba oduzeti od broja @term@ da bi se dobio broj @value@?
@else@
Koji broj treba dodati broju @term@ da bi se dobio broj @value@?
@endif@

Kojom jednačinom ćeš izračunati traženi broj? Oboj kružić pored tačnog odgovora.
@vspace@
@center@ @lib.check_one_option_radio(answ,ind-1,true)@ 
@vspace@
Reši jednačinu.
@center@   x = @lib.check_number(solution,40)@

     