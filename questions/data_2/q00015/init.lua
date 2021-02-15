        
fact =  2 + math.random(3);
tree = (20 + math.random(60-fact*10)) * 0.1
school = fact * tree

mod_tree = 2 + math.random(6-fact)
mod_school = fact * mod_tree   

temp = math.floor(mod_school/10)
if (temp > 0) then
    mod_school = lib.math.round_dec(mod_school/10,1)
    mes = "m"
else
    mes = "dm"
end

out_t = lib.dec_to_str(lib.math.round_dec(tree , 1))      
out_s = lib.dec_to_str(lib.math.round_dec(school , 1))         
      

