require './lib/hue_service'

hs = HueService.new
loop do
  hs.random_light_do(['turn_off', 'turn_on'], 2)
end

# Light methods
# color lights
  # randomize_color
  # color_lights_loop
  # color_lights_end_loop
# turn_on
# turn_off
