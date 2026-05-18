-- QUERY 10 — Simulação de impacto: quanto o banco "errou" na concessão
-- Estimativa de perda em contratos aprovados com perfil de risco alto
-- CTE complexa, resultado executivo
-- ============================================================

WITH perfil_risco AS (
    SELECT
        *,
        -- Definindo "falso seguro": sem histórico no bureau mas alto comprometimento
        CASE
            WHEN cb_person_default_on_file = 'N'
             AND loan_percent_income > 0.30
             AND loan_int_rate > 15
            THEN 'Falso_Seguro'
            -- "Penalizado injustamente": com histórico no bureau mas baixo comprometimento
            WHEN cb_person_default_on_file = 'Y'
             AND loan_percent_income <= 0.15
             AND person_income > 60000
            THEN 'Penalizado_Injusto'
            ELSE 'Outros'
        END AS segmento_analise
    FROM credit_risk
),
impacto AS (
    SELECT
        segmento_analise,
        COUNT(*)                                                AS contratos,
        SUM(loan_status)                                        AS defaults_reais,
        ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2)          AS taxa_default_pct,
        ROUND(SUM(loan_amnt), 0)                               AS volume_total_R$,
        ROUND(SUM(CASE WHEN loan_status = 1 THEN loan_amnt ELSE 0 END), 0) AS perda_realizada_R$,
        -- Perda média por contrato inadimplente
        ROUND(
            SUM(CASE WHEN loan_status = 1 THEN loan_amnt ELSE 0 END) /
            NULLIF(SUM(loan_status), 0),
            0
        )                                                       AS ticket_medio_default_R$
    FROM perfil_risco
    WHERE segmento_analise != 'Outros'
    GROUP BY segmento_analise
)
SELECT
    segmento_analise,
    contratos,
    taxa_default_pct,
    volume_total_R$,
    perda_realizada_R$,
    ticket_medio_default_R$,
    -- Quanto representa do total de perdas
    ROUND(
        perda_realizada_R$ * 100.0 /
        SUM(perda_realizada_R$) OVER(),
        2
    )                                                           AS pct_da_perda_total
FROM impacto
ORDER BY perda_realizada_R$ DESC;

-- Essa query entrega o número executivo:
-- O segmento "Falso Seguro" (aprovado pelo bureau, rejeitado pelo dado real)
-- provavelmente concentra uma parcela desproporcional das perdas
-- Se o Penalizado Injusto tiver taxa menor que o Falso Seguro,
-- o argumento está fechado: o bureau sozinho está custando dinheiro ao banco
