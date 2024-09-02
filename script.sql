%hive
SET fs.s3a.access.key=minioadmin;
SET fs.s3a.secret.key=minioadmin;
SET fs.s3a.endpoint=http://localhost:9001;
SET fs.s3a.path.style.access=true

CREATE EXTERNAL TABLE campaigns (
    id_campaign STRING,
    idk_campaing STRING,
    type_campaign STRING,
    days_valid INT,
    data_campaign STRING, 
    channel STRING,
    return_status STRING,
    return_date STRING,
    client_id STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3a://tarefa1/campaigns_2023_hits.csv/campaigns_2023_hist.csv'
TBLPROPERTIES ("skip.header.line.count"="1")


CREATE EXTERNAL TABLE purchases (
    purchase_id STRING,
    product_name STRING,
    product_id STRING,
    amount DECIMAL(10, 2),
    price DECIMAL(10, 2),
    discount_applied BOOLEAN,
    payment_method STRING,
    purchase_datetime STRING,
    purchase_location STRING,
    client_id STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION 's3a://tarefa2/purchases/'
TBLPROPERTIES ("skip.header.line.count"="1")

LOAD DATA INPATH 's3a://tarefa1/campaigns_2023_hits.csv/'
INTO TABLE campaigns

LOAD DATA INPATH 's3a://tarefa2/purchases_2023.csv'
INTO TABLE purchases

CREATE TABLE consolidated_table (
    client_id STRING,
    total_price DECIMAL(10, 2),
    most_purchase_location STRING,
    first_purchase STRING,
    last_purchase STRING,
    most_campaign STRING,
    quantity_error INT,
    date_today STRING,
    anomes_today INT
)

INSERT INTO TABLE consolidated_table
SELECT
    c.client_id AS client_id,
    SUM(p.price * p.amount * (CASE WHEN COALESCE(p.discount_applied, false) THEN 0.9 ELSE 1 END)) AS total_price,
    p.purchase_location AS most_purchase_location,
    MIN(p.purchase_datetime) AS first_purchase,
    MAX(p.purchase_datetime) AS last_purchase,
    c.type_campaign AS most_campaign,
    COUNT(CASE WHEN c.return_status = 'error' THEN 1 ELSE NULL END) AS quantity_error,
    FROM_UNIXTIME(UNIX_TIMESTAMP(), 'yyyy-MM-dd') AS date_today,
    FROM_UNIXTIME(UNIX_TIMESTAMP(), 'MMyyyy') AS anomes_today
FROM 
    purchases p
JOIN 
    campaigns c ON p.client_id = c.client_id
GROUP BY 
    c.client_id, 
    p.purchase_location, 
    c.type_campaign

