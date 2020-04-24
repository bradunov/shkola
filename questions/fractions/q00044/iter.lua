x = arrayX[ITEM]
y = arrayY[ITEM]
type = arrayType[ITEM]
denom = arrayDenom[ITEM]
res = x*y / denom 

style["height"] = height * y / x

solution = ""
for i = 0, (x*y-1) do
  if i < res then
    solution = solution.."solution["..tostring(i).."]=1;"
  else
    solution = solution.."solution["..tostring(i).."]=0;"
  end
end
