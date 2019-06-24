
fraction_table = function(rows)
  no_columns = 2^(rows-2)*5
  text = lib.start_table(no_columns)
  for r=0,rows-1 do
    text = text .. lib.start_row()
    if (r==0) then
      denom = 1
    else 
      denom = 2^(r-1)*5
    end
    for c=0,denom-1 do
      text = text .. lib.add_cell("\(\frac{1}{"..tostring(math.floor(denom)).."}\)", 0, no_columns / denom, 3)
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()
  return text
end
