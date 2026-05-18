-- QUERY 6 — Ranking de risco por grade do empréstimo
-- Usando window function pra calcular participação no default total
-- ============================================================

SELECT
    loan_grade,
    COUNT(*)                                                        AS total_contratos,
    SUM(loan_status)                                                AS defaults,
    ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2)                  AS taxa_default_pct,
    ROUND(AVG(loan_int_rate), 2)                                    AS taxa_juros_media,
    -- Quanto cada grade representa do total de defaults na carteira
    ROUND(
        SUM(loan_status) * 100.0 /
        SUM(SUM(loan_status)) OVER(),
        2
    )                                                               AS pct_do_total_defaults
FROM credit_risk
GROUP BY loan_grade
ORDER BY loan_grade;

-- Grade G vai ter taxa absurda mas volume pequeno
-- Grade B/C provavelmente concentra o maior volume absoluto de defaults
-- É a diferença entre risco unitário e risco de carteira
