-- QUERY 7 — Identificando o "falso seguro"
-- Tomadores sem histórico no bureau MAS com perfil de risco alto
-- Esse é o núcleo do case
-- ============================================================

WITH base AS (
    SELECT
        *,
        -- Score de risco simples: comprometimento + taxa de juros normalizada
        (loan_percent_income * 0.6) + (loan_int_rate / 100 * 0.4) AS score_risco_proxy
    FROM credit_risk
    WHERE cb_person_default_on_file = 'N'  -- "limpos" no bureau
)
SELECT
    CASE
        WHEN score_risco_proxy < 0.15  THEN 'Baixo'
        WHEN score_risco_proxy < 0.25  THEN 'Médio'
        ELSE                                'Alto'
    END                                                     AS nivel_risco_real,
    COUNT(*)                                                AS total,
    SUM(loan_status)                                        AS defaults,
    ROUND(SUM(loan_status) * 100.0 / COUNT(*), 2)          AS taxa_default_pct,
    ROUND(AVG(person_income), 0)                           AS renda_media
FROM base
GROUP BY nivel_risco_real
ORDER BY taxa_default_pct DESC;

-- Tomadores "limpos" no bureau com score alto devem ter taxa de default
-- similar ou pior que os "sujos" com renda alta
-- Se aparecer, temos evidência de que o bureau sozinho não é suficiente
