-- MEDIDA 3 — Índice de Risco Composto
-- Combina comprometimento de renda e taxa de juros num único número
-- Serve pra criar o eixo de risco no scatter plot da página 2
-- O peso 0.6/0.4 é defensável: comprometimento explica mais default que a taxa
Índice de Risco Composto = 
AVERAGEX(
    credit_risk,
    (credit_risk[loan_percent_income] * 0.6) + 
    (credit_risk[loan_int_rate] / 100 * 0.4)
)