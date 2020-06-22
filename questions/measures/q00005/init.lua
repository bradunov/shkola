
addition_table = function()

  measure = {"dužina  cm", "širina  cm", "visina  cm", "površina cm\(^2\)"} 
  columns = 6
  min_range = 5
  max_range = 20

  q = {}
  for i=0,columns-1 do
    edge1 = min_range + 1 + math.random(max_range - min_range)
    edge2 = min_range + math.random(edge1 - min_range)
    edge3 = min_range -1 + math.random(edge2 - min_range)
	area = (edge1 * edge2 + edge1 * edge3 + edge2 * edge3) * 2 
    q[i] = {}
    q[i][1] = edge1
	q[i][2] = edge2
    q[i][3] = edge3
    q[i][4] = area
    q[i][5] = math.random(4)
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
           
            
  