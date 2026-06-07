SELECT
    partner,
    COUNT(*) total_audits,
    ROUND(AVG(audit_score),2) avg_score
FROM cx_audit
GROUP BY partner
ORDER BY avg_score DESC;

SELECT
    agent_name,
    partner,
    ROUND(AVG(audit_score),2) avg_score,
    COUNT(*) audits
FROM cx_audit
GROUP BY agent_name, partner
HAVING COUNT(*) >= 20
ORDER BY avg_score DESC
LIMIT 10;

SELECT
    selected_fd_group,
    COUNT(*) total_audits,
    ROUND(AVG(audit_score),2) avg_score
FROM cx_audit
GROUP BY selected_fd_group
ORDER BY total_audits DESC;

SELECT
    audited_by,
    COUNT(*) audits_done
FROM cx_audit
GROUP BY audited_by
ORDER BY audits_done DESC;