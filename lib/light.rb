require 'yaml'
require './lib/api_helper'

class Light
  include ApiHelper
  attr_reader :id,
              :status,
              :bri,
              :reachable

  def initialize(id, state)
    @id = id
    @on = state['on']
    @bri = state['bri']
    @reachable = state['reachable']
  end

  def modify(state)
    HTTParty.put("#{root_url}/lights/#{@id}/state", body: state.to_json)
  end

  def set_brightness(amount)
    @bri = amount
    modify({"bri": amount})
  end

  def turn_off
    @on = false
    modify({"on":false})
  end

  def turn_on
    @on = true
    modify({"on":true})
  end
end
