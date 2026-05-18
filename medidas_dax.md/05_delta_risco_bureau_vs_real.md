-- MEDIDA 5 — Diferença de Risco Bureau vs Dado Real
-- Compara a taxa de default do "falso seguro" com a do "penalizado injusto"
-- Se positivo: o bureau está errando a favor do risco errado
-- Esse número vira o título da última página do dashboard
Delta Risco Bureau vs Real = 
VAR TaxaFalsoSeguro =
    CALCULATE(
        [Taxa de Default %],
        credit_risk[cb_person_default_on_file] = "N",
        credit_risk[loan_percent_income] > 0.30,
        credit_risk[loan_int_rate] > 15
    )
VAR TaxaPenalizado =
    CALCULATE(
        [Taxa de Default %],
        credit_risk[cb_person_default_on_file] = "Y",
        credit_risk[loan_percent_income] <= 0.15,
        credit_risk[person_income] > 60000
    )
RETURN
    TaxaFalsoSeguro - TaxaPenalizado