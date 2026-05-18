-- MEDIDA 4 — Tomadores Penalizados Injustamente
-- Conta quem tem Y no bureau MAS baixo comprometimento e renda alta
-- Esse é o segmento central do case — aparece no KPI de oportunidade
Penalizados Injusto = 
CALCULATE(
    COUNTROWS(credit_risk),
    credit_risk[cb_person_default_on_file] = "Y",
    credit_risk[loan_percent_income] <= 0.15,
    credit_risk[person_income] > 60000
)