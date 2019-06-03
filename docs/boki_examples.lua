#
# Pitanja:
#
# 1) Kako uneti i proveriti tekstualne vrednosti
# 2) Meri koliko vremena radi zadatak
# 3) Koliko puta je pogresio zadatak
#
# - Ako je zadatak randomized, mozemo ga prikazati vise puta.
#   Ako nije, prikazujemo ga samo jednom
#
# - lib.text() je python format style print
#   na primer lib.text("A B {} D", "C") stampa "A B C D"
#   argument moze biti bilo koji objekat za renderovanje, a ne samo string
#
# - add assert to test question correctness
#
# - Kako iskazujemo post-conditions? Jedan nacin je preko check_condition, check_fraction
#   ali to nije dovoljno generalno. Mozda bolje eksplicitno napisati kod za post conditions
#   Takodje, u slucaju greske treba osvetliti/markirati polje koje je pogresno uneseno
#   posto moze da ih ima vise
#


lib.text("Zadatak 1:")


brojilac = 1
for imenilac=1,7 do
  lib.show_fractions_square(1, imenilac, brojilac, imenilac)
  lib.check_fractions(brojilac, imenilac, 0)
  lib.input_text(???)
end





lib.text("Zadatak 2:")
brojilac = 1
for imenilac=1,7 do
  x = math.random(3)
  y = math.random(6)
  imenilac = x * y
  fraction_type = "rectangle"						# fraction_type = "rectangle" znaci pravougaono iscrtavanje dimenzija x, y 
  lib.show_fractions(fraction_type, brojilac, imenilac, x, y)   	# x i y su dimenzije fraction square 
  lib.check_fractions(brojilac, imenilac, 0)
end





lib.text("Zadatak 3:")
for q=1,8 do
  x = math.random(3)
  y = math.random(6)
  imenilac = x * y

  # Jednostavni razlomak
  brojilac = math.random(imenilac)
  fraction_type = lib.fraction_random_type()				# Slucajno izabrana vizuelizacija 
  lib.show_fractions(fraction_type, brojilac, imenilac, x, y)   	# x i y su dimenzije fraction square

  # Alternativa za kontrolisanje koji delovi su iscrtani
  range = math.random(6)
  array = {}
  brojilac = 0
  for i=1,imenilac do
    if math.random(7) >= range then
      array[i] = 1
    else
      array[i] = 0
  end
  lib.show_fractions(fraction_type, array, x, y)   	# x i y su dimenzije fraction square

  lib.check_fractions(brojilac, imenilac, 0)
end





lib.text("Zadatak 4, 5 i 6:")
for q=1,4 do
  gcd = math.random(3) + 2
  jimenilac = math.random(9) + 1
  jbrojilac = math.random(imenilac)
  imenilac = jimenilac * gcd
  brojilac = jbrojilac * gcd
  lib.text("Oboj \(\frac{{}}{{}}\) je ", brojilac, imenilac)
  array = lib.select_fraction("rectangle", imenilac)
  lib.check_condition(sum(array) == jbrojilac)  
end






lib.text("Zadatak 7 i 8:")
table = lib.table()
row1 = table.add_row()
row1.add_cell("1")
row2 = table.add_row()
row2.add_cell("\(\frac{1}{2}\)", "color=blue")
row2.add_cell("\(\frac{1}{2}\)")
row3 = table.add_row()
row3.add_cell("\(\frac{1}{4}\)", "color=yellow")
row3.add_cell("\(\frac{1}{4}\)")
row3.add_cell("\(\frac{1}{4}\)")
row3.add_cell("\(\frac{1}{4}\)")
row4 = table.add_row()
row4.add_cell("\(\frac{1}{8}\)", "color=pink")
row4.add_cell("\(\frac{1}{8}\)")
row4.add_cell("\(\frac{1}{8}\)")
row4.add_cell("\(\frac{1}{8}\)")
row4.add_cell("\(\frac{1}{8}\)")
row4.add_cell("\(\frac{1}{8}\)")
row4.add_cell("\(\frac{1}{8}\)")
row4.add_cell("\(\frac{1}{8}\)")

