-- QUERY 8 — Evolução do risco por tempo de histórico de crédito
-- Window function pra calcular média móvel da taxa de default
-- ============================================================

WITH historico_agrupado AS (
    SELECT
        cb_person_cred_hist_length                              AS anos_historico,
        COUNT(*)                                                AS total,
        SUM(loan_status)                                        AS defaults,
        ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2)          AS taxa_default_pct
    FROM credit_risk
    GROUP BY cb_person_cred_hist_length
    HAVING COUNT(*) >= 50  -- só anos com volume suficiente pra ser relevante
)
SELECT
    anos_historico,
    total,
    taxa_default_pct,
    -- Média móvel de 3 períodos pra suavizar a curva
    ROUND(
        AVG(taxa_default_pct) OVER (
            ORDER BY anos_historico
            ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
        ),
        2
    )                                                           AS taxa_default_media_movel
FROM historico_agrupado
ORDER BY anos_historico;

-- Hipótese: há um "sweet spot" de histórico de crédito
-- Muito curto = risco por inexperiência
-- Muito longo = pode estar carregando uma inadimplência antiga que não reflete hoje