
imenilac = array_denom[ITEM];
brojilac = array_enum[ITEM];
boja = array_boja[ITEM];

sln = ""
for i=0,18 do
  sln = sln.."solution["..i.."]="
  if i < (18*brojilac) / imenilac then
    sln = sln.."1;"
  else
    sln = sln.."0;"
  end
end