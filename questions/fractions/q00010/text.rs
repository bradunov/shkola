@h1@ 2. Obojeni deo figure zapisi razlomkom. @/h1@

@lib.start_table({["text-align"] = "center"})@
@repeat(3)@
  @lib.start_row()@
    @lib.add_cell("", bojap)@
  @lib.end_row()@
@/repeat@
@lib.end_table()@

@center@ @lib.check_fraction(1, 3)@


@lib.start_table({["text-align"] = "center"})@
@repeat(2)@
  @lib.start_row()@
    @lib.add_cell("", whiteg)@
    @lib.add_cell("", bojag)@
    @lib.add_cell("", whiteg)@
  @lib.end_row()@
@/repeat@
@lib.end_table()@

@center@ @lib.check_fraction(1, 6)@

