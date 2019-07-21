style_table_current = style_table
style_table_current["color"] = array_boja[ITEM]


array_table = {};
enum = 0;
denom = 5+ITEM;
for i=1,denom do
  if math.random() > 0.5 then
    array_table[i] = 1
    enum = enum + 1
  else
    array_table[i] = 0
  end
end

style_table_current["initial_state"] = array_table
