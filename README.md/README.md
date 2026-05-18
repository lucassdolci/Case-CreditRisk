# Case Credit Risk — Análise de Risco de Crédito

## Contexto

Escolhi esse case porque queria trabalhar com um problema que bancos 
e fintechs enfrentam todo dia: como identificar risco de inadimplência 
antes que ele aconteça.

A pergunta que guiou tudo não foi "quem já deu inadimplência vai dar 
de novo?" porque essa qualquer um pergunta. Eu queria saber se estar 
limpo no Serasa realmente significa que a pessoa vai pagar. Os dados 
mostraram que não.

## Dataset

Credit Risk Dataset — Kaggle
32.581 registros | 12 variáveis
Dados simulando bureau de crédito real — perfil do tomador, 
características do empréstimo e histórico de inadimplência.

## Ferramentas

Para esse case usei SQL com CTEs encadeadas e window functions para 
as análises, Power Query para tratamento e transformação dos dados 
e Power BI para modelagem e construção do dashboard em 4 páginas. 
Tentei deixar tudo organizado em pastas separadas para facilitar 
a leitura de quem for olhar o repositório.

## Pergunta de Negócio

O bureau de crédito sozinho é suficiente para decidir quem recebe 
crédito? Ou existem perfis sendo aprovados que não deveriam e 
perfis sendo rejeitados que deveriam receber?

## O que os dados mostraram

Dentro das análises encontrei dois grupos que geram dois pontos 
interessantes. O primeiro é quem está limpo no Serasa mas tem boa 
parte da renda comprometida e acaba pagando juros mais altos, esse 
grupo tende a ter mais inadimplência do que parece. O segundo é quem 
está sujo no Serasa mas tem renda boa e comprometimento baixo, esse 
grupo paga melhor do que o banco imagina, e mesmo assim temos mais 
de 2.000 pessoas sendo rejeitadas sem motivo real. A sugestão é 
focar nessas 2.000 pessoas e fazer uma reanálise para possível 
liberação de crédito com critérios mais adequados ao perfil real.

Um achado que não esperava foi que o Risco Médio e o Risco Baixo 
concentram mais perda absoluta do que o Risco Crítico. Faz sentido 
quando para pra pensar, o volume de contratos nesses grupos é muito 
maior então mesmo com taxa de inadimplência menor a perda total 
acaba sendo maior. Isso muda a forma de enxergar risco, não adianta 
focar só em quem tem mais chance de não pagar, precisa olhar onde 
está o dinheiro em jogo.

## Erro de percurso

Durante a construção das medidas DAX o KPI de Penalizados Injusto 
retornou 1, claramente algo estava errado. Fui investigar e percebi 
que o problema estava na escala do Comprometimento de Renda, o 
dataset usa valores decimais onde 0.15 significa 15%, mas após o 
tratamento no Power Query a coluna ficou em escala inteira. Corrigi 
o filtro de 0.15 para 15 e os 2.000 registros apareceram. Esse tipo 
de detalhe faz diferença em produção e é exatamente o tipo de coisa 
que você só aprende errando.

## Estrutura do Projeto

data/ — dataset original CSV
queries/ — 10 queries SQL organizadas por complexidade crescente
medidas_dax.md — 5 medidas DAX documentadas
dashboard.pbix — arquivo Power BI
README.md

## Dashboard

Página 1 — Visão Geral da Carteira
22% de taxa de inadimplência, R$77Mi em perda realizada, 
distribuição por nível de risco e finalidade do empréstimo.

Página 2 — O Falso Seguro
O argumento central: bureau Y vs N não explica a inadimplência. 
O nível de risco composto explica melhor.

Página 3 — Segmentação de Risco
Taxa de inadimplência ao longo do histórico de crédito e perda 
realizada por nível de risco.

Página 4 — Impacto e Recomendação
Delta de 48 pontos percentuais entre os dois segmentos e 
recomendação executiva para o negócio.

## Recomendação

A recomendação principal é parar de usar o bureau como critério 
único de concessão e começar a cruzar com comprometimento de renda 
e taxa de juros. Isso reduziria as perdas com o grupo que parece 
seguro mas não é, e abriria crédito para as mais de 2.000 pessoas 
que estão sendo rejeitadas sem motivo real.

## Links

GitHub: github.com/lucassdolci/Case-CreditRisk
LinkedIn: linkedin.com/in/lucas-dolci