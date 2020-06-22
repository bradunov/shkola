
addition_table = function()

  measure = {" ivica \( \) cm", "površina strane cm\(^2\)", "površina kocke  cm\(^2\)", "zapremina cm\(^3\)"} 

  columns = 6
  min_range = 5
  max_range = 20

  q = {}
  for i=0,columns-1 do
    edge = min_range + math.random(max_range - min_range)
	area = edge * edge
	surface = 6 * area
	volume = area * edge
    q[i] = {}
    q[i][1] = edge
    q[i][2] = area
    q[i][3] = surface
    q[i][4] = volume	
    q[i][5] = math.random(3)
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
    
         
            
  