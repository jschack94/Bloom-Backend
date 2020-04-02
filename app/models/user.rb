class User < ApplicationRecord
    has_secure_password
    validates :email_address, {presence: true, uniqueness: true}
    validates :password_digest, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
  
    belongs_to :location
  
    has_many :active_relationships, -> { where(accepted: true) }, class_name:  "Relationship",
                                  foreign_key: "mentee_id",
                                  dependent:   :destroy
    has_many :passive_relationships, -> { where(accepted: true) }, class_name:  "Relationship",
                                  foreign_key: "mentor_id",
                                  dependent:   :destroy
    has_many :mentors, through: :active_relationships,
                                  dependent:   :destroy
    has_many :mentees, through: :passive_relationships,
                                  dependent:   :destroy
  
    has_many :messages, through: :active_relationships,
                                  dependent:   :destroy
    has_many :messages, through: :passive_relationships,
                                  dependent:   :destroy
  
    has_many :received_notifications, class_name:  "Notification",
                                  foreign_key: "recipient_id",
                                  dependent:   :destroy
    has_many :sent_notifications, class_name:  "Notification",
                                  foreign_key: "sender_id",
                                  dependent:   :destroy
  end