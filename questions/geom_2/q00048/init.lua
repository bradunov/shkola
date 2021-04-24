
include("terms")

addition_table = function()
  columns = 6
  min_range = 10
  max_range = 20

  ch = {""}
  q = {}
  for i=0,columns-1 do
    edge1 = min_range + math.random(max_range - min_range)
    edge2 = min_range -7 + math.random(max_range - min_range)
    edge3 = min_range + 7 + math.random(max_range - min_range)
	ind = 1
    if (edge1 <= edge2 - edge3 or edge1 >= edge2 + edge3) then
	    ind = 0
	end	
    if (edge2 <= edge3 - edge1 or edge2 >= edge3 + edge1) then
	    ind = 0
	end	
    if (edge3 <= edge1 - edge2 or edge3 >= edge1 + edge2) then
	    ind = 0
	end			
    q[i] = {}
    q[i][1] = edge1
	q[i][2] = edge2
    q[i][3] = edge3
	if (ind == 1) then
        ch[i] = check[1]
	else
        ch[i] = check[2]	
    end		
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "50px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell(msg[1], style)
  text = text .. lib.add_cell(msg[2], style)
  text = text .. lib.add_cell(msg[3], style)
  text = text .. lib.add_cell(msg[4], style)
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r = 1,3 do
        text = text .. lib.add_cell(tostring(q[c][r]), style)
    end
	text = text .. lib.add_cell(lib.check_string(ch[c],15), style) 
	text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
   
  