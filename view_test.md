# Criação de View com BigQuery

## Descrição

Neste projeto, utilizei o ChatGPT e o Gemini para gerar JSONs que descrevem as views que foram criadas a partir do dataset `purchases_2023` no BigQuery. Com base nesses JSONs, foram geradas consultas SQL para criar as views de forma automatizada.

## Objetivo

O objetivo do projeto foi automatizar a criação de views no BigQuery utilizando JSON payloads, gerados via ChatGPT e Gemini, para estruturar e criar os selects necessários para a construção das views.

## Etapas Realizadas

### 1. Geração de JSONs com ChatGPT e Gemini

Utilizando o ChatGPT e Gemini, foram gerados os JSONs que especificam os detalhes das views a serem criadas, como o nome da view, a tabela-fonte, colunas, filtros e agregações.

Primeiro JSON gerado:

```json
{
  "view_name": "high_value_purchases",
  "source_table": "my_project.purchases_2023",
  "columns": ["purchase_id", "product_name", "price", "purchase_datetime"],
  "filters": {
    "condition": "price > 5.00"
  },
  "group_by": ["product_name"],
  "aggregations": {
    "total_value": "SUM(price)"
  }
}
```
A partir desse json gerei esse select para construir a view no BigQuery
```
CREATE VIEW IF NOT EXISTS `squadcalouros.high_value_purchases` AS
SELECT
  product_name,
  MAX(purchase_id) AS purchase_id,
  SUM(price) AS total_price,
  MIN(purchase_datetime) AS min_purchase_datetime,
  MAX(purchase_datetime) AS max_purchase_datetime
FROM
  `squadcalouros.squadcalouros.purchases`
WHERE
  price > 5.00
GROUP BY
  product_name;
```
View criada para mostrar as compras com valor superior a 5 dólares, agrupadas por produto. Inicialmente,
encontrei dificuldades ao tentar selecionar a coluna purchase_id sem agrupá-la ou aplicar uma função de agregação,
o que resultou no erro "SELECT list expression references column purchase_id which is neither grouped nor aggregated".
Após pesquisar a documentação do SQL, compreendi a importância do GROUP BY e das funções de agregação, como MAX, SUM e MIN, para realizar cálculos sobre grupos de dados.

