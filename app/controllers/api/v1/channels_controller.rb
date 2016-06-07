class Api::V1::ChannelsController <  Api::BaseController 
  
  respond_to :json
  def create
    user = User.find(params[:user_id])
    if user.present? 
      if !channel_present.present?
        user.channels.create(channel_params)
        render :json=> { status: true, message: 'create channel successfully' }, :status=>201
      else
        channel_present.update_attributes(channel_params)
        render :json=> { status: true, message: 'update channel successfully' }, :status=>201 
      end
    else
      render :json=> { status: false, message: "User not present in database"}, :status=>422
    end
      
  end

  private

  def channel_params
    params.require(:channel).permit(:channel, :os)
  end

  def channel_present
    channel = Channel.find_by_channel_and_os(channel_params[:channel], channel_params[:os])
  end

end
