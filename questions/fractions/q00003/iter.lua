ceo = math.random(3)
imenilac = math.random(9) + 1
brojilac = math.random(imenilac)

veliki_brojilac = ceo * imenilac + brojilac
vrednost = ceo + brojilac / imenilac

condition = "is_ok = (whole + numerator/denominator == "..tostring(vrednost)..");"
condition = "is_ok = (whole * denominator + numerator == "..tostring(veliki_brojilac)..");"



