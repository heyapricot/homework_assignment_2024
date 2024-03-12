require "rails_helper"

RSpec.describe "Api::V1::Companies", type: :request do
  describe "GET /api/v1/companies" do
    before { get api_v1_companies_path }

    it "returns a successful response" do
      expect(response).to have_http_status(:ok)
    end

    describe "filtering" do
      let!(:companies) { create_list(:company, 5) }

      describe "filtering by name" do
        let(:selected) { companies.sample }
        let(:unselected) { companies - [selected] }

        before { get api_v1_companies_path, params: {query: {name: selected.name}} }

        let(:expected_data) do
          [
            a_hash_including(
              "id" => selected.id,
              "name" => selected.name,
              "employee_count" => selected.employee_count,
              "industry" => selected.industry
            )
          ]
        end

        let(:unexpected_data) do
          unselected.map do |company|
            a_hash_including(
              "id" => company.id,
              "name" => company.name,
              "employee_count" => company.employee_count,
              "industry" => company.industry
            )
          end
        end

        let(:json_response) { JSON.parse(response.body) }

        it "returns the companies that match the name" do
          expect(json_response).to include(*expected_data)
        end

        it "does not return companies that do not match the name" do
          expect(json_response).not_to include(*unexpected_data)
        end
      end

      describe "filtering by industry" do
        let(:industry) { companies.map(&:industry).sample }
        let(:selected) { companies.select { |company| company.industry == industry } }
        let(:unselected) { companies.reject { |company| company.industry == industry } }

        before { get api_v1_companies_path, params: {query: {industry:}} }

        let(:expected_data) do
          selected.map do |company|
            a_hash_including(
              "id" => company.id,
              "name" => company.name,
              "employee_count" => company.employee_count,
              "industry" => company.industry
            )
          end
        end

        let(:unexpected_data) do
          unselected.map do |company|
            a_hash_including(
              "id" => company.id,
              "name" => company.name,
              "employee_count" => company.employee_count,
              "industry" => company.industry
            )
          end
        end

        let(:json_response) { JSON.parse(response.body) }

        it "returns the companies that match the industry" do
          expect(json_response).to include(*expected_data)
        end

        it "does not return companies that do not match the industry" do
          expect(json_response).not_to include(*unexpected_data)
        end
      end

      describe "filtering by minimum employee count" do
        let(:threshold) { companies.map(&:employee_count).sample }
        let(:selected) { companies.select { |company| company.employee_count >= threshold } }
        let(:unselected) { companies.reject { |company| company.employee_count >= threshold } }

        before { get api_v1_companies_path, params: {query: {employee_count: threshold}} }

        let(:expected_data) do
          selected.map do |company|
            a_hash_including(
              "id" => company.id,
              "name" => company.name,
              "employee_count" => company.employee_count,
              "industry" => company.industry
            )
          end
        end

        let(:unexpected_data) do
          unselected.map do |company|
            a_hash_including(
              "id" => company.id,
              "name" => company.name,
              "employee_count" => company.employee_count,
              "industry" => company.industry
            )
          end
        end

        let(:json_response) { JSON.parse(response.body) }

        it "returns the companies with an employee count higher or equal to the param" do
          expect(json_response).to include(*expected_data)
        end

        it "does not return companies with an employee count lower than the param" do
          expect(json_response).not_to include(*unexpected_data)
        end
      end
    end
  end
end
