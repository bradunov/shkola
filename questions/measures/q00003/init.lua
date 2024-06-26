
include("terms")

addition_table = function()

  measure = {measures_str[1].."  cm", measures_str[1].." cm", measures_str[2].." \( \) cm", measures_str[3].." cm²"} 
  columns = 5
  min_range = 5
  max_range = 20

  q = {}
  for i=0,columns-1 do
    edge1 = min_range + math.random(max_range - min_range)
    edge2 = min_range -1 + math.random(edge1 - min_range)
    circ = 2 * (edge1 + edge2)
	area = edge1 * edge2
    q[i] = {}
    q[i][1] = edge1
	q[i][2] = edge2
    q[i][3] = circ
    q[i][4] = area
    q[i][5] = 1 + math.random(3)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "60px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell(measure[1], style)
  text = text .. lib.add_cell(measure[2], style)
  text = text .. lib.add_cell(measure[3], style)
  text = text .. lib.add_cell(measure[4], style)
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
	text = text .. lib.add_cell(tostring(q[c][1]), style)
    for r=2,4 do
      if q[c][5] ~= r then
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
 