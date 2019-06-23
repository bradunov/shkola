
fraction_table = function(rows)
  no_columns = 2^(rows-1)
  lib.start_table(no_columns)
  for r=0,rows-1 do
    lib.start_row()
    denom = 2^r
    for c=0,2^r-1 do
      lib.add_cell("\(\frac{1}{"..tostring(math.floor(denom)).."}\)", 0, 2^(rows-1-r), 3)
    end
    lib.end_row()
  end
  lib.end_table()
  return ""
end


