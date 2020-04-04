  class MessageSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :connection_id, :text, :created_at

  belongs_to :connection
  belongs_to :user
end
