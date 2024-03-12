class Api::V1::CompaniesController < ApplicationController
  def index
    companies.order(created_at: :desc)
    render json: companies.as_json(include: :deals)
  end

  def companies
    @companies ||= Company.filter_query(**filter_hash)
      .order(created_at: :desc)
  end

  private

  def company_params
    params.permit(
      query: [:industry, :name]
    )
  end

  def filter_hash
    {
      industry: "",
      name: ""
    }.merge(
      company_params[:query] || {}
    ).symbolize_keys
  end
end
