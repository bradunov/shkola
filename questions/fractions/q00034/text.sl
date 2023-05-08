Kateri del slike je pobarvan? Zapiši kot ulomek.

@repeat(4)@

@center@ @lib.select_objects(4, 2, "table", "", style_table_current)@ \
@hspace@=@hspace@ \
@lib.check_fraction_condition(\
  "is_ok = (numerator/denominator == "..tostring(enum).."/"..tostring(denom)..")", nil, nil, \
  "numerator="..tostring(enum)..";denominator="..tostring(denom)..";"\
)@
@/repeat@