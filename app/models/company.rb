class Company < ApplicationRecord
  has_many :deals

  scope :filter_by_name, ->(name) { where("LOWER(name) like ?", "%#{name.downcase}%") }
  scope :filter_by_industry, ->(industry) { where("LOWER(industry) like ?", "%#{industry.downcase}%") }
  scope :filter_by_employee_count, ->(quantity) { where("employee_count >= ?", quantity) }
  scope :filter_query, ->(employee_count: 0, industry: "", name: "") {
    filter_by_industry(industry)
      .filter_by_name(name)
      .filter_by_employee_count(employee_count)
  }
end
