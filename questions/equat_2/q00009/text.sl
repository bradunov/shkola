
@repeat(2)@  
@if ind == 1@
Katero število je treba dodati številu @value[1]@, da dobimo število, ki je @value[3]@-krat večje od @value[4]@?
@elif ind == 2@
Katero število je treba odšteti od števila @value[1]@, da dobimo število, ki je @value[3]@-krat večje od @value[4]@?
@elif ind == 3@
Katero število je treba dodati številu @value[1]@, da dobimo število, ki je @value[3]@-krat manjše od @value[4]@?
@else@
Katero število je treba odšteti od števila @value[1]@, da dobimo število, ki je @value[3]@-krat manjše od @value[4]@?
@endif@
@center@ @lib.check_number(numb[2],40)@
@vspace@
@/repeat@ 
