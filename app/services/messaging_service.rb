class MessagingService
  def initialize(params={})
    @mobile = params[:mobile]
    @message = params[:message]
  end

  def send_message
    begin
      external_message_service.create message_attributes
    rescue
      false
    end
  end

  private

  attr_reader :mobile, :message

  def external_message_service
    TwilioClient.account.messages
  end

  def message_attributes
    {
      :from => '+12028998148', 
      :to => "+91#{mobile}", 
      :body => message,  
    }
  end
end
