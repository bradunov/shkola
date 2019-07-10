imenilac = math.random(5) + 1;
dao = (math.random(10));
ukupno = dao * imenilac;
ostalo = ukupno - dao;

niz_dao = {"Petar", "Vlada", "Ana", "Katarina", "Jelena", "Dejan", "Ljubica", "Milena"};
niz_uzeo = {"Petru", "Vladi", "Ani", "Katarini", "Jeleni", "Dejanu", "Ljubici", "Mileni"};
niz_joj = {"mu", "mu", "joj", "joj", "joj", "mu", "joj", "joj"}

index_dao = math.random(#niz_dao);
index_uzeo = math.random(#niz_dao - 1);
if (index_uzeo == index_dao) then
  index_uzeo = #niz_dao - 1;
end

ime_dao = niz_dao[index_dao];
ime_uzeo = niz_uzeo[index_uzeo];
joj = niz_joj[index_dao];


