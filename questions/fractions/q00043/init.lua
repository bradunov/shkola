array_enum = {}
array_denom = {}
array_value = {}

for i=1, 4 do    
    array_denom[i] = math.random(9);
    array_enum[i] = math.random(array_denom[i]);
    array_value[i] = array_enum[i] / array_denom[i];
end

indices = lib.math.argsort(array_value);