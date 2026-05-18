-- QUERY 3 — Inadimplência por finalidade do empréstimo
-- Hipótese: "consolidação de dívida" tem risco diferente de "educação"
-- ============================================================

SELECT
    loan_intent,
    COUNT(*)                                                AS total_contratos,
    SUM(loan_status)                                        AS defaults,
    ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2)          AS taxa_default_pct,
    ROUND(AVG(loan_amnt), 0)                               AS ticket_medio
FROM credit_risk
GROUP BY loan_intent
ORDER BY taxa_default_pct DESC;

-- DEBTCONSOLIDATION e MEDICAL costumam ter perfil de risco elevado
-- Educação costuma ser o mais comportado — faz sentido, né