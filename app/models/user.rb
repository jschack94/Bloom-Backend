#may HAVE TO FIX THIS DOWN THE ROAD. STRIVE TO UNDERSTAND

class User < ApplicationRecord
    has_secure_password
    validates :email_address, {presence: true, uniqueness: true}
    validates :password, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
  
    belongs_to :location
  
    has_many :connections, -> { where(accepted: true) }, class_name:  "Connection",
                                  foreign_key: "mentee_id",
                                  dependent:   :destroy
    has_many :connections, -> { where(accepted: true) }, class_name:  "Connection",
                                  foreign_key: "mentor_id",
                                  dependent:   :destroy
    has_many :mentors, through: :connections,
                                  dependent:   :destroy
    has_many :mentees, through: :connections,
                                  dependent:   :destroy
  
    has_many :messages, through: :connections,
                                  dependent:   :destroy
   
  
    has_many :received_notifications, class_name:  "Notification",
                                  foreign_key: "recipient_id",
                                  dependent:   :destroy
    has_many :sent_notifications, class_name:  "Notification",
                                  foreign_key: "sender_id",
                                  dependent:   :destroy
  end