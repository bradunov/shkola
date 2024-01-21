
include("terms")

addition_table = function()
  columns = 5

  q = {}
  for i=0,columns-1 do
    q[i] = {}
	term = math.random(8)
    q[i][2] = 11 + math.random(88)
    q[i][3] = 5 + math.random(34)
    q[i][4] = math.random(q[i][2] - 1)
	q[i][1] = q[i][2] * q[i][3] + q[i][4]
    q[i][5] = math.random(4)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "60px"

  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell(title[1], style)
  text = text .. lib.add_cell(title[2], style)
  text = text .. lib.add_cell(title[3], style)
  text = text .. lib.add_cell(title[4], style)  
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
	ind = 1 + math.random(2)	
    for r=1,4 do
      if (q[c][5] == r) then
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