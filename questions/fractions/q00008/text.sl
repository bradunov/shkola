Izpolni tabelo:

@lib.start_table()@
  @lib.start_row()@
    @lib.add_cell(str1)@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[1]).."}\)"..str2)@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[2]).."}\)"..str2)@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[3]).."}\)"..str2)@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[4]).."}\)"..str2)@
    @lib.add_cell("\(\frac{1}{"..tostring(denom[5]).."}\)"..str2)@
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