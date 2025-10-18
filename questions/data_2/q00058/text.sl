
Dopolnite tabelo tako, da prikazuje uspeh @total@ učencev enega oddelka na testu iz matematike.
@center@ @mycanvas()@ 
@if ch == 1@
@center@ Izračunajte povprečno vrednost vzorca ocen (zaokroži na dve decimalke).
@elif ch == 2@
@center@ Določite mediano vzorca ocen.
@else@
@center@ Določite modus vzorca ocen.
@endif@ 
@center@  @lib.check_number(value, 40)@
            