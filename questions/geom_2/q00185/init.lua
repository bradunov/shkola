
include("terms")

addition_table = function()
  columns = 5
  min_range = 2
  max_range = 10

  q = {}
  for i=0,columns-1 do
    q[i] = {}
    q[i][1] = min_range + math.random(max_range)
	q[i][2] = min_range + math.random(max_range)
	q[i][3] = min_range + math.random(max_range)	
    q[i][4] = q[i][1] * q[i][2] *q[i][3] 
    q[i][5] = math.random(4)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "60px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell(element[1], style)
  text = text .. lib.add_cell(element[2], style)
  text = text .. lib.add_cell(element[3], style)
  text = text .. lib.add_cell(element[4], style)
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,4 do
      if q[c][5] == r then
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
       