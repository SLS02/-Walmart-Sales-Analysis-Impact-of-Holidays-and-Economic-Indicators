-- =====================================================
-- PROJETO: Walmart Sales Analysis - SQL Script
-- OBJETIVO: Limpeza, transformação e análise de dados
-- FERRAMENTA: SQL (PostgreSQL / MySQL / SQL Server)
-- AUTOR: Sérgio Lopes 

CREATE TABLE walmart_sales_clean AS
SELECT 
    store,
    TO_CHAR(date, 'MM-DD-YYYY') AS date_formatted,  -- formato MM-DD-AAAA
    ROUND(weekly_sales, 2) AS weekly_sales_clean,
    holiday_flag,
    ROUND(temperature, 0) AS temperature_clean,
    ROUND(fuel_price, 2) AS fuel_price_clean,
    ROUND(cpi, 3) AS cpi_clean,
    ROUND(unemployment, 3) AS unemployment_clean
FROM walmart_sales
WHERE 
    store IS NOT NULL 
    AND date IS NOT NULL 
    AND weekly_sales IS NOT NULL
    AND holiday_flag IS NOT NULL
    AND temperature IS NOT NULL
    AND fuel_price IS NOT NULL
    AND cpi IS NOT NULL
    AND unemployment IS NOT NULL;

-- Verificar se não há nulos:
SELECT COUNT(*) FROM walmart_sales_clean WHERE weekly_sales_clean IS NULL; -- deve dar 0

-- =====================================================
-- 3. ANÁLISE EXPLORATÓRIA E PERGUNTAS DE NEGÓCIO
-- =====================================================

-- -----------------------------------------------------
-- 3.1. VENDAS TOTAIS POR FERIADO (Holiday_Flag = 1)
-- -----------------------------------------------------
SELECT 
    CASE 
        WHEN date_formatted LIKE '%02%' THEN 'Super Bowl'  -- aproximação, idealmente usar tabela de feriados
        ELSE 'Other Holiday'
    END AS holiday_name,
    SUM(weekly_sales_clean) AS total_sales
FROM walmart_sales_clean
WHERE holiday_flag = 1
GROUP BY holiday_name
ORDER BY total_sales DESC;

-- -----------------------------------------------------
-- 3.2. LOJAS COM MENOR E MAIOR TAXA DE DESEMPREGO
-- -----------------------------------------------------
-- Menor taxa de desemprego (lojas 23 e 40)
SELECT store, unemployment_clean
FROM walmart_sales_clean
WHERE store IN (23, 40)
GROUP BY store, unemployment_clean
ORDER BY unemployment_clean ASC
LIMIT 1; -- ou usar DISTINCT

-- Maior taxa de desemprego (lojas 12, 28, 38)
SELECT store, unemployment_clean
FROM walmart_sales_clean
WHERE store IN (12, 28, 38)
GROUP BY store, unemployment_clean
ORDER BY unemployment_clean DESC;

-- -----------------------------------------------------
-- 3.3. CORRELAÇÃO ENTRE CPI E VENDAS SEMANAIS
-- (com e sem feriado)
-- -----------------------------------------------------
-- Sem feriado (Holiday_Flag = 0)
SELECT 
    CORR(cpi_clean, weekly_sales_clean) AS correlation_cpi_sales_no_holiday
FROM walmart_sales_clean
WHERE holiday_flag = 0;

-- Com feriado (Holiday_Flag = 1)
SELECT 
    CORR(cpi_clean, weekly_sales_clean) AS correlation_cpi_sales_holiday
FROM walmart_sales_clean
WHERE holiday_flag = 1;

-- Valores totais de CPI e vendas para contexto:
SELECT 
    SUM(cpi_clean) AS total_cpi,
    SUM(weekly_sales_clean) AS total_sales
FROM walmart_sales_clean
WHERE holiday_flag = 0;

SELECT 
    SUM(cpi_clean) AS total_cpi,
    SUM(weekly_sales_clean) AS total_sales
FROM walmart_sales_clean
WHERE holiday_flag = 1;

-- -----------------------------------------------------
-- 3.4. TENDÊNCIA TEMPORAL: VENDAS vs PREÇO COMBUSTÍVEL
-- -----------------------------------------------------
SELECT 
    date,
    weekly_sales_clean,
    fuel_price_clean
FROM walmart_sales_clean
ORDER BY date;

-- -----------------------------------------------------
-- 3.5. ANÁLISE ADICIONAL: DESEMPREGO POR LOJA (média)
-- -----------------------------------------------------
SELECT 
    store,
    ROUND(AVG(unemployment_clean), 2) AS avg_unemployment
FROM walmart_sales_clean
GROUP BY store
ORDER BY avg_unemployment ASC;  -- lojas com menor desemprego primeiro

-- =====================================================
-- Copiar resultados para CSV (PostgreSQL)
COPY (
    SELECT * FROM walmart_sales_clean ORDER BY store, date
) TO '/tmp/walmart_sales_clean.csv' DELIMITER ',' CSV HEADER;
