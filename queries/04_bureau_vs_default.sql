-- QUERY 4 — O bureau realmente funciona?
-- Aqui começa a pergunta de negócio de verdade
-- Comparando default por histórico no bureau
-- ============================================================

SELECT
    cb_person_default_on_file           AS historico_bureau,
    COUNT(*)                            AS total,
    SUM(loan_status)                    AS defaults,
    ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2) AS taxa_default_pct,
    ROUND(AVG(person_income), 0)        AS renda_media,
    ROUND(AVG(loan_percent_income), 3)  AS comprometimento_renda_medio
FROM credit_risk
GROUP BY cb_person_default_on_file;

-- Expectativa óbvia: Y tem mais default que N
-- Mas olha a renda e o comprometimento — a história começa aqui
