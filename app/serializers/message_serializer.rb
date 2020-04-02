  
class MessageSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :relationship_id, :text, :created_at

  belongs_to :relationship
  belongs_to :user
end
