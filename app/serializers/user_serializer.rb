class UserSerializer < ActiveModel::Serializer
  belongs_to :location


  has_many :messages, through: :connections
 

  has_many :received_notifications, class_name:  "Notification",
                                foreign_key: "recipient_id",
                                dependent:   :destroy
  has_many :sent_notifications, class_name:  "Notification",
                                foreign_key: "sender_id",
                                dependent:   :destroy

  attributes :id, :email_address, :mentor_status, :first_name, :last_name, :profile_pic, :job_title, :expertiseArray, :bio, :linkedin, :github, :personal_website, :will_buy_coffee
end