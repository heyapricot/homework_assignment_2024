class Api::V1::CompaniesController < ApplicationController
  before_action :require_api_token!, only: :index
  before_action :authenticate_request!, only: :index

  def index
    render json: companies.as_json(include: :deals)
  end

  def companies
    @companies ||= Company.filter_query(**filter_hash)
      .order(created_at: :desc)
  end

  private

  def company_params
    params.permit(
      query: [
        :employee_count,
        :industry,
        :name,
        :total_deal_amount
      ]
    )
  end

  def filter_hash
    {
      employee_count: 0,
      industry: "",
      name: "",
      total_deal_amount: 0
    }.merge(
      company_params[:query] || {}
    ).symbolize_keys
  end
end
