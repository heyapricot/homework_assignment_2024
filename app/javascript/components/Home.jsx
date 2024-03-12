import React, { useEffect, useState } from "react";
import CompanyTable from "./CompanyTable";
import CompanyFilters from "./CompanyFilters";
export default () => {
  // List of fetched companies
  const [companies, setCompanies] = useState([]);
  const [filters, setFilters] = useState({
    companyName: "",
    industry: "",
    minEmployee: "0",
    minimumDealAmount: "0"
  });

  const addQueryKeyToParams = (params) => {
    return Object.fromEntries(
      Object.entries(params).map(([key, value]) => {
        return [`query[${key}]`, value];
      })
    );
  }

  const mapFilterToQueryParams = ({ minEmployee, industry, companyName, minimumDealAmount }) => {
    return {
      employee_count: minEmployee,
      industry: industry,
      name: companyName,
      total_deal_amount: minimumDealAmount
    }
  }

  const handleFilterChange = (newFilters) => {
    setFilters(newFilters);
  }

  // Fetch companies from API
  useEffect(() => {
    const headers = new Headers();
    headers.append("Authorization", "cb7615e298dd72441263f958e1306be1185fdff8");

    const fetchCompanies = setTimeout(
      async () => {
        const url = `/api/v1/companies?${new URLSearchParams(
          addQueryKeyToParams(mapFilterToQueryParams(filters))
        ).toString()}`;
        const response = await fetch(url, { headers });
        const json = await response.json();
        setCompanies(json);
      }, 500
    )

    return () => clearTimeout(fetchCompanies);
  }, [filters]);

  return (
    <div className="vw-100 primary-color d-flex align-items-center justify-content-center">
      <div className="container secondary-color">
        <CompanyFilters filters={filters} onInputChange={handleFilterChange}/>
        <CompanyTable companies={companies}/>
      </div>
    </div>
  )
};
