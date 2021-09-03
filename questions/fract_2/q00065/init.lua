
include("terms")

addition_table = function()
  columns = 6
  min = 3
  max = 6
	
  q = {}
  denom = {}
  ind = {}

  for i=0,columns-1 do
    q[i] = {}	
    ind[i] = math.random(3)
    if (ind[i] < 3) then
       fact = 10^ind[i]
       min_range = min*fact
       max_range = max*fact
       q[i][1] = (min_range - math.random(max_range))/fact
	   denom[i] = 1
    else
       q[i][1] = min - math.random(max)	
       denom[i] = min + math.random(max)	   
    end	   
    if (q[i][1] == 0) then
	    q[i][1] = min - max
    end	
    q[i][2] = -q[i][1]
    q[i][3] = math.abs (q[i][1])	   	
    q[i][4] = math.random(2)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "60px"
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
	       if (ind[c] < 3) then
               text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)	
           else
               text = text .. lib.add_cell("\(\frac{" .. tostring(q[c][r]) .. "}{" .. tostring(denom[c]) .. "}\)", style)	
           end		
        else
	       if (ind[c] < 3) then	  
               text = text .. lib.add_cell(lib.check_number(q[c][r]), style)
           else
               text = text .. lib.add_cell(lib.check_fraction_simple(q[c][r], denom[c]), style)
           end		
        end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end