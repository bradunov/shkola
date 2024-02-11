
include("terms")

text_style = 
	{["off_color"] = "000",
        ["on_color"] = "f00",
        ["line_color"] = "f00",
        ["off_line_color"] = "000",
        ["line_width"] = "1",
        ["font_family"] = "Helvetica",
	["font_size"] = "40"};


--[[ Create an array of indices for both straight and curved ]]
all_ind = {}
for i = 1, (#sym + #nonsym) do
  all_ind[i] = i
end

--[[ Randomly sort all indices ]]
all_ind = lib.math.random_shuffle(all_ind)

stampa = 9 + math.random(#all_ind - 13)

--[[ Repack in one big randomly sorted array ]]
all = {}
results = ""

ch = math.random(2)

for i = 1, stampa do

  if i > 1 then
    results = results .. " && "
  end
  results = results .. "result[" .. tostring(i-1) .. "] == "
  if (ch == 1) then
	  if all_ind[i] <= #sym then
		all[i] = sym[all_ind[i]]
		results = results .. "1"
	  else
		all[i] = nonsym[all_ind[i] - #sym]
		results = results .. "0"
	  end
   else	  
	  if all_ind[i] <= #nonsym then
		all[i] = nonsym[all_ind[i]]
		results = results .. "1"
	  else
		all[i] = sym[all_ind[i] - #nonsym]
		results = results .. "0"
	  end  
    end	  
end


mycanvas = function(all, results)
  lib.start_canvas(300, 350, "center", results)

  out = math.floor(stampa/5)
  rest = stampa - 5*out
  if (rest ~= 0) then
     out = out + 1
  end

  w = 50
  ow = 20
  x = w - ow    --[[+ offset]]--
  y = 3*ow/2

  i = 0
  for j = 1, out do
      ly = y + (j-1) * (w + ow)
      max = 5
      if (j == out and rest ~= 0) then
          max = rest
      end
      for k = 1, max do
          i = i + 1
          lx = x + (k-1)*(w + ow/2)
          lib.add_text(lx, ly, all[i], text_style, false, true)
      end
  end

  lib.end_canvas()
end  
