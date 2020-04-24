style = {["width"] = 250,
        ["height"] = 100,
        ["ratio"] = 0.3,
	["color"] = "aaf"};


solution = ""
for i = 0, 5 do
  if i < 2 then
    solution = solution.."solution["..tostring(i).."]=1;"
  else
    solution = solution.."solution["..tostring(i).."]=0;"
  end
end
  