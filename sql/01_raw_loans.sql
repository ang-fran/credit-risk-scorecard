SELECT 
    COUNT(*) AS total_rows,
    SUM(CASE WHEN loan_amnt IS NULL THEN 1 ELSE 0 END) AS null_loan_amnt,
    SUM(CASE WHEN annual_inc IS NULL THEN 1 ELSE 0 END) AS null_income,
    SUM(CASE WHEN loan_status IS NULL THEN 1 ELSE 0 END) AS null_status,
    SUM(CASE WHEN dti IS NULL THEN 1 ELSE 0 END) AS null_dti
FROM raw_loans;


DELETE FROM raw_loans WHERE annual_inc IS NULL;

DELETE FROM raw_loans WHERE dti IS NULL;
