module Api
  class BaseController < ActionController::Base
    # Skips some default Rails controller behaviors
    protect_from_forgery with: :null_session
    # API will only respond with JSON
    respond_to :json
  end
end