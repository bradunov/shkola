include("terms")

q1 = {"Abraham Lincoln", "William Shakespeare", "Isaac Newton", "Leonardo da Vinci", "Marjam Mirzahani", "Charlie Chaplin"}
q2 = {1809, 1564, 1642, 1452, 1977, 1889}
q3 = {"MDCCCIX", "MDLXIV", "MDCXLII", "MCDLII", "MCMLXXVII", "MDCCCLXXXIX"}
q4 = {56, 52, 84, 67, 40, 88}
q5 = {"LVI", "LII", "LXXXIV", "LXVII", "XL", "LXXXVIII"}


addition_table = function()
  columns = 6

  style = {}
  style["text-align"] = "center"
  style["width"] = "40px"

  text = lib.start_table()
  text = text .. lib.start_row()
  text = text .. lib.add_cell("", style)
  text = text .. lib.add_cell(msg_birth_a, style)
  text = text .. lib.add_cell(msg_birth_r, style)
  text = text .. lib.add_cell(msg_year_a, style)
  text = text .. lib.add_cell(msg_year_r, style)
  text = text .. lib.end_row()
  for i = 1,6 do
      text = text .. lib.start_row()
      text = text .. lib.add_cell(q1[i], style)
	  indb = math.random(2)	
      if (indb == 1) then
          replyb = "answer == '" .. q2[i] .. "' ";  
          ansb = "answer = '" .. q2[i] .. "' ";  	  
	      text = text .. lib.add_cell(lib.check_number(replyb,30,ansb), style)
          text = text .. lib.add_cell(q3[i], style)	  
      else
          replyb = "answer == '" .. q3[i] .. "' ";  
          ansb = "answer = '" .. q3[i] .. "' ";  	  
          text = text .. lib.add_cell(tostring(q2[i]), style)		  
        text = text .. lib.add_cell(lib.check_string(replyb,70,ansb), style)
      end
      inda = math.random(2)	
      if (inda == 1) then
          replya = "answer == '" .. q4[i] .. "' ";  
          ansa = "answer = '" .. q4[i] .. "' ";  		  
	      text = text .. lib.add_cell(lib.check_number(replya,30,ansa), style)
          text = text .. lib.add_cell(q5[i], style)	  
      else
          replya = "answer == '" .. q5[i] .. "' ";  
          ansa = "answer = '" .. q5[i] .. "' ";  		  
          text = text .. lib.add_cell(tostring(q4[i]), style)		  
          text = text .. lib.add_cell(lib.check_string(replya,70,ansa), style)
      end	  
      text = text .. lib.end_row()
  end
  text = text .. lib.end_table()

  return text
end
 