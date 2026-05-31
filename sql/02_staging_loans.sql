CREATE TABLE staging_loans AS
SELECT
    id,
    loan_amnt,
    grade,
    int_rate,
    annual_inc,
    dti,
    delinq_2yrs,
	issue_d,
	purpose,

    CASE
        WHEN loan_status IN ('Charged Off', 'Default', 
             'Does not meet the credit policy. Status:Charged Off')
        THEN 1 ELSE 0 
    END AS is_default,

    CASE 
        WHEN dti < 10 THEN 'Low'
        WHEN dti BETWEEN 10 AND 20 THEN 'Medium'
        WHEN dti BETWEEN 20 AND 35 THEN 'High'
        ELSE 'Very High'
    END AS dti_bucket,

    CASE
        WHEN annual_inc < 40000 THEN '<40K'
        WHEN annual_inc BETWEEN 40000 AND 80000 THEN '40K-80K'
        WHEN annual_inc BETWEEN 80000 AND 120000 THEN '80K-120K'
        ELSE '120K+'
    END AS income_band,

    CASE WHEN delinq_2yrs > 0 THEN 1 ELSE 0 END AS has_delinquency,

    CAST(REPLACE(term, ' months', '') AS INT) AS term_months

FROM raw_loans
WHERE annual_inc > 0 AND loan_amnt > 0;
