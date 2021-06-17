
include("terms")

addition_table = function()

  measure = {measures_str[1].."  cm", measures_str[2].." cm", measures_str[3].." \( \ \) cm", measures_str[4].." cm\(^2\)"} 
  columns = 6
  min_range = 5
  max_range = 99

  q = {}
  for i=0,columns-1 do
    sign1 = math.random(2) - 1
    sign2 = math.random(2) - 1	
    edge1 = min_range + math.random(max_range - min_range) 
    edge2 = min_range - 3 + math.random(edge1 - min_range) / 10^sign2
    edge1 = edge1 / 10^sign1	
    if (edge1 < edge2) then
        tmp = edge2
        edge2 = edge1
        edge1 = tmp
    end
    circ = 4 * edge1
	area = edge1 * edge2
    q[i] = {}
    q[i][1] = edge1
	q[i][2] = edge2
    q[i][3] = circ
    q[i][4] = area
    q[i][5] = 1 + math.random(3)
    q[i][6] = math.random(q[i][5]-1)
    if (q[i][5]	== 3 and q[i][6] == 1) then
	    q[i][6] = 2
    end		
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
    for r=1,4 do
      if (q[c][5] == r or q[c][6] == r) then
          text = text .. lib.add_cell(lib.dec_to_str(lib.math.round_dec(q[c][r],4)), style)
      else 
          tmp = lib.math.round_dec(q[c][r],4)
          text = text .. lib.add_cell(lib.check_number(tmp,40), style)
      end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end  
         