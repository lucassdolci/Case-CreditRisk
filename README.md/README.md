# Case Credit Risk — Análise de Risco de Crédito
 
## Contexto
 
Escolhi esse caso porque queria trabalhar com um problema que bancos e fintechs enfrentam todo dia: identificar risco de inadimplência antes que ele aconteça.
 
A pergunta que guiou o trabalho não foi "quem já ficou inadimplente vai ficar de novo", porque essa é a pergunta óbvia. Eu queria saber se estar limpo no bureau realmente significa que a pessoa vai pagar. Os dados mostraram que não.
 
## A pergunta de negócio
 
O histórico no bureau, sozinho, é suficiente para decidir quem recebe crédito? Ou existem perfis sendo aprovados que não deveriam, e perfis sendo rejeitados que deveriam receber?
 
## Dataset
 
Credit Risk Dataset (Kaggle), 32.581 registros e 12 variáveis. Simula um bureau de crédito real, com perfil do tomador, características do empréstimo e histórico de inadimplência.
 
## Ferramentas
 
SQL com CTEs encadeadas e funções de janela para as análises. Power Query para tratamento e transformação dos dados. Power BI para modelagem e construção do dashboard de 4 páginas. Organizei tudo em pastas separadas para facilitar a leitura de quem abre o repositório.
 
## O que os dados mostraram
 
Encontrei dois grupos que o bureau classifica errado.
 
O primeiro eu chamei de Falso Seguro: pessoas limpas no bureau, mas com boa parte da renda comprometida e pagando juros mais altos. Esse grupo inadimple mais do que aparenta, e mesmo assim é aprovado.
 
O segundo é o Penalizado Injustamente: pessoas com restrição no bureau, mas com renda boa e baixo comprometimento. Esse grupo paga melhor do que o banco imagina, e ainda assim está sendo rejeitado sem motivo real.
 
Somando os dois, são cerca de 4 mil clientes classificados errado.
 
Um achado que eu não esperava: o Risco Médio e o Risco Baixo concentram mais perda absoluta do que o Risco Crítico. Faz sentido quando você para pra pensar, o volume de contratos nesses grupos é muito maior, então mesmo com taxa de inadimplência menor a perda total fica maior. Isso muda a forma de enxergar risco. Não adianta focar só em quem tem mais chance de não pagar, precisa olhar onde está o dinheiro.
 
## Erro de percurso
 
Durante a construção das medidas DAX, o indicador de Penalizado Injustamente retornou 1. Claramente algo estava errado. Fui investigar e o problema estava na escala do Comprometimento de Renda: o dataset usa valores decimais, onde 0,15 significa 15%, mas depois do tratamento no Power Query a coluna ficou em escala inteira. Corrigi o filtro de 0,15 para 15 e o número passou a aparecer certo. Esse tipo de detalhe faz diferença na produção, e é o tipo de coisa que só se aprende errando.
 
## O dashboard
 
Página 1, Visão Geral da Carteira. Taxa de inadimplência de 22%, R$ 77 Mi de perda realizada, índice de risco composto de 12,93, e a distribuição de inadimplência por nível de risco e por finalidade do empréstimo.
 
Página 2, O Falso Seguro. O argumento central: ter ou não restrição no bureau não explica sozinho a inadimplência. O nível de risco composto explica melhor.
 
Página 3, Segmentação de Risco. A perda realizada por nível de risco (com o achado do Risco Médio e Baixo concentrando mais perda) e os dois grupos que o bureau classifica errado, lado a lado.
 
Página 4, Impacto e Recomendação. O número de clientes classificados errado e a recomendação executiva para o negócio.
 
Sobre as cores: o nível de risco usa uma escala que vai do verde (mais seguro) ao vermelho (crítico), porque risco é uma variável ordenada e a cor carrega esse significado. As outras variáveis usam azul como cor neutra. Foi uma escolha proposital, para que a mesma cor signifique sempre a mesma coisa no relatório inteiro.
 
## Recomendação
 
Parar de usar o bureau como critério único de concessão e passar a cruzar com comprometimento de renda e taxa de juros. Isso reduz as perdas com o grupo que parece seguro mas não é, e abre crédito para as pessoas que estão sendo rejeitadas sem motivo real.
 
## Estrutura do projeto
 
```
data/              CSV original do dataset
sql/               10 queries organizadas por complexidade crescente
medidas_dax.md     5 medidas DAX documentadas
dashboard.pbix     arquivo Power BI
README.md
```
 
## Links
 
GitHub: github.com/lucassdolci/Case-CreditRisk
LinkedIn: linkedin.com/in/lucas-dolci
