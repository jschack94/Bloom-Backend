class Message < ApplicationRecord
  belongs_to :relationship
  belongs_to :user
end