require './lib/hue_service'

hs = HueService.new
hs.refresh_lights

# hs.color_lights_loop

hs.color_lights_end_loop
