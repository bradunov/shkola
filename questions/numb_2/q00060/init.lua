
addition_table = function()
  columns = 5
  min_range = 39
  max_range = 60

  q = {}
  for i=0,columns-1 do
    q[i] = {}
    q[i][1] = min_range - math.random(max_range)
    q[i][2] = min_range - math.random(max_range)
	if (q[i][1] >= 0 and q[i][2] >= 0) then
	    sign = math.random(2)
		q[i][sign] = -q[i][sign]
	end	
    q[i][3] = q[i][1] + q[i][2]
    q[i][4] = math.random(3)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "50px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("A", style)
  text = text .. lib.add_cell("B", style)
  text = text .. lib.add_cell("A + B", style)
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,3 do
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
                  

                  