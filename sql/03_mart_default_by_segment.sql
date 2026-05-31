CREATE TABLE mart_default_by_segment AS
SELECT
    grade,
    dti_bucket,
    income_band,
    COUNT(*) AS total_loans,
    SUM(is_default) AS total_defaults,
    ROUND(AVG(is_default) * 100, 2) AS default_rate_pct,
    ROUND(AVG(int_rate), 2) AS avg_interest_rate,
    ROUND(AVG(loan_amnt), 2) AS avg_loan_amount,
    ROUND(AVG(dti), 2) AS avg_dti
FROM staging_loans
GROUP BY grade, dti_bucket, income_band;
