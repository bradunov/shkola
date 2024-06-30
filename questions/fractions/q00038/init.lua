
include("terms")
include("names")

index_ime = math.random(#musko_ime_nom);    
ime = musko_ime_nom[index_ime];                   
padez = musko_ime_gen[index_ime]; 

deo = math.random(6) + 3;
put1 = 2 + math.random(deo - 3);
put2 = put1 * (deo - 1);
put = put1 + put2

vreme = put2 * 6;

sat = math.floor(vreme/60)
minut = vreme - sat * 60

meas = meas_arr[1]

if (lang == 2) then
	if (sat == 0 or sat > 4 ) then
		meas = meas_arr[1]
	else
		if (sat == 1) then
			meas = meas_arr[2]
		else
			if (sat == 2) then
				meas = meas_arr[3]
			else
				meas = meas_arr[4]	
			end					
		end
	end
else
	if (sat > 0 and sat < 5 ) then
		if (sat == 1) then
			meas = meas_arr[2]
		else
			meas = meas_arr[3]
		end
	else
		meas = meas_arr[1]
	end
end	