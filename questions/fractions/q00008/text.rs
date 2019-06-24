@h2@ 17. Popuni tabelu: @/h2@

@lib.start_table(6)@
  @lib.start_row()@
    @lib.add_cell("Broj a")@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[1]).."}\) od a")@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[2]).."}\) od a")@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[3]).."}\) od a")@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[4]).."}\) od a")@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[5]).."}\) od a")@
  @lib.end_row()@
  @repeat(5)@
  @lib.start_row()@
    @lib.add_cell(h)@
    @lib.add_cell(lib.check_value(v1))@
    @lib.add_cell(lib.check_value(v2))@
    @lib.add_cell(lib.check_value(v3))@
    @lib.add_cell(lib.check_value(v4))@
    @lib.add_cell(lib.check_value(v5))@
  @lib.end_row()@
  @/repeat@
@lib.end_table()@
