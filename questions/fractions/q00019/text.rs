Oboj deo figure napisan razlomkom

@repeat(3)@
@center@ \(\frac{@brojilac@}{@imenilac@}\)  
@center@ @lib.select_objects(6, 3, "table", "sum(result) == "..tostring(boja), style)@
@/repeat@




Poredaj razlomke od najmanjeg do najveceg

@indices[1]@ @indices[2]@ @indices[3]@
@array_enum[1]@ @array_denom[1]@
@array_enum[2]@ @array_denom[2]@
@array_enum[3]@ @array_denom[3]@
@array_enum[indices[1]]@ @array_denom[indices[1]]@
@array_enum[indices[2]]@ @array_denom[indices[2]]@
@array_enum[indices[3]]@ @array_denom[indices[3]]@

@center@ @lib.check_fraction_simple(array_enum[indices[1]], array_denom[indices[1]])@ < \
   @lib.check_fraction_simple(array_enum[indices[2]], array_denom[indices[2]])@ < \
   @lib.check_fraction_simple(array_enum[indices[3]], array_denom[indices[3]])@ 
