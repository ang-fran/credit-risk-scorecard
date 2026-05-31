CREATE TABLE mart_vintage AS
SELECT
    SUBSTR(issue_d, 5) AS issue_year,  -- grabs everything after 'Apr-' → '2015'
    grade,
    COUNT(*) AS total_loans,
    SUM(is_default) AS defaults,
    ROUND(SUM(is_default) * 100.0 / COUNT(*), 2) AS default_rate_pct
FROM staging_loans
WHERE issue_d IS NOT NULL
GROUP BY SUBSTR(issue_d, 5), grade
ORDER BY issue_year, grade;
