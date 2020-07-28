class MessagesChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # relationship = Relationship.find(params[:id])
    # stream_for relationship
    stream_from "messages_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end