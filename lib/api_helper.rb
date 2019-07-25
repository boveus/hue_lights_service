module ApiHelper
  def settings
    YAML.load_file('config.yml')
  end

  def root_url
    "http://#{settings['bridge_ip']}/api/#{settings['username']}"
  end

  def get_all_lights
    HTTParty.get("#{root_url}/lights").body
  end

  def all_lights_json
    JSON.parse(get_all_lights)
  end
end
