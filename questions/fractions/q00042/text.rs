Razlomke 

@center@ 
\(\frac{@array_enum[1]@}{@array_denom[1]@}\),@hspace@ \(\frac{@array_enum[2]@}{@array_denom[2]@}\),@hspace@ \(\frac{@array_enum[3]@}{@array_denom[3]@}\),@hspace@ \(\frac{@array_enum[4]@}{@array_denom[4]@}\)

poređaj od najvećeg do najmanjeg:

@center@ 
@lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(array_value[indices[4]])..");", false)@ \(\geq\) \
   @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(array_value[indices[3]])..");", false)@ \(\geq\) \
   @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(array_value[indices[2]])..");", false)@ \(\geq\) \
   @lib.check_fraction_condition("is_ok = math.eq(numerator/denominator, "..tostring(array_value[indices[1]])..");", false)@                  
                  
  
                  
                  