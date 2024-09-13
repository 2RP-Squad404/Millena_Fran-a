**Nome do Estagiário:** Millena OLiveira França

**Data:** 13/09/2024

# **Payloads, Query e Views**

### Geração do json
Solicitei ao ChatGPT para gerar 5 payloads em json a partir do dataset `purchases_2023`. Entre os gerados selecionei os 3 seguintes:

Compras de valor alto
```
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

Produtos com desconto
```
{
  "view_name": "discounted_products_summary",
  "source_table": "my_project.purchases_2023",
  "columns": ["product_name", "amount", "discount_applied"],
  "filters": {
    "condition": "discount_applied > 0"
  },
  "group_by": ["product_name"],
  "aggregations": {
    "total_discount": "SUM(discount_applied)",
    "total_quantity": "SUM(amount)"
  }
}
```
Compras por método de pagameto
```
{
  "view_name": "purchases_by_payment_method",
  "source_table": "my_project.purchases_2023",
  "columns": ["payment_method", "amount", "price"],
  "group_by": ["payment_method"],
  "aggregations": {
    "total_value": "SUM(price)",
    "total_purchases": "COUNT(purchase_id)"
  }
}

```

### Geração das querys/views
A partir dos payloads gerados, passei instruções ao VertexAI para criar uma query que gerasse uma view para cada respectivo json.

**View 1:**

Prompt utilizado: 
`
gere uma query para criar uma view a partir do seguinte payload json: {  "view_name": "high_value_purchases",  "source_table": "my_project.purchases_2023",  "columns": ["purchase_id", "product_name", "price", "purchase_datetime"],  "filters": {   "condition": "price > 5.00"  },  "group_by": ["product_name"],  "aggregations": {   "total_value": "SUM(price)"  } }`

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
**View 2:**
```
CREATE VIEW IF NOT EXISTS `squadcalouros.discounted_products` AS
SELECT
    product_name,
    SUM(amount) AS total_quantity,
    SUM(discount_applied) AS total_discount
FROM
    `squadcalouros.squadcalouros.purchases`
WHERE
    discount_applied > 0
GROUP BY
    product_name;
```
**View 3:**
```

CREATE OR REPLACE VIEW `squadcalouros.purchases_by_payment_method` AS
SELECT
    payment_method,
    SUM(price) AS total_value,
    COUNT(purchase_id) AS total_purchases
FROM
    `squadcalouros.squadcalouros.purchases`
GROUP BY
    payment_method;
```

### Big Query
Após a geração dos comandos, executei os mesmos no console, precisando fazer algumas alterações para que funcionassem:
- Alterei os endereços, adicionando os caminhos do projeto e tabelas

### Dúvidas
Tive dificuldades para iniciar as atividades, demorando a entender o que tinha que fazer e como começar.
