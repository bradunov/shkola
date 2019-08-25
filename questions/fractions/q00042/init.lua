array_enum = {}
array_denom = {}
array_value = {}

factor = math.random(5) + 1;

for i=1, 4 do    
    array_denom[i] = factor;
    array_enum[i] = math.random(9) + 1;
    array_value[i] = array_enum[i] / array_denom[i];
end

indices = lib.math.argsort(array_value);