lib.check_number("Jedno celo ima %d polovina", 2)
lib.check_number("Jedno celo ima %d cetvrtine", 4)
lib.check_number("Jedno celo ima %d osimna", 8)

lib.chech_option("Koji je deo veci, \(\frac{1}{2}\) ili \(\frac{1}{4}\)?", {"\(\frac{1}{2}\)", "\(\frac{1}{4}\)"})
lib.chech_option("Koji je deo veci, \(\frac{1}{4}\) ili \(\frac{1}{8}\)?", {"\(\frac{1}{4}\)", "\(\frac{1}{8}\)"})





lib.text("Zadatak 9")

lib.text("Izracunaj \(\frac{1}{2}\) od 200")
lib.check_number("", 100)





lib.text("Zadatak 10")


lib.text("10 je {} od 20", lib.check_fraction(1, 2))



lib.text("Zadatak 11-16: lako")




lib.text("Zadatak 17: Popuni tabelu")
table = lib.table()
head = table.add_row()
head.add_cell("Broj a")
a = {5, 2, 10, 4, 8}
for i=1,len(a)
  head.add_cell("\(\frac{1}{" .. tostring(a[i]) .. "}\) od a")
end
  






lib.text("Zadatak 18")
# Ovo mora da se uskladi sa razlomcima dole
total = (math.random(20) + 20) * 10
diff = (math.random(3) + 2) * 10
if math.random() > 0.5 then
  comp = " manje "
else
  comp = " vise "
end
lib.text("Milan ima {} dinara a Jovan {} {} od njega. Milan je potrosio \(\frac{1}{8}\) svog novca a Jovan \(\frac{1}{7}\)", total, diff, comp)

lib.text("{} je potrosio za {} dinara vise od {}",
  lib.check_text("Milan"),
  lib.check_number(30),			# Verovatno netacan broj
  lib.check_text("Jovana")
)




##### Citanje i pisanje razlomaka


lib.text("Zadatak 1")


lib.text("Pravougaonik je podeljen na {} jednaka dela", lib.check_number(4))

table = lib.table()
row1 = table.add_row()
row1.add_cell("\(\frac{1}{4}\)", "color=red")
row1.add_cell("")
row2 = table.add_row()
row2.add_cell("")
row2.add_cell("")

lib.text("Obojena je {} cetvrtina", lib.check_number(1))

lib.text("Zapisujemo razlomkom: ")
lib.check_fraction(1, 4)

t2 = lib.table()
r1 = t2.add_row()
r1.add_cell("U razlomku \(\frac{1}{4}\):", "span=2,vertical")
c2 = r1.add_cell("broj 1 je")
c2.add_element(lib.check_text("brojilac"))
r1 = t2.add_row()
c3.add_element(lib.check_text("imenilac"))






lib.text("Zadatak 2")
imenilac = math.random(10)
brojilac = 0
table = lib.table()
row = table.add_row()
for i=1,imenilac do
  if math.random() > 0.5 then
    brojilac = brojilac + 1
    row.add_cell("", "color=blue")
  else
    row.add_cell("")
  end
end

lib.check_fraction(brojilac, imenilac)




lib.text("Zadatak 3")
imanilac = math.random(10)
brojilac = math.random(brojilac)
array = lib.select_fraction("rectangle", imenilac)
lib.check_condition(sum(array) == brojilac)  






lib.text("Zadatak 4-6: slicni kao prethodi")





lib.text("Zadatak 7: previse komplikovan render ali ne i nemoguc")




lib.text("Zadatak 8: slican kao prethodni")





lib.text("Zadatak 9: komplikovano crtanje")
# Mozda ovde mozemo da (jednog dana :) napravimo genericki applet za crtanje i koristimo njega za ovaj zadatak




lib.text("Zadatak 10-18: slicni kao prethodni")







##### Uporedjivanje razlomaka



