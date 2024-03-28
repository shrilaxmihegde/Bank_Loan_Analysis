--- Create a Table--
select * from Bank_loan_data

---Total Loan aplication
select COUNT(id) as Total_Loan from Bank_loan_data

--- Total number of aplication month to date;
select COUNT(id) as MTD_Total_Loan from Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 

SELECT * from Bank_loan_data WHERE MONTH(issue_date) = 12

--TRUNCATE TABLE Bank_loan;
--DELETE Bank_loan;

----MOM (month to month loan aplication)
select COUNT(id) as PMTD_Total_Loan from Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 

---Total funded amount---
select sum(loan_amount) as Total_Funded_Amount from Bank_loan_data

---Month to date total funded amount
select sum(loan_amount) as MTD_Total_Funded_Amount from Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

---Previous month to date--
select sum(loan_amount) as PMTD_Total_Funded_Amount from Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--- Total amont recived--
SELECT SUM(total_payment) as Total_Amount_Recieved from Bank_loan_data

--- Month to date total payment--
SELECT SUM(total_payment) as MTD_Total_Amount_Recieved from Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

---Previous Month to date total payment--
SELECT SUM(total_payment) as PMTD_Total_Amount_Recieved from Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


--- Avg Interest Rate---
select ROUND (Avg (int_rate),4) * 100 AS Avg_int_rate from Bank_loan_data
---Month to date inrest rate--
select ROUND (Avg (int_rate),4) * 100 AS MDT_Avg_int_rate from Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

---Previous month to date--
select ROUND (Avg (int_rate),4) * 100 AS PMDT_Avg_int_rate from Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021


-----Avrage date to incomr ratio(DTI)--(Month to date)---
SELECT ROUND (AVG(dti), 4) * 100 AS MTD_AVG_DTI from Bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--- Previous month to date DTI---
SELECT ROUND (AVG(dti), 4) * 100 AS PMTD_AVG_DTI from Bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

----good loan application percentage --
SELECT
      (COUNT(CASE WHEN loan_status = 'Fully paid' OR  loan_status = 'Current' THEN id END) * 100)
	  /
	  COUNT(id) As Good_Loan_Percentage from Bank_loan_data

---- Good loan applications--
select Count(id) AS Good_loan_application from Bank_loan_data
where loan_status = 'Fully paid' OR  loan_status = 'Current'

----Good Loan funded Amount--
select SUM(loan_amount) AS Good_loan_Funded_amount from Bank_loan_data
where loan_status = 'Fully paid' OR  loan_status = 'Current'

---Good Loan Total recived Amount--
select SUM(total_payment) AS Good_loan_recived_amount from Bank_loan_data
where loan_status = 'Fully paid' OR  loan_status = 'Current'


----bad loan amont--
SELECT
      (COUNT(CASE WHEN loan_status = 'charged off' THEN id END) * 100.0)
	  /
	  COUNT(id) As Bad_Loan_Percentage from Bank_loan_data

---- Bad loan applications--
select Count(id) AS Bad_loan_application from Bank_loan_data
where loan_status = 'charged off'

----Bad Loan funded Amount--
select SUM(loan_amount) AS Bad_loan_Funded_amount from Bank_loan_data
where loan_status = 'charged off'

---Bad Loan Total recived Amount--
select SUM(total_payment) AS Bad_loan_recived_amount from Bank_loan_data
where loan_status = 'charged off'

---Total Loan staus--
Select
      loan_status,
	  Count(id) as Total_amount_recived,
	  sum(total_payment) as Total_amount_recived,
	  sum(loan_amount) as Total_funded_amount,
	  AVG(int_rate * 100) as Average_interest_rate,
	  AVG(dti * 100) as DTI
    from Bank_loan_data
	GROUP BY
	    loan_status

----month to date how much amount Funded--
select
     loan_status,
     sum(total_payment) as MTD_Total_amount_recived,
	 sum(loan_amount) as MTD_Total_funded_amount
from Bank_loan_data
WHERE MONTH(issue_date) = 12
GROUP BY
	 loan_status

---Monthly Trend issue date--
SELECT
     MONTH(issue_date) as Month_number, 
     DATENAME(MONTH,issue_date) AS Months,
	 Count(id) as Total_loan_application,
     sum(total_payment) as Total_amount_recived,
	 sum(loan_amount) as Total_funded_amount
from Bank_loan_data
GROUP BY MONTH(issue_date),DATENAME(MONTH,issue_date)
ORDER BY MONTH(issue_date)

----Regional analysis by stae--
SELECT
     address_state,
	 Count(id) as Total_loan_application,
     sum(total_payment) as Total_amount_recived,
	 sum(loan_amount) as Total_funded_amount
from Bank_loan_data
GROUP BY address_state
ORDER BY  sum(loan_amount)DESC

----Loan term analysis--
SELECT
     term,
	 Count(id) as Total_loan_application,
     sum(total_payment) as Total_amount_recived,
	 sum(loan_amount) as Total_funded_amount
from Bank_loan_data
GROUP BY term
ORDER BY term 

----Employee length--
SELECT
     emp_length,
	 Count(id) as Total_loan_application,
     sum(total_payment) as Total_amount_recived,
	 sum(loan_amount) as Total_funded_amount
from Bank_loan_data
GROUP BY emp_length
ORDER BY Count(id)DESC


--- Loan Purpose Breakdown--
SELECT
     purpose,
	 Count(id) as Total_loan_application,
     sum(total_payment) as Total_amount_recived,
	 sum(loan_amount) as Total_funded_amount
from Bank_loan_data
GROUP BY purpose
ORDER BY Count(id)DESC

---Home owenership analysis--
SELECT
     home_ownership,
	 Count(id) as Total_loan_application,
     sum(total_payment) as Total_amount_recived,
	 sum(loan_amount) as Total_funded_amount
from Bank_loan_data
WHERE grade = 'A' AND address_state = 'CA'
GROUP BY home_ownership
ORDER BY Count(id)DESC
