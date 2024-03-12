import React, { useEffect, useState } from "react";

export default () => {
  // List of fetched companies
  const [companies, setCompanies] = useState([]);

  // Table filters
  const [companyName, setCompanyName] = useState("");
  const [industry, setIndustry] = useState("");
  const [minEmployee, setMinEmployee] = useState("0");
  const [minimumDealAmount, setMinimumDealAmount] = useState("0");

  const addQueryKeyToParams = (params) => {
    return Object.fromEntries(
      Object.entries(params).map(([key, value]) => {
        return [`query[${key}]`, value];
      })
    );
  }

  const queryParams = () => {
    return {
      employee_count: minEmployee,
      industry: industry,
      name: companyName,
      total_deal_amount: minimumDealAmount
    }
  }

  // Fetch companies from API
  useEffect(() => {
    const fetchCompanies = setTimeout(
      async () => {
        const url = `/api/v1/companies?${new URLSearchParams(addQueryKeyToParams(queryParams())).toString()}`;
        const response = await fetch(url);
        const json = await response.json();
        setCompanies(json);
      }, 500
    )

    return () => clearTimeout(fetchCompanies);
  }, [companyName, industry, minEmployee, minimumDealAmount]);

  return (
    <div className="vw-100 primary-color d-flex align-items-center justify-content-center">
      <div className="jumbotron jumbotron-fluid bg-transparent">
        <div className="container secondary-color">
          <h1 className="display-4">Companies</h1>

          <label htmlFor="company-name">Company Name</label>
          <div className="input-group mb-3">
            <input type="text" className="form-control" id="company-name" value={companyName} onChange={e => setCompanyName(e.target.value)} />
          </div>

          <label htmlFor="industry">Industry</label>
          <div className="input-group mb-3">
            <input type="text" className="form-control" id="industry" value={industry} onChange={e => setIndustry(e.target.value)} />
          </div>

          <label htmlFor="min-employee">Minimum Employee Count</label>
          <div className="input-group mb-3">
            <input type="number"
                   min="0"
                   className="form-control"
                   id="min-employee"
                   value={minEmployee}
                   onChange={e => setMinEmployee(e.target.value)}
            />
          </div>

          <label htmlFor="min-amount">Minimum Deal Amount</label>
          <div className="input-group mb-3">
            <input type="number"
                   min="0"
                   className="form-control"
                   id="min-amount"
                   value={minimumDealAmount}
                   onChange={e => setMinimumDealAmount(e.target.value)}
            />
          </div>

          <table className="table">
            <thead>
              <tr>
                <th scope="col">Name</th>
                <th scope="col">Industry</th>
                <th scope="col">Employee Count</th>
                <th scope="col">Total Deal Amount</th>
              </tr>
            </thead>
            <tbody>
              {companies.map((company) => (
                <tr key={company.id}>
                  <td>{company.name}</td>
                  <td>{company.industry}</td>
                  <td>{company.employee_count}</td>
                  <td>{company.deals.reduce((sum, deal) => sum + deal.amount, 0)}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  )
};
