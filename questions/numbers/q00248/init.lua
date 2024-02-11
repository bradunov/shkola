
include("terms")

weight = math.random(6);
if (weight == 1) then
    meas_g = name[1]
else
    meas_g = name[2]
end	
if (weight == 1 or weight > 4) then
	meas_t = name[3]
else
	meas_t = name[4]
end	
totl_kg = 1000*weight
totl_t = weight              
