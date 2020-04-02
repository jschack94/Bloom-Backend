class LocationSerializer < ActiveModel::Serializer
  has_many :users

  attributes :city, :state, :country
end