class Api::V1::NotificationsController < ApplicationController
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

  def update
    @notifications = Notification.where(recipient_id: notification_params[:recipient_id])
    @notifications.map{ |notification| notification.update(opened: notification_params[:opened]) }
    if @notifications.map{ |notification| notification.valid? }
      render json: { message: 'updated notifications' }, status: :accepted
    else
      render json: { error: 'failed to update notifications' }, status: :not_acceptable
    end
  end

  private
  def notification_params
    params.require(:notification).permit(:id, :sender_id, :recipient_id, :text, :opened)
  end

end