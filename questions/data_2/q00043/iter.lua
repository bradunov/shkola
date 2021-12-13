
xp = {}
yp = {}
x = {}
y = {}

dim = 8
dim2 = 2 * dim

x[1] = math.random(dim2-1)
y[1] = math.random(dim2-1)

xp[1] = x[1] - dim
yp[1] = dim - y[1]

if (x[1] < dim) then
    difx = 2 + math.random(4)
else
    difx = -2 - math.random(4)	
end	

if (y[1] < dim) then
    dify = 2 + math.random(4)
else
    dify = -2 - math.random(4)	
end	

x[2] = x[1] + difx
y[2] = y[1] + dify
x[3] = x[2] + dify
y[3] = y[2] - difx
x[4] = x[3] - difx
y[4] = y[3] - dify

for i = 1,4 do
    xp[i] = x[i] - dim
    yp[i] = dim - y[i]
end	

            
            