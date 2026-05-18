-- QUERY 2 — Perfil básico por status
-- Quero entender se há diferença óbvia de renda e idade
-- ============================================================

SELECT
    loan_status,
    ROUND(AVG(person_age), 1)           AS idade_media,
    ROUND(AVG(person_income), 0)        AS renda_media,
    ROUND(AVG(loan_amnt), 0)            AS valor_medio_emprestimo,
    ROUND(AVG(loan_int_rate), 2)        AS taxa_juros_media,
    ROUND(AVG(loan_percent_income), 3)  AS comprometimento_renda_medio
FROM credit_risk
GROUP BY loan_status;

-- Taxa de juros e comprometimento de renda vão ser bem diferentes
-- Já consigo ver onde a coisa aperta