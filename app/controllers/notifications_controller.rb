class NotificationsController < ApplicationController
  skip_before_action :authorized, only: [:create, :update]

  def create
    @notification = Notification.new(notification_params)
    if @notification.save
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        NotificationSerializer.new(@notification)
      ).serializable_hash
      ActionCable.server.broadcast 'notifications_channel', serialized_data
      head :ok
    end
  end



  private
  def notification_params
    params.require(:notification).permit(:id, :sender_id, :recipient_id, :text, :opened)
  end
end