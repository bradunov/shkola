@h1@ Dopuni  @/h1@


@lib.start_table({["text-align"] = "center"})@
  @lib.start_row()@
    @lib.add_cell("", pink)@
    @lib.add_cell("", white)@
  @lib.end_row()@
  @lib.start_row()@
    @lib.add_cell("", white)@
    @lib.add_cell("", white)@
  @lib.end_row()@
@lib.end_table()@


Obojena je @lib.check_number(1)@ četvrtina.

Zapisujemo razlomkom @lib.check_fraction_simple(1, 4)@



@lib.start_table({["text-align"] = "center"})@
  @lib.start_row()@
    @lib.add_cell("", green)@
    @lib.add_cell("", green)@
  @lib.end_row()@
  @lib.start_row()@
    @lib.add_cell("", white)@
    @lib.add_cell("", white)@
  @lib.end_row()@
@lib.end_table()@


Obojene su @lib.check_number('is_ok = (answer == 2)')@ četvrtine.

Zapisujemo razlomkom @lib.check_fraction_condition("is_ok = (numerator/denominator == 0.5)")@


