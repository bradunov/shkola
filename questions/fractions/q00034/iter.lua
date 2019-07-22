style_table_current = style_table
style_table_current["color"] = array_boja[ITEM]


array_table = {};
enum = 0;
denom = 8;
for i=1,4 do
  for j=1,2 do
    if math.random() > 0.5 then
      array_table[(i-1)*2+j] = 1
      enum = enum + 1
    else
      array_table[(i-1)*2+j] = 0
    end
   end
end

style_table_current["initial_state"] = array_table
