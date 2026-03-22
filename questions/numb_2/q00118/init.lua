
include("terms")
include("names")

r = math.random(#musko_ime_nom)
ime = musko_ime_nom[r] 

notes = ""
notee = ""

starth = 8 + math.random(4)
startm = math.random(4) - 1
dif = 1 + math.random(6)
endh = starth + dif
endm = math.random(4) - 1
dist = 120 + math.random(30)
first = 69 + math.random(10) 

add = (endm - startm) /4 
result = lib.math.round((dif  + add) * dist - first)
startm = 15 * startm
endm = 15 * endm
if (startm ~= 0) then
    notes = " " .. tostring(startm) .. " " .. meas
end
if (endm ~= 0) then
    notee = " " .. tostring(endm) .. " " .. meas
end          