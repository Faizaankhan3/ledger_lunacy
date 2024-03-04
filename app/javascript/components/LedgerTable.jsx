import React, { useState, useEffect } from 'react';

const LedgerTable = ({ ledgerType }) => {
  const [ledgerData, setLedgerData] = useState([]);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchLedger = async () => {
      try {
        const response = await fetch(`/ledgers/1?ledger_type=${ledgerType}`);

        if (!response.ok) {
          throw new Error('Failed to fetch ledger data');
        }

        const data = await response.json();

        setLedgerData(data.ledger);
      } catch (error) {
        setError('Failed to fetch ledger data');
      } finally {
        setLoading(false);
      }
    };

    fetchLedger();
  }, [ledgerType]);

  if (loading) {
    return <></>
  }

  if (error) {
    return <p>Something went wrong</p>
  }

  return (
    <>
      <div className="balance-strip">
        <div className='container'>
          <p>${ledgerData[0]?.balance}</p>
          <span>BALANCE</span>
        </div>
      </div>
      <section className='container'>
        <header>
          <h2 className="page-title">Past Transactions</h2>
        </header>
        <table className="ledger-table">
          <thead>
            <tr>
              <th>Date</th>
              <th>Transaction</th>
              <th>Description</th>
              <th>Amount</th>
              <th>Balance</th>
            </tr>
          </thead>
          <tbody>
            {ledgerData.map((entry, index) => (
              <tr key={index} className={index % 2 !== 0 ? 'ledger-table__row--odd' : ''}>
                <td>{entry.date}</td>
                <td>{entry.transation_type}</td>
                <td>{entry.description}</td>
                <td>{entry.amount}</td>
                <td>{entry.balance}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </section>
    </>
  );
};

export default LedgerTable;
