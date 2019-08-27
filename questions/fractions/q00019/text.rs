Oboj deo figure napisan razlomkom:

@repeat(3)@
@center@ \(\frac{@brojilac@}{@imenilac@}\) @hspace@ @hspace@ @lib.select_objects(6, 3,"table","sum(result) == "..tostring(boja), style)@
@/repeat@

Poređaj razlomke od najmanjeg do najvećeg
@center@ @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(array_value[indices[1]])..");", false)@ \(\leq\) \
   @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(array_value[indices[2]])..");", false)@ \(\leq\) \
   @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(array_value[indices[3]])..");", false)@
   
                  
                  