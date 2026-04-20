# 📊 Walmart Sales Analysis – Impact of Holidays and Economic Indicators

## 📌 Descrição do Projeto

Este projeto analisa as vendas semanais do Walmart, cruzando dados económicos como **CPI (Índice de Preços ao Consumidor)**, **preço do combustível**, **taxa de desemprego** e **temperatura**. O objetivo é identificar:

- O impacto de **feriados** nas vendas.
- **Correlações** entre vendas e indicadores económicos.
- Diferenças de comportamento em semanas **com** e **sem** feriado.
- Relação entre **desemprego** e número da loja.

Os dados foram obtidos do **Kaggle** e tratados com **Excel** e **Power BI**.

---

## 🛠️ Ferramentas Utilizadas

- **Excel** – limpeza e transformação de dados
- **Power BI** – visualizações, medidas de correlação e dashboards
- **GitHub** – documentação e portfólio

---

## 🧹 Limpeza de Dados (Excel)

Foram aplicados os seguintes critérios para garantir a qualidade da análise:

| Critério | Ação |
|----------|------|
| Ordenação | `Store` (crescente) + `Date` (crescente) |
| Formato da data | `MM-DD-AAAA` |
| `Weekly_Sales` | Arredondado para **2 casas decimais** |
| `Temperature` | Arredondado para o **inteiro mais próximo** |
| `Fuel_Price` | Arredondado para **2 casas decimais** |
| `CPI` | Arredondado para **3 casas decimais** |
| `Unemployment` | Arredondado para **3 casas decimais** |
| Dados ausentes | Removidos / tratados – dataset 100% completo |

---

## 📈 Principais Análises e Insights

### 1. Correlação entre CPI e Vendas Semanais

| Contexto | Correlação | CPI Total | Vendas Totais |
|----------|------------|------------|----------------|
| Sem feriado (`Holiday_Flag = 0`) | **0** (próxima de zero) | 1,03 M | 6,23 bn |
| Com feriado (`Holiday_Flag = 1`) | **1** (perfeita positiva) | 77,07 K | 505,30 M |

> 💡 **Conclusão:** Em semanas sem feriado, CPI e vendas são independentes. Durante feriados, a correlação sobe para 1 – ambos sobem juntos, possivelmente por fatores sazonais ou de procura.

---

### 2. Vendas por Feriado

| Feriado | Vendas Totais |
|---------|----------------|
| Super Bowl | 145,68 M |
| Labor Day | 140,73 M |
| Thanksgiving | 132,41 M |
| Christmas | 86,47 M |

> 💡 **Insight:** O **Super Bowl** é o feriado com maior impacto nas vendas. O Natal (Christmas) aparece com menor impacto neste conjunto – pode ser explicado por sazonalidade ou pela janela de dados disponível.

---

### 3. Relação entre Vendas e Preço do Combustível

- Gráfico de linha temporal (Jul 2010 – Jul 2012) mostra tendências opostas em alguns períodos.
- Quando o preço do combustível sobe, as vendas semanais **tendem a cair ligeiramente** (correlação negativa moderada).

---

### 4. Desemprego por Loja

| Categoria | Lojas | Taxa de Desemprego |
|-----------|-------|---------------------|
| **Menor taxa de desemprego** | 23 e 40 | **685,83** |
| **Maior taxa de desemprego** | 12, 28 e 38 | **1.875,66** |

> 💡 **Possíveis fatores:** localização geográfica (regiões mais ou menos industrializadas), sazonalidade, dependência de sectores como turismo, indústria ou serviços.

---

## ❓ Respostas às Perguntas de Negócio

| Pergunta | Resposta |
|----------|----------|
| **Quais feriados afetam mais as vendas?** | Super Bowl > Labor Day > Thanksgiving > Christmas |
| **Lojas com menor e maior desemprego?** | Menor: 23 e 40 (685,83) ; Maior: 12, 28 e 38 (1.875,66) |
| **Correlação CPI vs Vendas (feriado vs não feriado)?** | Sem feriado: ~0 ; Com feriado: 1 (forte positiva) |
| **Por que incluir preço do combustível?** | Afeta custos logísticos e poder de compra do consumidor. Conclusão: existe relação inversa com vendas em certos períodos. |


<img width="2107" height="1175" alt="Captura de ecrã 2026-04-20 165754" src="https://github.com/user-attachments/assets/31268a05-916f-4ad2-b2d3-9beb14239436" />
