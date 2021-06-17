
meas = {"\(^\circ\)", "cm"}

temp = 5 + math.random(17)
edge_c = 2 * temp
edge_m = temp + math.random(70 - temp)

edge_a = edge_m + temp
edge_b = edge_m - temp

circ = 2 * (edge_m + edge_c)
       