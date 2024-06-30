
Dopolni:

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

@center@ Obarvana je @lib.check_number(1)@ četrtina.
@center@ Zapišemo z ulomkom @lib.check_fraction_simple(1, 4)@

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

@center@ Obarvane so @lib.check_number('answer == 2', nil, 'answer = 2')@ četrtine.
@center@ Zapišemo z ulomkom @lib.check_fraction_condition("is_ok = (numerator/denominator == 0.5)", nil, nil, "numerator=2;denominator=4;")@