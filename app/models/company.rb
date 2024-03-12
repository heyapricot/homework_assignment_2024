class Company < ApplicationRecord
  has_many :deals

  scope :filter_by_name, ->(name) { where("LOWER(companies.name) like ?", "%#{name.downcase}%") }
  scope :filter_by_industry, ->(industry) { where("LOWER(industry) like ?", "%#{industry.downcase}%") }
  scope :filter_by_employee_count, ->(quantity) { where("employee_count >= ?", quantity) }
  scope :filter_by_total_deal_amount_sum, ->(amount) {
    left_outer_joins(:deals)
      .group("companies.id")
      .having("IFNULL(SUM(deals.amount), 0) >= ?", amount)
  }

  scope :filter_query, ->(employee_count: 0, industry: "", name: "", total_deal_amount: 0) {
    filter_by_industry(industry)
      .filter_by_name(name)
      .filter_by_employee_count(employee_count)
      .filter_by_total_deal_amount_sum(total_deal_amount)
  }
end
