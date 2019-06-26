
fraction_table = function(rows)
  no_columns = 2^(rows-1)
  text = lib.start_table()
  for r=0,rows-1 do
    text = text .. lib.start_row()
    denom = 2^r
    for c=0,2^r-1 do
      style = {}
      style["colspan"] = 2^(rows-1-r)
      style["text-align"] = "center"
      text = text .. lib.add_cell("\(\frac{1}{"..tostring(math.floor(denom)).."}\)", style)
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()
  return text
end


