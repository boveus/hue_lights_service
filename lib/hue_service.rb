require 'yaml'
require 'pry'
require 'httparty'
require './lib/light'
require './lib/api_helper'
class HueService
  include ApiHelper
  def initialize
    @active_lights = []
    @color_lights = []
  end

  def all_lights
    HTTParty.get("#{root_url}/lights").body
  end

  def lights_json
    JSON.parse(all_lights)
  end

  def refresh_lights
    @active_lights = []
    @color_lights = []
    lights_json.each do |light|
      id = light.first
      state = light.last["state"]
      light = Light.new(id, state, true)
      @active_lights << light
      if light.color_light?
        @color_lights << light
      end
    end
  end

  def color_lights_randomize_color
    @color_lights.each(&:randomize_color)
  end

  def color_lights_loop
    @color_lights.each(&:colorloop)
  end

  def color_lights_end_loop
    @color_lights.each(&:end_colorloop)
  end

  def set_brightness_all_lights(amount)
    @active_lights.each { |light| light.set_brightness(amount) }
  end

  def turn_on_all_lights
    @active_lights.each(&:turn_on)
  end

  def turn_off_all_lights
    @active_lights.each(&:turn_off)
  end
end
