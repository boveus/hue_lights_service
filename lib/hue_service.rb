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
    refresh_lights
  end

  def refresh_lights
    all_lights_json.each do |json|
      light = light_from_json(json)
      add_to_lights(light)
    end
  end

  def add_to_lights(light)
    @active_lights << light
    if light.color_light?
      @color_lights << light
    end
  end

  def light_from_json(light)
    id = light.first
    state = light.last["state"]
    Light.new(id, state)
  end

  def all_color_lights_do(method)
    @color_lights.each { |light| light.send(method) }
  end

  def all_lights_do(method)
    @active_lights.each { |light| light.send(method) }
  end

  def random_light_do(methods, sleep_between=0)
    light = @active_lights.sample
    light.send(methods[0])
    sleep sleep_between
    light.send(methods[1])
  end

  def set_brightness_all_lights(amount)
    @active_lights.each { |light| light.set_brightness(amount) }
  end
end
