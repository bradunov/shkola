array_enum = {}
array_denom = {}
array_value = {}

factor = math.random(5);

for i=1, 4 do    
    array_enum[i] = factor;
    array_denom[i] = math.random(9);
    array_value[i] = array_enum[i] / array_denom[i];
end


indices = lib.math.argsort(array_value);
