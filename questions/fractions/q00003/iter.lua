ceo = math.random(3)
imenilac = math.random(9) + 1
brojilac = math.random(imenilac)

veliki_brojilac = ceo * imenilac + brojilac
vrednost = ceo + brojilac / imenilac

--[[ We use OR here as the frist one works well for whole numbers (e.g. 16/8) and the second one for infinite digit numbers (e.g. 10/3) ]]--
condition = "is_ok = (whole + numerator/denominator == "..tostring(vrednost).." || whole * denominator + numerator == "..tostring(veliki_brojilac)..");"



