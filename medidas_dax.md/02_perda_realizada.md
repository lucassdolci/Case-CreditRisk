-- MEDIDA 2 — Perda Estimada na Carteira
-- Soma o valor dos contratos que efetivamente deram default
-- Esse número vai aparecer no KPI principal do dashboard
Perda Realizada R$ = 
CALCULATE(
    SUM(credit_risk[loan_amnt]),
    credit_risk[loan_status] = 1
)