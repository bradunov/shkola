
@imem@ i @imez@ su podelili na dva jednaka dela ostatak kolača sa slike (obojeni deo). 
@vspace@
@center@ @lib.select_objects(imax, jmax, "table", "", style_table)@ 
@vspace@
Koji deo od celog kolača je pojela @imez@? Zapiši razlomkom.
@center@  @imez@ je pojela @lib.check_fraction_condition(\
  "is_ok = (numerator/denominator == "..tostring(broj).."/"..tostring(imen)..")", nil, nil, \
  "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"\
)@ deo kolača.
