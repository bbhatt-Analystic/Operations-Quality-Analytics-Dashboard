SELECT
    lob,
    partner,
    COUNT(*) AS audits
FROM audit_master
GROUP BY lob, partner
ORDER BY partner, lob;

SELECT
    EXTRACT(MONTH FROM transaction_date) AS month_no,
    TRIM(TO_CHAR(transaction_date, 'Month')) AS month_name,
    COUNT(*) AS total_audits,
    SUM(CASE WHEN fatal = 'Yes' THEN 1 ELSE 0 END) AS fatal_cases,
    ROUND(
        100.0 * SUM(CASE WHEN fatal = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fatal_percentage
FROM audit_master
GROUP BY month_no, month_name
ORDER BY month_no;

SELECT
    CASE
        WHEN audit_score >= 90 THEN '90+'
        WHEN audit_score >= 80 THEN '80-89'
        WHEN audit_score >= 70 THEN '70-79'
        ELSE 'Below 70'
    END AS score_bucket,
    COUNT(*) AS audits
FROM audit_master
GROUP BY score_bucket
ORDER BY audits ASC;

SELECT
    selected_fd_group,
    COUNT(*) AS audits
FROM audit_master
GROUP BY selected_fd_group
ORDER BY audits DESC
LIMIT 5;

SELECT
    selected_fd_group,
    COUNT(*) AS audits,
    ROUND(
        100.0 * SUM(CASE WHEN fatal='Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fatal_pct
FROM audit_master
GROUP BY selected_fd_group
HAVING COUNT(*) >= 20
Order by fatal_pct Desc;
