
@imem@ i @imez@ su podelili na dva jednaka dela ostatak kolača sa slike (obojeni deo). 

Koji deo od celog kolača je pojela @imez@? Zapiši razlomkom.
@vspace@
@center@ @lib.select_objects(imax, jmax, "table", "", style_table)@ 

@vspace@
@center@  @imez@ je pojela @lib.check_fraction_condition(\
  "is_ok = (numerator/denominator == "..tostring(broj).."/"..tostring(imen)..")", nil, nil, \
  "numerator="..tostring(broj)..";denominator="..tostring(imen)..";"\
)@ deo kolača.
            



            

