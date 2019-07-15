require 'yaml'
require 'pry'
require 'httparty'
require './lib/light'
require './lib/api_helper'
class HueService
  include ApiHelper
  def initialize
    @active_lights = []
  end

  def all_lights
    HTTParty.get("#{root_url}/lights").body
  end

  def lights_json
    JSON.parse(all_lights)
  end

  def refresh_lights
    @active_lights = []
    lights_json.each do |light|
      id = light.first
      state = light.last["state"]
      @active_lights << Light.new(id, state)
    end
  end

  def set_brightness_all_lights(amount)
    @active_lights.each { |light| light.set_brightness(amount) }
  end

  def turn_on_all_lights
    @active_lights.each { |light| light.turn_on }
  end

  def turn_off_all_lights
    @active_lights.each { |light| light.turn_off }
  end
end

hs = HueService.new
hs.refresh_lights
hs.turn_off_all_lights
