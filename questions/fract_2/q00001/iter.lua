
ceo = math.random(3)
imenilac = math.random(9) + 1
brojilac = math.random(imenilac - 1)

veliki_brojilac = ceo * imenilac + brojilac
vrednost = ceo + brojilac / imenilac

condition = "is_ok = math.eq(whole + numerator/denominator, "..tostring(vrednost)..");"
solution = "numerator="..tostring(brojilac)..";denominator="..tostring(imenilac)..";whole="..tostring(ceo)..";"




