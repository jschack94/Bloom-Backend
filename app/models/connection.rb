class Connection < ApplicationRecord
    belongs_to :mentee, class_name: "User"
    belongs_to :mentor, class_name: "User"
    has_many :messages,
                                  dependent:   :destroy
    validates :mentee_id, presence: true
    validates :mentor_id, presence: true
  end
