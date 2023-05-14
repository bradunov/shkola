@imem@ in @imez@ sta razdelila na dva enaka dela preostanek torte s slike (obarvani del).

Kateri del celotne torte je pojedel @imez@? Zapiši razlomkom.
@vspace@
@center@ @lib.select_objects(imax, jmax, "table", "", style_table)@ 

@vspace@
@center@  @imez@ je pojedel @lib.check_fraction_condition(\
  "is_ok = (numerator/denominator == "..tostring(broj).."/"..tostring(imen)..")", nil, nil, \
  "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"\
)@ del torte.