
fraction_table = function()

  question = {["border"] = "0px",
        ["colspan"] = 3,
        ["width"] = "30px",
        ["height"] = "30px",
        ["text-align"] = "center",
        ["background-color"] = "#ffffff"};

  rows = 6
  --[[ We need gcd(1,2,3,5,6,10) to do the right colspans]]--
  gcd = 30
  array = {1,2,3,5,6,10}
  text = lib.start_table()
  for r=0,rows-1 do
    text = text .. lib.start_row()
    denom = array[r+1]
    for c=0,denom-1 do
      style = {}
      style["colspan"] = gcd/denom
      print(denom, gcd, style["colspan"])
      style["text-align"] = "center"
      style["width"] = "10px"
      style["border"] = "1px solid"
      if (c < 2) then
        style["background-color"] = "#ff99cc"
        text = text .. lib.add_cell("\(\frac{1}{"..tostring(denom).."}\)", style)
      else
        style["background-color"] = "#ffffff"
        text = text .. lib.add_cell("", style)
      end
    end

    if (denom == 1) then
      res = 1
    else
      res = 2
    end
    text = text .. lib.add_cell(lib.check_fraction(res, denom), question)

    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()
  return text
end




