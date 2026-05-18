-- QUERY 9 — Segmentação avançada: matriz bureau × comprometimento × renda
-- CTE encadeada pra construir o argumento final
-- ============================================================

WITH metricas_base AS (
    SELECT
        cb_person_default_on_file                               AS bureau,
        CASE
            WHEN loan_percent_income <= 0.15 THEN 'Baixo'
            WHEN loan_percent_income <= 0.30 THEN 'Médio'
            ELSE                                  'Alto'
        END                                                     AS comprometimento,
        CASE
            WHEN person_income <= 30000  THEN 'Baixa'
            WHEN person_income <= 70000  THEN 'Média'
            ELSE                              'Alta'
        END                                                     AS faixa_renda,
        loan_status
    FROM credit_risk
),
agregado AS (
    SELECT
        bureau,
        comprometimento,
        faixa_renda,
        COUNT(*)                                                AS total,
        SUM(loan_status)                                        AS defaults,
        ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2)          AS taxa_default_pct
    FROM metricas_base
    GROUP BY bureau, comprometimento, faixa_renda
    HAVING COUNT(*) >= 30
),
ranking AS (
    SELECT
        *,
        -- Rankeando os segmentos do mais arriscado pro menos arriscado
        RANK() OVER (ORDER BY taxa_default_pct DESC)            AS rank_risco,
        -- Percentil dentro do bureau
        RANK() OVER (
            PARTITION BY bureau
            ORDER BY taxa_default_pct DESC
        )                                                       AS rank_dentro_bureau
    FROM agregado
)
SELECT
    bureau,
    comprometimento,
    faixa_renda,
    total,
    taxa_default_pct,
    rank_risco,
    rank_dentro_bureau
FROM ranking
ORDER BY taxa_default_pct DESC
LIMIT 20;

-- Esse resultado vai mostrar quais combinações bureau/comprometimento/renda
-- criam os segmentos de maior e menor risco
-- Spoiler: alguns segmentos com bureau Y vão aparecer no TOP 10 mais seguros