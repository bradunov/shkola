
include("terms")

addition_table = function()
  columns = 5
  min_range = 39
  max_range = 60
	
  q = {}
  for i=0,columns-1 do
    q[i] = {}
    q[i][1] = min_range - math.random(max_range)
    q[i][2] = -q[i][1]
    q[i][3] = math.abs (q[i][1])
    q[i][4] = math.random(2)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "40px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell(msg_tue, style)
  text = text .. lib.add_cell(msg_change, style)
  text = text .. lib.add_cell(msg_wed, style)
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r=1,3 do
      if q[c][4] == r then
        text = text .. lib.add_cell(tostring(q[c][r]), style)	  
      else
        text = text .. lib.add_cell(lib.check_number(q[c][r]), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
