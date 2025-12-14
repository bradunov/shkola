
dist = {}
area = {}

meas = {"km", "cm", "km²", "cm²"}

scale = 0.5 * (4 + math.random(6))
dist[2] = math.random(6)
dist[1] = scale * dist[2]
q = lib.math.gcd(dist[1], dist[2])
dist[1] = dist[1]/q
dist[2] = dist[2]/q

area[2] = 3 + math.random(7)
area[1] = area[2] * scale * scale
