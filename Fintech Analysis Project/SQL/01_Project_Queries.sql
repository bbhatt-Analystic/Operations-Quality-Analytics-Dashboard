SELECT
    partner,
    COUNT(*) AS total_audits
FROM cx_audit
GROUP BY partner
ORDER BY total_audits DESC;

SELECT
    partner,
    COUNT(*) AS total_audits
FROM mhd_audit
GROUP BY partner
ORDER BY total_audits DESC;

SELECT
    partner,
    ROUND(AVG(audit_score),2) AS avg_audit_score
FROM cx_audit
GROUP BY partner
ORDER BY avg_audit_score DESC;

SELECT
    partner,
    COUNT(*) AS total_audits,
    SUM(CASE WHEN fatal = 'Yes' THEN 1 ELSE 0 END) AS fatal_cases,
    ROUND(
        100.0 * SUM(CASE WHEN fatal = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fatal_percentage
FROM cx_audit
GROUP BY partner
ORDER BY fatal_percentage DESC;

SELECT
    MIN(transaction_date),
    MAX(transaction_date)
FROM cx_audit;