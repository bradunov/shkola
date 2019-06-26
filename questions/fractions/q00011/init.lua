
fraction_table = function()
  rows = 6
  --[[ We need gcd(1,2,3,4,5,6) to do the right colspans]]--
  gcd = 60
  text = lib.start_table()
  for r=0,rows-1 do
    text = text .. lib.start_row()
    denom = r+1
    for c=0,denom-1 do
      style = {}
      style["colspan"] = gcd/(r+1)
      print(r+1, c, gcd, style["colspan"]) 
      style["text-align"] = "center"
      style["width"] = "40px"
      if (c == 0) then
        text = text .. lib.add_cell(lib.check_fraction(1, r+1), style)
      else
        text = text .. lib.add_cell("", style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()
  return text
end



                  