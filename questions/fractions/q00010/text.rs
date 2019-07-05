@h1@ Obojeni deo figure zapiši razlomkom: @/h1@

@lib.start_table({["text-align"] = "center"})@
@repeat(3)@
  @lib.start_row()@
    @lib.add_cell("", bojap)@
  @lib.end_row()@
@/repeat@
@lib.end_table()@

@center@ @lib.check_fraction_condition("is_ok = (numerator/denominator == 1/3)")@



@center@ @lib.select_objects(3, 2, "table", "", style_table)@

@center@ @lib.check_fraction_condition("is_ok = (numerator/denominator == 1/6)")@



@center@ @lib.select_objects(3, 2, "triangle", "", style_triangle)@

@center@ @lib.check_fraction_condition("is_ok = (numerator/denominator == 1/6)")@




@center@ @lib.select_objects(3, 2, "circle", "", style_circle)@

@center@ @lib.check_fraction_condition("is_ok = (numerator/denominator == 1/6)")@




@center@ @lib.select_objects(3, 2, "square", "", style_square)@

@center@ @lib.check_fraction_condition("is_ok = (numerator/denominator == 1/6)")@

