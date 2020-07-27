  class Notification < ApplicationRecord
    belongs_to :sender, class_name: "User"
    belongs_to :recipient, class_name: "User"
    validates :sender_id, presence: true
    validates :recipient_id, presence: true
  end