Ulomke 

@center@ \(\frac{@array_enum[1]@}{@array_denom[1]@}\),@hspace@ \(\frac{@array_enum[2]@}{@array_denom[2]@}\),@hspace@ \(\frac{@array_enum[3]@}{@array_denom[3]@}\),@hspace@ \(\frac{@array_enum[4]@}{@array_denom[4]@}\)

uredi od največjega do najmanjega:

@center@  @lib.check_fraction_condition(is_ok[indices[4]], false, {}, solution[indices[4]])@ \(\geq\) \
   @lib.check_fraction_condition(is_ok[indices[3]], false, {}, solution[indices[3]])@ \(\geq\) \
   @lib.check_fraction_condition(is_ok[indices[2]], false, {}, solution[indices[2]])@ \(\geq\) \
   @lib.check_fraction_condition(is_ok[indices[1]], false, {}, solution[indices[1]])@