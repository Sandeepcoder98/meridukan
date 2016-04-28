class Api::AuthenticationController < Api::BaseController
    acts_as_token_authentication_handler_for User
end
