class Company < ApplicationRecord
  has_many :deals

  scope :filter_by_name, ->(name) { where("LOWER(name) like ?", "%#{name.downcase}%") }
  scope :filter_by_industry, ->(industry) { where("LOWER(industry) like ?", "%#{industry.downcase}%") }
  scope :filter_query, ->(industry: "", name: "") {
    filter_by_industry(industry).filter_by_name(name)
  }
end
