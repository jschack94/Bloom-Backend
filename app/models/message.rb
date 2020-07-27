class Message < ApplicationRecord
    belongs_to :connection
    belongs_to :user
  end