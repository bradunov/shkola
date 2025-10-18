
Dopuni tabelu tako da ona prikazuje uspeh @total@ učenika jednog odeljenja na testu iz matematike.
@center@ @mycanvas()@ 
@if ch == 1@
@center@ Izračunaj srednju vrednost uzorka ocena (zaokrugli na dve decimale).
@elif ch == 2@
@center@ Odredi medijanu uzorka ocena.
@else@
@center@ Odredi mod uzorka ocena.
@endif@ 
@center@  @lib.check_number(value, 40)@
            

