
@if ind == 1@
Koji broj treba  dodati broju @factor[2]@ da bi se dobio broj @value@?
@elif ind == 2@
Koji broj treba oduzeti od broja @factor[2]@ da bi se dobio broj @value@?
@elif ind == 3@
Kom broju treba dodati broj @factor[2]@ da bi se dobio broj @value@?
@else@
Od kog broja treba oduzeti broj @factor[2]@ da bi se dobio broj @value@?
@endif@
Kojom jednačinom ćeš izračunati traženi broj? Oboj kružić pored tačnog odgovora.
@center@ @lib.check_one_option_radio(reply,index-1,true)@ 
@vspace@
Reši jednačinu.
@center@   x = @lib.check_number(factor[1],40)@
            