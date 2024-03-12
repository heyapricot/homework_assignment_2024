class Company < ApplicationRecord
  has_many :deals

  scope :filter_by_name, ->(name) { where("LOWER(name) like ?", "%#{name.downcase}%") }
end
