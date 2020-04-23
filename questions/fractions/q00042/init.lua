array_enum = {}
array_denom = {}
array_value = {}
is_ok = {}
solution = {}

factor = math.random(5) + 1;

for i=1, 4 do    
    array_denom[i] = factor;
    array_enum[i] = math.random(9) + 1;
    array_value[i] = array_enum[i] / array_denom[i];
    is_ok[i] = "is_ok = math.eq(numerator/denominator, "..tostring(array_value[i])..");"
    solution[i] = "numerator="..tostring(array_enum[i])..";denominator="..tostring(array_denom[i])..";"
end


indices = lib.math.argsort(array_value);
