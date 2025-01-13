
@repeat(2)@  
@if ind == 1@
Koji broj treba  dodati broju @value[1]@ da se dobije broj koji je @value[3]@ puta veći od broja @value[4]@?
@elif ind == 2@
Koji broj treba  oduzeti od broja @value[1]@ da se dobije broj koji je @value[3]@ puta veći od broja @value[4]@?
@elif ind == 3@
Koji broj treba  dodati broju @value[1]@ da se dobije broj koji je @value[3]@ puta manji od broja @value[4]@?
@else@
Koji broj treba  oduzeti od broja @value[1]@ da se dobije broj koji je @value[3]@ puta manji od broja @value[4]@?
@endif@

@center@ @lib.check_number(numb[2],40)@
@vspace@
@/repeat@ 
