SELECT
    lob,
    COUNT(*) AS total_audits,
    ROUND(AVG(audit_score),2) AS avg_score,
    SUM(CASE WHEN fatal='Yes' THEN 1 ELSE 0 END) AS fatal_cases,
    ROUND(
        100.0 * SUM(CASE WHEN fatal='Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fatal_pct
FROM audit_master
GROUP BY lob;

SELECT
    TO_CHAR(transaction_date, 'Month') AS month_name,
    Count(*) AS Audits
FROM audit_master
GROUP BY month_name,
         DATE_TRUNC('month', transaction_date)
ORDER BY DATE_TRUNC('month', transaction_date);

SELECT
    TO_CHAR(transaction_date, 'Month') AS month_name,
    ROUND(AVG(audit_score),2) AS avg_score
FROM audit_master
GROUP BY month_name,
         DATE_TRUNC('month', transaction_date)
ORDER BY DATE_TRUNC('month', transaction_date);

SELECT
    agent_name,
    partner,
    COUNT(*) AS audits,
    ROUND(AVG(audit_score),2) AS avg_score
FROM audit_master
GROUP BY agent_name, partner
HAVING COUNT(*) >= 20
Order By avg_score Desc
LIMIT 20;

SELECT
    agent_name,
    partner,
    COUNT(*) AS audits,
    ROUND(AVG(audit_score),2) AS avg_score
FROM audit_master
GROUP BY agent_name, partner
HAVING COUNT(*) >= 20
ORDER BY avg_score ASC
LIMIT 20;

SELECT
    selected_fd_group,
    COUNT(*) AS audits,
    ROUND(AVG(audit_score),2) AS avg_score
FROM audit_master
GROUP BY selected_fd_group
ORDER BY audits DESC;

SELECT
    audited_by,
    COUNT(*) AS audits_completed
FROM audit_master
GROUP BY audited_by
ORDER BY audits_completed DESC;

SELECT
    audited_by,
    COUNT(*) AS audits,
    ROUND(AVG(audit_score),2) AS avg_score_given
FROM audit_master
GROUP BY audited_by
ORDER BY avg_score_given ASC;

SELECT
    selected_fd_group,
    COUNT(*) AS fatal_cases
FROM audit_master
WHERE fatal='Yes'
GROUP BY selected_fd_group
ORDER BY fatal_cases DESC;
