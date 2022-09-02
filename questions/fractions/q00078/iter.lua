
style_table_current = style_table
style_table_current["color"] = array_boja[ITEM]

array_table = {};
enum = ITEM;
denom = fct * ITEM;
for i=1,denom do
  if (i <= ITEM) then
    array_table[i] = 1
  else
    array_table[i] = 0
  end
end

style_table_current["initial_state"] = array_table
      