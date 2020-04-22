Koji deo figure je obojen? Zapiši razlomkom.

@repeat(4)@

@center@ @lib.select_objects(denom, 1, "table", "", style_table_current)@ \
@hspace@=@hspace@ @lib.check_fraction_condition(\
    "is_ok = (numerator/denominator == "..tostring(enum).."/"..tostring(denom)..")", false, {},\
    "numerator="..tostring(enum)..";denominator="..tostring(denom)..";")@
@/repeat@
                 