lib.text("Zadatak 1")

lib.text("Izaberi jednu polovinu u svakom redu")

table=lib.table()
array = {2, 4, 6, 8, 10}
for i=1,length(array) do
  imenilac = array[i]
  row = table.add_row()
  c1 = table.add_cell()
  (obj, res_array) = lib.select_fraction("rectangle", imenilac)
  c1.add_element(obj)
  lib.check_condition(sum(res_array) == imenilac / 2)  
  cell = row.add_cell()
  cell.add_element(lib.check_fraction(imenilac / 2, imenilac))
end



lib.text("Zadatak 2 slican kao zadatak 1")



lib.text("Zadatak 3")


f1 = lib.show_fractions("rectangle", {1,0}, 1, 2)		# x i y su dimenzije fraction square 
f2 = lib.show_fractions("rectangle", {1,1,0,0}, 1, 4)   	
f3 = lib.show_fractions("rectangle", {1,1,1,1,0,0,0,0}, 1, 8)   

t = lib.add_table()
r = lib.add_row()
r.add_cell(f1)
r.add_cell()
r.add_cell(f2)
r.add_cell()
r.add_cell(f3)

f1 = lib.check_fractions(1, 2)
f2 = lib.check_fractions(2, 4)
f3 = lib.check_fractions(4, 8)
r1 = lib.check_relation("=")
r2 = lib.check_relation("=")
r = lib.add_row()
r.add_cell(f1)
r.add_cell(r1)
r.add_cell(f2)
r.add_cell(r2)
r.add_cell(f3)




lib.text("Zadatak 4")

lib.text("{} = {} = {} = \(frac{5}{5}\)", 
  lib.check_fraction_enum(2, 2),
  lib.check_fraction_enum(3, 3),
  lib.check_fraction_enum(4, 4))
  



lib.text("Zadatak 5")

(ovida, array_vida) = lib.select_fraction("rectangle", 12)
(overa, array_vera) = lib.select_fraction("rectangle", 12)
t = lib.add_table()
r = t.add_row()
r.add_cell(ovida)

text = lib.text("\(\frac{2}{3}\) {} \(\frac{4}{6}\)", lib.check_relation("="))
r.add_cell(text, "span=2,vertical")

r = t.add_row()
r.add_cell(overa)
lib.check_condition(sum(array_vida) == 8)
lib.check_condition(sum(array_vera) == 8)





lib.text("Zadatak 6")
t = lib.add_table()

fraction_type = "rectangle"
for i=1,10 do
  f = lib.show_fractions(fraction_type, 1, i, i, 1)
  r = t.add_row()
  r.add_cell(f)
end

lib.text("1 = ")
for i=1,10 do
  if math.random() > 0.5 then
    lib.text("{} = ", lib.check_fraction_enum(i, i))
  else
    lib.text("{} = ", lib.check_fraction_denom(i, i))
  end
end





lib.text("Zadatak 7 slican kao 6")




lib.text("Zadatak 8 je jednostavan")




lib.text("Zadatak 9")

left_val = {2, 3, 4}
left_str = {}
for i=1,length(left)
  left_str = lib.text("\(\frac{{}}{{}}\)", 1, left_val[i])
end

right_val = {}
right_str = {}
for i=1,6 do
  ind = math.rand(3)
  broj = math.rand(10)
  right_val[i] = left_val[ind]
  right_str[i] = lib.text("\(\left{{}}{{}}\)", broj, left_val[ind]*broj)
end

lib.select_matching(left_str, right_str, left_val, right_val)




lib.text("Zadatak 10 je slican kao deo zadatka 6")





lib.text("Zadatak 11")


lib.text("Na prvoj traci oboj 3 dela. Koliko delova treba obojiti na drugoj traci")
(o1, a1) = lib.select_fraction("rectangle", 4)
(o2, a2) = lib.select_fraction("rectangle", 8)
lib.check_condition(sum(a1) == 3)  
lib.check_condition(sum(a1) == 6)  




