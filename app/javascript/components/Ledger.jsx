import React, { useState } from 'react';
import LedgerTable from './LedgerTable';

const Ledger = () => {
  const [ledgerType, setLedgerType] = useState('complicated');

  const handleLedgerTypeChange = (event) => {
    setLedgerType(event.target.value);
  };

  return (
    <div className="container-fluid">
      <div className="title-bar">
        <h1>Investing Account</h1>
        <div>
          <select
            className="form-control"
            value={ledgerType}
            onChange={handleLedgerTypeChange}
          >
            <option value="simple">Simple</option>
            <option value="complicated">Complicated</option>
            <option value="duplicate">Duplicate</option>
          </select>
        </div>
      </div>
      <LedgerTable ledgerType={ledgerType} />
    </div>
  );
};

export default Ledger;
