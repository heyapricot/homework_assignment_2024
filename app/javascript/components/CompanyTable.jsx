import React from "react";

export default ({ companies }) => {
  return (
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
  )
}