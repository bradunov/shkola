
include("terms")

addition_table = function()
  columns = 4
  
	
  q = {}
  denom = {}
  ind = {}

  for i=0,columns-1 do
    q[i] = {}	 
    q[i][3] = math.random(200)
    q[i][2] = q[i][3]/100	
	tmp = lib.math.gcd(q[i][3], 100)
	q[i][1] = math.floor(q[i][3]/tmp)
	denom[i] = math.floor(100/tmp)
    q[i][4] = math.random(3)
  end

  style = {}
  style["text-align"] = "center"
  style["width"] = "60px"
  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell(msg_frac, style)
  text = text .. lib.add_cell(msg_dec, style)
  text = text .. lib.add_cell(msg_per, style)
  text = text .. lib.end_row()
  for c=0,columns-1 do
    text = text .. lib.start_row()
    for r = 1,3 do
        if q[c][4] == r then
	       if (r == 1) then
               text = text .. lib.add_cell("\(\frac{" .. tostring(q[c][r]) .. "}{" .. tostring(denom[c]) .. "}\)", style)	
		   end	   
           if (r == 2) then			   
               text = text .. lib.add_cell(lib.dec_to_str(q[c][r]), style)	
           end
		   if (r == 3) then
               text = text .. lib.add_cell(tostring(q[c][r]), style)	
           end		
        else
	       if (r == 1) then
               text = text .. lib.add_cell(lib.check_fraction_simple(q[c][r], denom[c]), style)
		   else	     
               text = text .. lib.add_cell(lib.check_number(q[c][r]), style)
           end		
        end
    end
    text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
                  
         