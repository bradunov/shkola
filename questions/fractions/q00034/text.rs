Koji deo figure je obojen? Zapisi razlomkom.

@repeat(4)@

@center@ @lib.select_objects(4, 2, "table", "", style_table_current)@ \
== @lib.check_fraction_condition("is_ok = (numerator/denominator == "..tostring(enum).."/"..tostring(denom)..")")@
@/repeat@
