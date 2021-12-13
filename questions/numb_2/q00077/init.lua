
include("terms")

addition_table = function()
   columns = 5

   number = {}
   value = {}
   result = {}
   round = {}
   err = {}
   
   for i = 0,columns-1 do
       init = 3 + math.random(3)
       round[i] = math.random(3) - 1
       dec = 10^round[i]                                                                                                 
       number[i]  = 2 + math.random(997)
       value[i] = math.sqrt (number[i])	   
       if (value[i] - math.floor(value[i]) == 0) then
           number[i] = number[i] + 1
           value[i] = math.sqrt (number[i])		   
       end		   	
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
       text = text .. lib.add_cell("√" .. number[c] , style)	   
       text = text .. lib.add_cell(round[c], style)	   
       text = text .. lib.add_cell(lib.check_number(result[c],40), style)		   
       text = text .. lib.add_cell(lib.check_number(err[c],40), style)
   text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end    
                   