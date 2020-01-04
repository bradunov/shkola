text_style = 
	{["off_color"] = "000",
        ["on_color"] = "f00",
        ["line_color"] = "f00",
        ["off_line_color"] = "000",
        ["line_width"] = "3",
	["font_size"] = "24"};


--[[
check_style = 
	{["off_color"] = "fff",
        ["on_color"] = "fff",
        ["line_color"] = "f00",
        ["off_line_color"] = "000",
        ["line_width"] = "2"};
]]--


straight = {"M", "Г", "Е", "Ш", "Х" , "А", "П", "Т", "И"}
curved = {"Ф", "Б", "Ч", "О", "Њ", "Р", "В", "С", "У"}

izbor = math.random(2)
results = ""
if (izbor == 1) then
   solution = strait
   name = "samo pravim"
   rstraight = "1"
   rcurved = "0"
else
   solution = curved
   name = "i krivim"
   rstraight = "0"
   rcurved = "1"
end   



--[[ Create an array of indices for both straight and curved ]]
all_ind = {}
for i = 1, (#straight + #curved) do
  all_ind[i] = i
end



--[[ Randomly sort all indices ]]
all_ind = lib.math.random_shuffle(all_ind)



--[[ Repack in one big randomly sorted array ]]
all = {}
all_resp = {}
for i = 1, #all_ind do

  if i > 1 then
    results = results .. " && "
  end
  results = results .. "result[" .. tostring(i-1) .. "] == "

  if all_ind[i] <= #straight then
    all[i] = straight[all_ind[i]]
    all_resp[i] = 0
    results = results .. rstraight
  else
    all[i] = curved[all_ind[i] - #straight]
    all_resp[i] = 1
    results = results .. rcurved
  end
end






mycanvas = function(all, results)
  lib.start_canvas(300, 100, "center", results)

  w = 30
  x = w/2 + 5
  y = w/2 + 5
  ow = 15
  for i = 1, #all do
    --[[
      lib.add_text(x + (i-1)*w, y, all[i], text_style, true, false)
      lib.add_check_box(x + (i-1)*w - (w-ow)/2, y + w, ow, ow, check_style, false, true) 
    ]]
    if i > #all/2 then
      lx = x + (i-1-#all/2)*(w+2)
      ly = y + w + 10
    else
      lx = x + (i-1)*(w+2)
      ly = y
      end
    lib.add_text(lx, ly, all[i], text_style, false, true)
   end

  lib.end_canvas()
end
