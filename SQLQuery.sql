SELECT * FROM bank_loan_data

ALTER TABLE bank_loan_data
ADD PRIMARY KEY (id);


--- KPI

--Total Loan Application
SELECT COUNT(ID) as Total_Applications
FROM bank_loan_data

--MTD Loan Application
SELECT COUNT(id) as Loan_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--PMTD Loan Application
SELECT COUNT(id) as Loan_Applications
FROM bank_loan_data
WHERE MONTH(issue_date) = 11


--Total Funded Amount
SELECT SUM(loan_amount) as Total_Funded_Amount
FROM bank_loan_data

--MTD Funded Amount
SELECT SUM(loan_amount) as Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--PMTD Funded Amount
SELECT SUM(loan_amount) as Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 11


--Total Received Amount
SELECT SUM(total_payment) as Total_Received_Amount
FROM bank_loan_data

--MTD Received Amount
SELECT SUM(total_payment) as Total_Received_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--PMTD Received Amount
SELECT SUM(total_payment) as Total_Received_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 11


--Average Interest Rate
SELECT AVG(int_rate * 100) as Avg_Int_Rate
FROM bank_loan_data

--MTD Average Interest Rate
SELECT AVG(int_rate * 100) as Avg_Int_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--PMTD Average Interest Rate
SELECT AVG(int_rate * 100) as Avg_Int_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 11

--Average DTI(Debt-to-Income) Ratio
SELECT AVG(dti * 100) as Avg_Int_Rate
FROM bank_loan_data

--MTD Average DTI(Debt-to-Income) Ratio
SELECT AVG(dti * 100) as Avg_Int_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--PMTD Average DTI(Debt-to-Income) Ratio
SELECT AVG(dti * 100) as Avg_Int_Rate
FROM bank_loan_data
WHERE MONTH(issue_date) = 11


--Good Loan Issued

--Good Loan Percentage
SELECT (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / COUNT(id) as Good_loan_Percentage
FROM bank_loan_data

--Good Loan Application
SELECT COUNT(id) as Good_loan_application
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good Loan Funded Amount
SELECT SUM(loan_amount) as Good_loan_funded_amount
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Good Loan Recieved Amount
SELECT SUM(total_payment) as Good_loan_recieved_amount
FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--Bad Loan Issued

--Bad Loan Percentage
SELECT (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / COUNT(id) as Bad_loan_Percentage
FROM bank_loan_data

--Bad Loan Application
SELECT COUNT(id) as Bad_loan_application
FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--Bad Loan Funded Amount
SELECT SUM(loan_amount) as Bad_loan_funded_amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--bad Loan Recieved Amount
SELECT SUM(total_payment) as Bad_loan_recieved_amount
FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--Loan Status
SELECT
loan_status,
COUNT(id) AS LoanCount,
SUM(total_payment) AS Total_Amount_Received,
SUM(loan_amount) AS Total_Funded_Amount,
AVG(int_rate * 100) AS Interest_Rate,
AVG(dti * 100) AS DTI
FROM bank_loan_data
GROUP BY loan_status

--Loan status MTD
SELECT
loan_status,
COUNT(id) AS LoanCount,
SUM(total_payment) AS MTD_Total_Amount_Received,
SUM(loan_amount) AS MTD_Total_Funded_Amount
FROM bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY loan_status

--State Analysis
SELECT
      address_state as State,
      COUNT(id) as Total_Loan_Application,
      SUM(loan_amount) as Total_Funded_Amount,
      SUM(total_payment) as Total_REceived_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY address_state

--Loan Term Analysis
SELECT
      term as Term,
      COUNT(id) as Total_Loan_Application,
      SUM(loan_amount) as Total_Funded_Amount,
      SUM(total_payment) as Total_REceived_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term

--Employee Strength Analysis
SELECT
      emp_length AS Employee_Length, 
      COUNT(id) as Total_Loan_Application,
      SUM(loan_amount) as Total_Funded_Amount,
      SUM(total_payment) as Total_REceived_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY emp_length

--Purpose Analysis
SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY purpose
ORDER BY purpose

--Ownership Analysis
SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY home_ownership
ORDER BY home_ownership
