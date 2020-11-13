# Brza pomoc


## Razne komande

Lista komandi koje mogu biti od koristi pri pisanju zadataka, bilo u tekstu bilo u Lua kodu. 

| **naredba**                                                                                | **komentar**                                                                                                                                                                  | **Primer zadatka** |
| --------- | ----------- | --------------------- | 
| `pink = {\["border"\] = "1px solid", \["width"\] = "30px", \["height"\] = "30px", \["text-align"\] = "center", \["background-color"\] = "\#ff99cc"};`        | Definisanje stila celije u tabeli odredjene (pink) boje                                                                                                                      | fract1 |
| `border = {\["border-collapse"\] = "collapse"};                                           ` | Granica tabele                                                                                                                                                               | fract1 |
| `@lib.start\_table({\["text-align"\] = "center"})@ .... @lib.end\_table()@                ` | Formiranje tabele (pocetak I kraj) (razdvojene celije)                                                                                                                       | fract1 |
| `@lib.start\_row()@ ….. @lib.end\_row()@                                                  ` | Formiranje reda u tabeli                                    |  fract1 | 
| `@lib.add\_cell("", pink)@                                                                ` | Polje u redu odredjene boje                                 |  fract1,8 | 
| `fraction\_table = function(rows) …. end                                                  ` | Tabela sa razlicitim brojem elemenata u vrsti (program)     |  fract6, 7,12,14 | 
| `@fraction\_table(3)@                                                                     ` | Pozivanje programa function                                 |  fract6,7 | 
| `@lib.fraction\_circle(number)@                                                           ` | Podela kruga na number delova                               | fract15 | 
| `array\_triangle = {0,0,0,0,0,0};…style\_triangle                                         ` | Polje trouglova zadatog stila                               | fract10 | 
| `array\_circle = {0,0,0,0,0,0}; … style\_circle                                           ` | Polje krugova zadatog stila                                 | fract10 | 
| `array\_square = {0,0,0,0,0,0};….style\_square                                            ` | Polje kvadrata zadatog stila                                | fract10 | 
| `@lib.select\_objects(3, 2, "triangle/circle/square", "", style\_triangle/circle/square)@ ` | Tabela dimen. 3x2 naznacenih objekata (jedan od)            | fract10,13, 15 | 
| `tostring( number)                                                                        ` | Pretvara broj u string                                      |  numb89 | 
| `@center@                                                                                 `  | Postavljanje teksta na sredinu                                                                                                                                               |  | 
| `@lib.start\_table({\["text-align"\] = "inline"})@                                        `  | Tekst u redu sa tabelom                                                                                                                                                      | fract9 | 
| `style\_square = { \["text-align"\] = "inline"}                                           `  | Tekst u redu sa slikom                                                                                                                                                       | fract10,11 | 
| `@repeat(3)@ ……. @/repeat@                                                                `  | Broj ponavljanja teksta                                                                                                                                                      | fract2 | 
| `\\(\\frac{@brojilac@}{@imenilac@}\\)                                                     `  | Ispisivanje razlomka (TEX komnda)                                                                                                                                            | fract4 | 
| `\\(TEX komanda\\) ( eg. \\(\\leq\\) , \\(\\geq\\) , \\(\\in\\) )                         `  | Inport tex teksta (=&lt; , &gt;=, pripada skupu)                                                                                                                             | eq19 | 
| `==, \~=, &gt;, &lt;, &gt;=, &lt;=                                                        `  | relacioni operatori u if naredbi                                                                                                                                             | numb24 | 
| `and, or, not                                                                             `  | logicki operatori u if naredbi                                                                                                                                               |  | 
| `\&middot; "÷"                                                                            `  | Operacija “puta” (tacka u sredini)                                                                                                                                           |  | 
| `@lib.check\_number(vredn, number)@                                                       `  | Provera da li je upisanog broja; number odredjuje dimenziju prozora za upis odgovora, default je 33                                                                          | fract6,8 | 
| `@lib.check\_number('is\_ok = (answer == 2)')@                                            `  | Provera tacnosti upisanog broja;                                                                                                                                             | fract1 | 
| `@lib.check\_string("&gt;", number)@                                                      `  | Provera upisanog stringa; number odredjuje dimenziju prozora za upis odgovora, default je 33 (ako izostavimo)                                                                | fract6 | 
| `@lib.check\_string(reply, 30, ans)@                                                      `  | Provera jednog, ako su moguci razliciti tacni odgovori; ans sadrzi tacan odgovor koji ce dati opcija resenje                                                                 | geom.68 | 
| `reply = "answer == '" .. prava\[1\] .. "' " .. "\|\| answer == '" .. prava\[2\] .. "'" ; ans = "answer = '" .. prava\[1\] .. "' ";`   |   koji ce dati opcija resenje     |   | 
| `@lib.check\_fraction\_simple(jbrojilac, jimenilac)@                                      `  | Provera upisanog razlomka                                                                                                                                                    | fract4, 5, 16 | 
| `@lib.check\_fraction("is\_ok = (numerator/denominator == 0.5)")@                         `  | Provera upisanog razlomka racunanjem da li je jednak upisanom broju                                                                                                          | fract1 | 
| `condition = "is\_ok = math.eq(whole + numerator/denominator, "..tostring(vrednost)..");" `  | Postavljanje uslova cija se tacnost proverava                                                                                                                                | fract3 | 
| `@lib.check\_fraction\_condition(condition, true)@                                        `  | Provera uslov. True se pise ukoliko zalimo celobrojni deo                                                                                                                    | fract3,10 | 
| `@lib.check\_fraction\_numerator(5, 6, 1)@                                                `  | Provera tacnog unosa brojioca. Poslednji je celobrojni deo koji moze biti izostavljen                                                                                        | fract32 | 
| `@lib.check\_fraction\_numerator(5, 6)@                                                   `  |                                                                                                                                                                              |  | 
| `@lib.check\_fraction\_denominator(5, 6, 1)@                                              `  | Provera tacnog unosa imenioca. Poslednji je celobrojni deo koji moze biti izostavljen                                                                                        | fract32 | 
| `@lib.check\_fraction\_denominator(5, 6)@                                                 `  |                                                                                                                                                                              |  | 
| `@lib.check\_one\_option(answ,ind, true)@                                                 `  | Visestruki izbor: da li je obojen ind (0,…) tacka po redu, ako je answ(ind+1) tacno. Ako je poslednji parameter true opcije su vertikalno, a ako je izostavljen horizontal.  | numb87 –horizontal | 
| `lib.math.gcd(jimenilac, jbrojilac)                                                       `  | Najveci zajednicki delilac                                                                                                                                                   | fract4 | 
| `lib.math.argsort(array\_value)                                                           `  | Sortiranje niza po velicini                                                                                                                                                  | fract19 | 
| `math.eq(x, y, \[precision\])                                                             `  | abs(x-y)&lt;precision. Default precision je 0.00001, ako nema                                                                                                                | fract3 | 
| `= math.modf(numb)                                                                        `  | Daje celobrojni deo broja numb                                                                                                                                               |  | 
| `math.ceil(numb) / math.floor(numb)                                                       `  | Daje ceo broj veci/manji od numb (I za &lt;0                                                                                                                                 | geom..33 | 
| `lib.math.random\_shuffle(test)                                                           `  | Slucajno permutuje zadati ulazni niz                                                                                                                                         |  | 
| `B % A                                                                                    `  | Modulus operator (ostatak pri deljenju celih brojeva)                                                                                                                        |  | 
| `math.abs (x)                                                                             `  | Absolutna vrednost                                                                                                                                                           |  | 
| `include("names")                                                                         `  | global/names: musko/zensko\_ime\_ padez, musko/zensko\_pridev                                                                                                                | fract17, 20, 21 | 
| `padez = musko\_ime\_dativ\[index\_ime\]                                                  `  | ime u naznacenom padezu                                                                                                                                                      | fract20 | 
| `string.lower("ABCD")                                                                     `  | Pretvara stringove u mala slova                                                                                                                                              |  | 
| `--\[\[ tekst \]\]--                                                                      `  | oznaka za komentar                                                                                                                                                           |  | 
| `“\\” (enter odmah iza)                                                                   `  | Kraj reda, bez automat. preloma                                                                                                                                              |  | 
| `@vspace@                                                                                 `  | vertikalni prazan red (prored)                                                                                                                                               |  | 
| `@hspace@                                                                                 `  | horizontalni prazan red (razmak)                                                                                                                                             |  | 
| `@hspacept(8)@                                                                            `  | fino podesavanje horiont. Razm.                                                                                                                                              |  | 
| `@h3@ tekst @/h3@ (h1, h3,                                                                `  | Opcioni izbor fonta u naslovu                                                                                                                                                |  | 
| `\&\#8451                                                                                 `   | Oznaka za stepen Celzijusa (tekst)                                                                                                                                           | Num.134 | 





**BOJE**

|  **colours**   | **kod**     | **komanda** |
|  ------------- | ----------- | ------------------------------------- |
|  white         | fff         | `style = { …… , \["color"\] = "fff"}` |
|  black         | 000         |    |
|  green         | 6f6         |    |
|  orange        | f90         |    |
|  red           | f30         |    |
|  pink          | f9c         |    |
|  blue          | 0cf         |    |
|  yelow         | ff0         |    |
|  brown         | c90 (c60)   |    |

[Link](https://www.w3schools.com/colors/colors_picker.asp) sa prikazom boja
(Ovde je kod od 6 heksadecimalnih simbola, svaki od navedenih u tabeli
je dupliran).



**CRTANJE**

|  **naredba**                                                                                        | **komentar**                                                                                                                                                                                  | **Zad.**
|  ------------- | ----------- | ------------------------------------- |
|  `mycanvas = function(args) ...\&lt;body\&gt; `                                                      | definise mycanvas(args) kao funkciju sa argumentom args (ili vise argumenata)                                                                                                                 |  | 
|  `lib.start\_canvas(500, 300, "center", "result\[0\] == 0 && result\[1\] == 0 && result\[2\] == 0") ...  lib.end\_canvas() ` | Postavljanje pravougaone osnove (sirina –visina) na kojoj se pozicioniraju objekti (definisani izmedju start i end). && result\[1\] == 1 … redosled objekta koji je tacan odgovor (broje se oni kod kojih je selektovano stanje true, to je default) Ako je result() izostavljeno, ne moze se nista selektovati. | geom101 | 
|  `style = {\["off\_color"\] = "000", \["on\_color"\] = "f00", \["line\_color"\] = "f00", \["off\_line\_color"\] = "000", \["line\_width"\] = "2"}; { \["off\_color"\] = "none",… \["opacity"\] = "0.5",…} `  | Ako je none, transparentna slika, nema boje; 0=&lt;opacity=&lt;1 odredjuje intenzitet boje: 0 nema boje, a 1 je maksimalna; default je 1 (ako se izostavi) | geom13, numb11 | 
|  `lib.add\_ellipse(250, 150, 230, 140, style, "", false )  `                                          | Sa add se dodaje objekat: Elipsa, pravougaonik, trougao, krug.  Prva dva broja je (*x,y*) pozicija objekta na platnu (*y* se meri od vrha na dole), slede sirina I visina (tj. poluprecnk za krug).  Style odredjuje boje I debljinu linije. Poslednja dva parametra odredjuju inicijalno (false default) I izabrano (true default) selektovanje. Ako su izostavljeni, uzima se default vrednost. | geom101 | 
|  `lib.add\_rectangle (200, 50, 20, 50, style, true)                                       `           |                                                                                                                                                                                               |    | 
|  `lib.add\_triangle (150, 150, 20, 50, style)                                             `           |                                                                                                                                                                                               |  | 
|  `lib.add\_circle (250, 250, 20)                                                          `           |                                                                                                                                                                                               |  | 
|  `lib.add\_straight\_path (320, 100, {{50, 0}, {0, 50}}, red\_line, "", false)            `           | Pocetna tacka I niz segmenata izlomljene linije (moze ih biti proizvoljan broj), definisanih krajevima (pocetak je uvek kraj prethodne linije)                                                |  | 
|  `lib.add\_curved\_path (320, 100, {{50, 0, 50, 50}}, style, "", false)                   `           | Druga dva broja su pomeranje kao i ranije, a prva dva broja definisu referentu tacku luka pomeranja (mogu biti I negativni brojevi)                                                           |  | 
|  `lib.add\_line(10, 10, 50, 100, style, false, false)                                     `           | Prva dva broja odredjuju pocetak, a druga dva kraj linije(relativno, u odnosu na pocetak)                                                                                                     |  | 
|  `lib.add\_check\_box(x, y, a, b, check\_style, false, true)                              `           | Crta “stiklicu” na (x,y) poziciji velicine levg kraka a I desnog kraka b                                                                                                                      | geom12 | 
|  `lib.add\_text(20, 52, "ispred", text\_style, false, false)                              `           | Upis teksta na naznacenoj poziciji                                                                                                                                                            |  | 
|  `text\_style = {\["font\_size"\] = "16"}                                                 `           | Definisanje velicine slova u tekstu                                                                                                                                                           |  | 
|  `lib.add\_input(x, y, width, height, text)                                               `           | postavljanje upita *text* (number, string) na (x,y) poziciju na crtezu; width, height odredjuju dimenzije prozora za odgovor                                                                  | numb7 | 
|  `include("shapes")    --\[\[ eg. heart(lib, 160, 100, scale, style, false, true) \]\] -- `           | global/shapes: heart, leaf, cross, diamond oblici na zadatoj poziciji scale velicine                                                                                                          | geom14 | 



