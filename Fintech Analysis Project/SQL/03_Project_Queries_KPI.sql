CREATE TABLE audit_master AS

SELECT
    'CX' AS lob,
    audit_id,
    form_id,
    audit_score,
    transaction_date,
    partner,
    agent_id,
    agent_name,
    selected_fd_group,
    fatal,
    audited_by
FROM cx_audit

UNION ALL

SELECT
    'MHD' AS lob,
    audit_id,
    form_id,
    audit_score,
    transaction_date,
    partner,
    agent_id,
    agent_name,
    selected_fd_group,
    fatal,
    audited_by
FROM mhd_audit;

SELECT COUNT(*) AS total_records
FROM audit_master;

SELECT
    lob,
    COUNT(*) AS total_records
FROM audit_master
GROUP BY lob;

SELECT
    partner,
    COUNT(*) AS total_audits
FROM audit_master
GROUP BY partner
ORDER BY total_audits DESC;

SELECT
    partner,
    COUNT(*) AS total_audits,
    ROUND(AVG(audit_score),2) AS avg_score,
    SUM(CASE WHEN fatal = 'Yes' THEN 1 ELSE 0 END) AS fatal_cases,
    ROUND(
        100.0 * SUM(CASE WHEN fatal = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        2
    ) AS fatal_percentage
FROM audit_master
GROUP BY partner
ORDER BY avg_score DESC;