Koji deo figure je obojen? Zapisi razlomkom.

@repeat(4)@
@center@ @lib.select_objects(5+ITEM, 1, "table", "", style_table_current)@ \
== @lib.check_fraction_condition("is_ok = (numerator/denominator == 1/6)")@
@/repeat@