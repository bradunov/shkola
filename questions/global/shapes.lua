  heart = function(lib, x, y, scale, style, initial_state, check)
    lib.add_curved_path(x, y, {{40*scale, -50*scale, 0, -30*scale}}, style, initial_state, check)
    lib.add_curved_path(x, y, {{-40*scale, -50*scale, 0, -30*scale}}, style, initial_state, check)
  end
  
  leaf = function(lib, x, y, scale, style, initial_state, check)
    lib.add_triangle (x, y+40*scale, 5*scale, 20*scale, style, initial_state, check)
    lib.add_curved_path(x, y, {{30*scale, 50*scale, 0, 40*scale}}, style, initial_state, check)
    lib.add_curved_path(x, y, {{-30*scale, 50*scale, 0, 40*scale}}, style, initial_state, check)
  end
  
  cross = function(lib, x, y, scale, style, initial_state, check)
    lib.add_straight_path(x, y, {{15*scale, 0}, {0,-15*scale}, {10*scale,0}, {0,15*scale}, 
              {15*scale,0}, {0,10*scale}, {-15*scale,0}, {0,15*scale}, {-10*scale,0}, 
              {0,-15*scale}, {-15*scale,0}, {0,-10*scale} }, style, initial_state, check)
  end
  
  diamond = function(lib, x, y, scale, style, initial_state, check)
    lib.add_straight_path(x, y, {{15*scale, -5*scale}, {5*scale,-15*scale}, {5*scale,15*scale}, 
              {15*scale,5*scale}, {-15*scale,5*scale}, {-5*scale,15*scale}, {-5*scale,-15*scale}, 
              {-15*scale, -5*scale} }, style, initial_state, check)
  end
  