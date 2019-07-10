Oboj deo figure napisan razlomkom

@repeat(3)@
@center@ \(\frac{@brojilac@}{@imenilac@}\)  
@center@ @lib.select_objects(6, 3, "table", "sum(result) == "..tostring(boja), style)@
@/repeat@




Poredaj razlomke od najmanjeg do najveceg

@center@ @lib.check_fraction_simple(array_enum[0], array_denom[0])@ < \
   @lib.check_fraction_simple(array_enum[1], array_denom[1])@ < \
   @lib.check_fraction_simple(array_enum[2], array_denom[2])@ 
