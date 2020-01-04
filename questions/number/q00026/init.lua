
addition_table = function()
  columns = 8
  min_range = 10
  max_range = 20

  q = {}
  for i=0,columns-1 do
    sum = min_range + math.random(max_range - min_range)
    adder = math.random(sum-1)
    q[i] = {}
    q[i][1] = adder
    q[i][2] = sum-adder
    q[i][3] = sum
    q[i][4] = math.random(3)
  end

  text = lib.start_table()
  for r=1,3 do
    text = text .. lib.start_row()
    style = {}
    style["text-align"] = "center"
    style["width"] = "40px"
    if r == 1 then
      text = text .. lib.add_cell("A", style)
    elseif r == 2 then
      text = text .. lib.add_cell("B", style)
    else
      text = text .. lib.add_cell("A + B", style)
    end
    for c=0,columns-1 do
      if q[c][4] == r then
        text = text .. lib.add_cell(lib.check_number(q[c][r]), style)
      else
        text = text .. lib.add_cell(tostring(q[c][r]), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
