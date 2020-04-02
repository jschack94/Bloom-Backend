class RelationshipSerializer < ActiveModel::Serializer
  attributes :id, :mentor, :mentee, :accepted, :created_at

  belongs_to :mentee, class_name: "User"
  belongs_to :mentor, class_name: "User"
  has_many :messages
end
