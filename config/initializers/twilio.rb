require 'twilio-ruby'

# put your own credentials here
account_sid = 'AC93ef287645158afd24f3f70dccf569cc'
auth_token = 'b76e75a272b52d8dff9e3ac49dff555a'

# set up a client to talk to the Twilio REST API
TwilioClient = Twilio::REST::Client.new account_sid, auth_token 