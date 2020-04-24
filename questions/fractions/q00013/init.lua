--[[ @h1@ Osvetlite \(\frac{1}{2}\) svih krugova na razlicite nacine  @/h1@   ]]--


style = {["width"] = 100,
        ["height"] = 100,
        ["ratio"] = 0.4,
	["color"] = "aaf"};


solution = ""
for i = 0, 11 do
  if i < 6 then
    solution = solution.."solution["..tostring(i).."]=1;"
  else
    solution = solution.."solution["..tostring(i).."]=0;"
  end
end

