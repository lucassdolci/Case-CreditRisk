-- QUERY 5 — Cruzando bureau com comprometimento de renda
-- Dividindo em quartis de comprometimento para ver o padrão
-- ============================================================

SELECT
    cb_person_default_on_file                               AS historico_bureau,
    CASE
        WHEN loan_percent_income <= 0.10 THEN '1_ate_10pct'
        WHEN loan_percent_income <= 0.20 THEN '2_de_10_a_20pct'
        WHEN loan_percent_income <= 0.30 THEN '3_de_20_a_30pct'
        ELSE                                  '4_acima_30pct'
    END                                                     AS faixa_comprometimento,
    COUNT(*)                                                AS total,
    SUM(loan_status)                                        AS defaults,
    ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2)          AS taxa_default_pct
FROM credit_risk
GROUP BY historico_bureau, faixa_comprometimento
ORDER BY historico_bureau, faixa_comprometimento;

-- Esse cruzamento é onde o achado aparece:
-- Tomador com Y no bureau mas baixo comprometimento de renda
-- pode ter taxa de default MENOR que N com alto comprometimento
-- Se aparecer isso, a pergunta de negócio está validada