
include("terms")

addition_table = function()

  measure = {measures_str[1].."  cm", measures_str[1].." cm", measures_str[2].." \( \ \) cm", measures_str[3].." cm²"} 
  columns = 5
  min_range = 5
  max_range = 99

  sign = {}
  q = {}
  for i=0,columns-1 do
    sign[i] = {}
    sign[i][1] = math.random(2) - 1
    sign[i][2] = math.random(2) - 1	
    sign[i][3] = math.max(sign[i][1], sign[i][2])
    sign[i][4] = sign[i][1] + sign[i][2]	
    edge1 = min_range + math.random(max_range - min_range) 
    edge2 = min_range -1 + math.random(edge1 - min_range) / 10^sign[i][2]
    edge1 = edge1 / 10^sign[i][1]	
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
	text = text .. lib.add_cell(lib.dec_to_str(lib.math.round_dec(q[c][1],sign[c][1])), style)
    for r=2,4 do
      if q[c][5] ~= r then
        tmp = lib.math.round_dec(q[c][r],sign[c][r])
        text = text .. lib.add_cell(lib.check_number(tmp,35), style)
      else
        text = text .. lib.add_cell(lib.dec_to_str(lib.math.round_dec(q[c][r],sign[c][r])), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
