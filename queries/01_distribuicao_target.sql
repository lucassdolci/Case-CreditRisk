-- QUERY 1 — Primeiro contato com o dado
-- Sempre começo assim: ver distribuição do target antes de qualquer coisa
-- ============================================================

SELECT
    loan_status,
    COUNT(*)                                        AS total,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS pct
FROM credit_risk
GROUP BY loan_status;

-- Resultado esperado: ~78% adimplente, ~22% default
-- Já de cara: dataset desbalanceado. Isso vai importar no final.