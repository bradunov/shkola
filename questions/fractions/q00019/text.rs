Oboj deo figure napisan razlomkom:

@repeat(3)@
@center@ \(\frac{@brojilac@}{@imenilac@}\) @hspace@ @hspace@ @lib.select_objects(6, 3,"table","sum(result) == "..tostring(boja), style, sln)@
@/repeat@

Poređaj razlomke od najmanjeg do najvećeg
@center@ \
   @lib.check_fraction_condition(is_ok[indices[1]], false, nil, solution[indices[1]])@ \(\leq\) \
   @lib.check_fraction_condition(is_ok[indices[2]], false, nil, solution[indices[2]])@ \(\leq\) \
   @lib.check_fraction_condition(is_ok[indices[3]], false, nil, solution[indices[3]])@
   
                  
                  