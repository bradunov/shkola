
jimenilac = math.random(8) + 1
jbrojilac = math.random(jimenilac)

gcdi = math.random(3) + 1;
gcdb = 5 - math.random(ITEM); 
fact = gcdb/gcdi 
znak = "="   

imenilac = jimenilac * gcdi
brojilac = jbrojilac * gcdb 

if (fact < 1) then znak = ">"
end

if (fact > 1) then znak = "<"
end                   
