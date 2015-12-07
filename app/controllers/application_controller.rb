class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
 
  layout :layout_by_resource

  def after_sign_in_path_for(resource)
      authenticated_root_path
  end

  protected

  def layout_by_resource
    if devise_controller?
      "members"
    else
      "application"
    end
  end

  def get_ip_info(user) 
    user_info = get_http_request($config["ip_config"]+"#{params["ip_address"]}")
    user.set_user_info(user_info)
  end

  def get_http_request(url,ssl=false)
    parsed_url = URI.parse(url)
    http = Net::HTTP.new(parsed_url.host, parsed_url.port)
    req = Net::HTTP::Get.new(parsed_url.to_s,initheader={})
    http.use_ssl = ssl
    response = http.request(req)
    JSON.parse response.body rescue ""
  end
end
