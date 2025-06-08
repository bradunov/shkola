
@imem@ in @imez@ sta razdelila na dva enaka dela preostanek torte s slike (obarvani del).
@vspace@
@center@ @lib.select_objects(imax, jmax, "table", "", style_table)@ 
@vspace@
Kateri del celotne torte je pojedla @imez@? Zapiši kot ulomek.
@center@  @imez@ je pojedla @lib.check_fraction_condition(\
  "is_ok = (numerator/denominator == "..tostring(broj).."/"..tostring(imen)..")", nil, nil, \
  "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"\
)@ del torte.