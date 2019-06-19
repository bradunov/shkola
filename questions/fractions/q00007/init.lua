
fraction_table = function(rows)
  no_columns = 2^(rows-2)*5
  lib.start_table(no_columns, 1)
  for r=0,rows-1 do
    lib.start_row()
    if (r==0) then
      denom = 1
    else 
      denom = 2^(r-1)*5
    end
    for c=0,denom-1 do
      lib.add_cell("\(\frac{1}{"..tostring(math.floor(denom)).."}\)", 0, no_columns / denom, 3)
    end
    lib.end_row()
  end
  lib.end_table()
  return ""
end
