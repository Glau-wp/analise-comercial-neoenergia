# --- PROJETO DE ANÁLISE COMERCIAL: NEOENERGIA ---
# Autor: Glaucia Vanessa da Silva Batista
# Objetivo: Extração e segmentação de dados para campanhas de marketing e eficiência energética.

# 1. SELEÇÃO BÁSICA E FILTROS
# Extrai nome e consumo dos clientes de Ribeirão Preto com foco em alta demanda (>500 kWh).
# O ORDER BY garante que os maiores consumidores apareçam primeiro (Foco em Upgrade de Plano).
SELECT nome, consumo_kwh
FROM clientes_faturamento
WHERE cidade = 'Ribeirão Preto' AND consumo_kwh > 500
ORDER BY consumo_kwh DESC;

# 2. FILTROS DE LOCALIZAÇÃO (OPERADOR OR / IN)
# Seleciona todos os dados de clientes que pertencem às regionais de interesse comercial.
SELECT *
FROM clientes_faturamento
WHERE cidade IN ('Ribeirão Preto', 'Campinas', 'Mirandópolis');

# 3. MÉTRICAS DE NEGÓCIO (AGREGAÇÃO)
# Calcula a média de consumo especificamente para a região de Campinas.
# Essencial para entender o comportamento de consumo médio da regional.
SELECT AVG(consumo_kwh) AS media_consumo_campinas
FROM clientes_faturamento
WHERE cidade = 'Campinas';

# 4. AGRUPAMENTO E VOLUMETRIA (GROUP BY)
# Conta quantos clientes existem em cada cidade. 
# Informação vital para logística de leitura de medidores e dimensionamento de mercado.
SELECT cidade, COUNT(*) AS total_clientes
FROM clientes_faturamento
GROUP BY cidade;

# 5. UNIÃO DE TABELAS (INNER JOIN)
# Cruza a tabela de 'clientes' (cadastro) com a de 'faturas' (faturamento).
# A ponte entre as tabelas é o 'id_cliente', permitindo ver o valor pago por cada nome.
SELECT c.nome, f.valor_pago, f.data_vencimento
FROM clientes AS c
INNER JOIN faturas AS f ON c.id_cliente = f.id_cliente;
