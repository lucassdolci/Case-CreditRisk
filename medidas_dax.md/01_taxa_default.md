-- MEDIDA 1 — Taxa de Default Ajustada
-- Não é um COUNT simples. Filtra o contexto atual do visual
-- pra funcionar em qualquer slice (por grade, por finalidade, etc.)
Taxa de Default % = 
DIVIDE(
    CALCULATE(COUNTROWS(credit_risk), credit_risk[loan_status] = 1),
    COUNTROWS(credit_risk),
    0
)