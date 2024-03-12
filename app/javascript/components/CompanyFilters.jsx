import React, { useEffect, useState } from "react";
export default (
  {
    filters: {
      companyName = "",
      industry = "",
      minEmployee = "0",
      minimumDealAmount = "0",
    },
    onInputChange }
) => {
  // Table filters
  const [nameInput, setNameInput] = useState(companyName);
  const [industryInput, setIndustryInput] = useState(industry);
  const [minEmployeeInput, setMinEmployeeInput] = useState(minEmployee);
  const [minimumDealAmountInput, setMinimumDealAmountInput] = useState(minimumDealAmount);

  const filters = () => {
    return {
      companyName: nameInput,
      industry: industryInput,
      minEmployee: minEmployeeInput,
      minimumDealAmount: minimumDealAmountInput
    }
  }

  const handleInputChange = () => {
    onInputChange(filters())
  }

  useEffect(() => {
    handleInputChange()
  }, [nameInput, industryInput, minEmployeeInput, minimumDealAmountInput])

  return (
    <>
      <h1 className="display-4">Companies</h1>

      <label htmlFor="company-name">Company Name</label>
      <div className="input-group mb-3">
        <input type="text" className="form-control" id="company-name" value={nameInput}
               onChange={e => {setNameInput(e.target.value)}}
        />
      </div>

      <label htmlFor="industry">Industry</label>
      <div className="input-group mb-3">
        <input type="text" className="form-control" id="industry" value={industryInput}
               onChange={e => {setIndustryInput(e.target.value)}}
        />
      </div>

      <label htmlFor="min-employee">Minimum Employee Count</label>
      <div className="input-group mb-3">
        <input type="number"
               min="0"
               className="form-control"
               id="min-employee"
               value={minEmployeeInput}
               onChange={e => {setMinEmployeeInput(e.target.value)}}
        />
      </div>

      <label htmlFor="min-amount">Minimum Deal Amount</label>
      <div className="input-group mb-3">
        <input type="number"
               min="0"
               className="form-control"
               id="min-amount"
               value={minimumDealAmountInput}
               onChange={e => {setMinimumDealAmountInput(e.target.value)}}
        />
      </div>
    </>
  )
}