class Api::V1::CompaniesController < ApplicationController
  def index
    companies = Company.all
    name_filter = company_params.dig(:query, :name)
    companies = companies.filter_by_name(name_filter) if name_filter.present?
    companies.order(created_at: :desc)
    render json: companies.as_json(include: :deals)
  end

  private

  def company_params
    params.permit(
      query: [:name]
    )
  end
end
