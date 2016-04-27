module Api
  class BaseController < ActionController::Base
    acts_as_token_authentication_handler_for User

    # Skips some default Rails controller behaviors
    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    before_action :destroy_session

    # API will only respond with JSON
    respond_to :json

    protected

    def destroy_session
      request.session_options[:skip] = true
    end
  end
end