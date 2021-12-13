
include("terms")

addition_table = function()
   columns = 5

   brojilac = {}
   imenilac = {}
   value = {}
   result = {}
   round = {}
   err = {}
   
   for i = 0,columns-1 do
       init = 3 + math.random(3)
       round[i] = math.random(init - 1) - 1
       dec = 10^round[i]                                                                                                 
       brojilac[i]  = 2 + math.random(997)
       imenilac[i] = 2 + math.random(497)
       if (brojilac[i] - imenilac[i] * math.floor(brojilac[i]/imenilac[i]) == 0) then
           brojilac[i] = brojilac[i] - 1
       end	
	   
       value[i] = brojilac[i]/imenilac[i]	
       result[i] = lib.math.round_dec(value[i], round[i])  
       value[i] = lib.math.round_dec(value[i], init) 
	   err[i] = lib.math.round_dec(1/dec, round[i])
   end

  style = {}
  style["text-align"] = "center"
  style["width"] = "65px"

   text = lib.start_table()
   text = text .. lib.start_row()
   text = text .. lib.add_cell(title[1], style)
   text = text .. lib.add_cell(title[2], style)
   text = text .. lib.add_cell(title[3], style)
   text = text .. lib.add_cell(title[4], style)  
   text = text .. lib.end_row()
   for c=0,columns-1 do
       text = text .. lib.start_row()	
       ch = math.random(2)	
       if (ch == 1) then	   
           text = text .. lib.add_cell(lib.dec_to_str(value[c]), style)
	   else
           text = text .. lib.add_cell("\(\frac{" .. tostring(math.floor(brojilac[c])) .. "}{" .. tostring(math.floor(imenilac[c])) .. "}\)", style)
       end	   
       text = text .. lib.add_cell(round[c], style)	   
       text = text .. lib.add_cell(lib.check_number(result[c],40), style)		   
       text = text .. lib.add_cell(lib.check_number(err[c],40), style)
   text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end    
            