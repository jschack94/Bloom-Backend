class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :text, :recipient, :sender, :opened, :created_at

  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
end