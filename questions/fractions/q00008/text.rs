Popuni tabelu: 

@lib.start_table()@
  @lib.start_row()@
    @lib.add_cell("broj a")@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[1]).."}\) od a")@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[2]).."}\) od a")@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[3]).."}\) od a")@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[4]).."}\) od a")@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[5]).."}\) od a")@
  @lib.end_row()@
  @repeat(5)@
  @lib.start_row()@
    @lib.add_cell(h)@
    @lib.add_cell(lib.check_number(v1))@
    @lib.add_cell(lib.check_number(v2))@
    @lib.add_cell(lib.check_number(v3))@
    @lib.add_cell(lib.check_number(v4))@
    @lib.add_cell(lib.check_number(v5))@
  @lib.end_row()@
  @/repeat@
@lib.end_table()@
