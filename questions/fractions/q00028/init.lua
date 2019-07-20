imenilac = 5
brojilac = math.random(imenilac-1)
min_orig = (60 * brojilac) / imenilac
min = min_orig + math.random(10) - 5
if (min_orig == min) then
  znak = "="
else
  if (min > min_orig) then
    znak = ">"
  else
    znak = "<"
  end
end
