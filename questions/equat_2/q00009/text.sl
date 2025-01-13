
@repeat(2)@  
@if ind == 1@
Katero število je potrebno dodati številu @value[1]@ da se dobije broj koji je @value[3]@ puta večji od broja @value[4]@?
@elif ind == 2@
Katero število je potrebno  odšteti od števila @value[1]@ da se dobije broj koji je @value[3]@ puta večji od broja @value[4]@?
@elif ind == 3@
Katero število je potrebno  dodati številu @value[1]@ da se dobije broj koji je @value[3]@ puta manjši od broja @value[4]@?
@else@
Katero število je potrebno  odšteti od števila @value[1]@ da se dobije broj koji je @value[3]@ puta manjši od broja @value[4]@?
@endif@

@center@ @lib.check_number(numb[2],40)@
@vspace@
@/repeat@ 