lib.text("Zadatak 12 i 13 su slicni prethodnim")





lib.text("Zadatak 14")

prvi = 2
drugi = 4
treci = 80

lib.text("Verica je donela jaja na pijacu. ")
lib.text("Prvog dana je prodala \(\frac{1}{{}}\) a drugog dana \(\frac{1}{{}}\)", prvi, drugi)
lib.text("Treceg dana je prodala {} jaja. Koliko je jaja ukupno donela na pijacu.", treci)
lib.text("Graficki prikazi broj jaja")

treci_raz = 1 - (1/prvi) - (1/drugi)
total = treci / treci_raz

assert(total == math.floor(total))


t = lib.add_table()
r = t.add_row()
r.add_cell("Prvi dan")
r.add_cell("Drugi dan")
r.add_cell("Treci dan")
r = t.add_row()
r.add_cell(lib.check_number(total/prvi))
r.add_cell(lib.check_number(total/drugi))
r.add_cell(lib.text("{}"), treci)

lib.text("Verica je ukupno donela {} jaja.", lib.check_number(total))





lib.text("Zadaci 15-31 su jednostavni")





lib.text("Zadatak 32")


lib.text("Poredjaj razlomke od najmanjeg do najveceg")

val = {}
order = {}
obj = {}

for i=1,6 do
  enum = math.random(10)
  denom = math.random(10)
  val[i] = enum/denom
  order[i] = 1
  for j=1,i-1 do
    if val[i] > val[j] then
      order[i] = order[i] + 1
    else
      order[j] = order[j] + 1    
    end
  end
end

lib.check_order(obj, order)		# Writes array of objects <obj> in the current order
		     			# (objects can be string or anything else)
		     			# Expects user to reshuffle it and checks that
					# the final order corresponds to <order>
					# If two objects have the same order we write the same index
					# (e.g. {1, 2, 2, 4} - could be 1,2,3,4 or 1,3,2,4 - both are correct)




lib.text("Zadaci 33-34 slicni kao prethodni")





lib.text("Zadatak 35")

lib.text("Oboj gusenic: \(\frac{1}{3}\) zuta, \(\frac{2}{8}\) crvena, \(\frac{1}{6}\) plava i \(\frac{1}{4}\) narandazsta.")
broj_boja = 4
broj_polja = 24
array = lib.select_fraction("gusenica", broj_polja, broj_boja)	# array[i] == <boja> gde je <i> pozicija
      						  		# a <boja> indeks boje od 1 do broj_boja

# post condition
res = {}
for i=1,length(array) do
  res[array[i]] = res[array[i]] + 1
end
lib.check_condition(res[1] == 8)  
lib.check_condition(res[2] == 6)  
lib.check_condition(res[3] == 4)  
lib.check_condition(res[4] == 6)  




lib.text("Zadatak 36")

t = lib.add_table()
max = 8*5*3*3*7
for i=1,10 do
  r = t.add_row()
  for j=1,i do
    r.add_cell(lib.check_fraction(1, i), tostring(max/i) .. ",span=horizontal")
  end
end





lib.text("Zadatak 37")
t = lib.add_table()

fraction_type = "rectangle"
denom={2, 3, 5, 8, 10}
enum={1, 2, 2, 4, 7}
obj = {}
order = {1, 2, 2, 4, 5}
for i=1,length(denom) do
  f = lib.show_fractions(fraction_type, enum[i], denom[i], denom[i], 1)
  r = t.add_row()
  r.add_cell(f)
  obj[i] = lib.check_fraction(enum[i], denom[i])
end


lib.check_order(obj, order)





lib.text("Zadatak 38")
fraction_type = "pie"
lib.show_fraction(fraction_type, 4, 5)
obj = {}
obj[1] = lib.text("\{\frac{1}{4}\)")
obj[2] = lib.text("\{\frac{4}{5}\)")
obj[3] = lib.text("\{\frac{5}{5}\)")
lib.check_option(obj, 2)



lib.text("Zadatak 39 slican kao 38")





