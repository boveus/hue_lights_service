module ApiHelper
  def settings
    YAML.load_file('config.yml')
  end
  
  def root_url
    "http://#{settings['bridge_ip']}/api/#{settings['username']}"
  end
end
