class Api::V1::ConnectionsController < ApplicationController

  skip_before_action :authorized, only: [:index, :create, :update, :destroy]

  def index
    @connections = Connection.all
    render json: @connections
  end

  def create
    @connection = Connection.create(connection_params)
    if @connection.valid?
      @notification = Notification.create(sender_id: connection_params[:mentee_id], recipient_id: connection_params[:mentor_id], text: "mentorship request")
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        NotificationSerializer.new(@notification)
      ).serializable_hash
      ActionCable.server.broadcast 'notifications_channel', serialized_data
      render json: { connection: ConnectionSerializer.new(@connection) }, status: :created
    else
      render json: { error: 'failed to create connection' }, status: :not_acceptable
    end
  end

  def update
    @connection = Connection.find_by(mentor_id: connection_params[:mentor_id], mentee_id: connection_params[:mentee_id])
    @connection.update(accepted: connection_params[:accepted])
    if @connection.valid?
      @request_notification = Notification.find_by(sender_id: connection_params[:mentee_id], recipient_id: connection_params[:mentor_id], text: "mentorship request")
      @request_notification.destroy
      @accept_notification = Notification.create(sender_id: connection_params[:mentor_id], recipient_id: connection_params[:mentee_id], text: "mentorship accepted")
      serialized_data = ActiveModelSerializers::Adapter::Json.new(
        NotificationSerializer.new(@accept_notification)
      ).serializable_hash
      ActionCable.server.broadcast 'notifications_channel', serialized_data
      render json: @connection, status: :accepted
    else
      render json: { error: 'failed to update connection' }, status: :not_acceptable
    end
  end

  def destroy
    @connection = Connection.find_by(mentor_id: connection_params[:mentor_id], mentee_id: connection_params[:mentee_id])
    @notification = Notification.find_by(sender_id: connection_params[:mentee_id], recipient_id: connection_params[:mentor_id], text: "mentorship request")
    @connection.destroy
    @notification.destroy
  end

  private
  def connection_params
    params.require(:connection).permit(:mentee_id, :mentor_id, :accepted)
  end

end