--Criando as tabelas
CREATE TABLE item_dim (
  	item_key VARCHAR(6),
	item_name VARCHAR(128),
	descr VARCHAR(128),
	unit_price DECIMAL,
	man_country VARCHAR(128),
	supplier VARCHAR(128),
	unit VARCHAR(32)
);

ALTER TABLE item_dim ADD PRIMARY KEY (item_key);

--e carregando os dados, no caso ajustar o endereço dos arquivos.
COPY item_dim(item_key,item_name,descr,unit_price,man_country,supplier,unit)
FROM 'D:\mauricio\Dev\ADA\banco_dados\Projeto\archive\item_dim.csv'
DELIMITER ','
CSV HEADER;

--Visualizando as primeiras linhas
SELECT * FROM item_dim LIMIT 10;

--verificando o número de linhas
SELECT COUNT(Item_key) FROM item_dim;
--ou simplesmente:
SELECT COUNT(*) FROM item_dim;

-- Usando agrupamento e ordenação
SELECT item_name, COUNT(item_name) FROM item_dim
GROUP BY item_name
ORDER BY COUNT(item_name) DESC;

--DROP TABLE store_dim;

CREATE TABLE store_dim (
	store_key VARCHAR(8),
	division VARCHAR(128),
	district VARCHAR(128),
	upazila VARCHAR(128)
);

ALTER TABLE store_dim ADD PRIMARY KEY (store_key);

COPY store_dim(store_key,division,district,upazila)
FROM 'D:\mauricio\Dev\ADA\banco_dados\Projeto\archive\store_dim.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM store_dim LIMIT 10;

SELECT COUNT(*) FROM store_dim;


--DROP TABLE time_dim;

CREATE TABLE time_dim (
	time_key VARCHAR(8),
	date_ TIMESTAMP,
	hour_ SMALLINT,
	day_ SMALLINT,
	week VARCHAR(8),
	month_ VARCHAR(2),
	quarter VARCHAR(2),
	year_ SMALLINT
);

ALTER TABLE time_dim ADD PRIMARY KEY (time_key);

COPY time_dim (time_key,date_,hour_,day_,week,month_,quarter,year_)
FROM 'D:\mauricio\Dev\ADA\banco_dados\Projeto\archive\time_dim.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM time_dim LIMIT 10;

SELECT COUNT(*) FROM time_dim;


CREATE TABLE Trans_dim (
	payment_key VARCHAR(6),
	trans_type VARCHAR(32),
	bank_name VARCHAR(128)
);

ALTER TABLE Trans_dim ADD PRIMARY KEY (payment_key);
 
COPY Trans_dim (payment_key,trans_type,bank_name)
FROM 'D:\mauricio\Dev\ADA\banco_dados\Projeto\archive\Trans_dim.csv'
DELIMITER ','
CSV HEADER; 

SELECT * FROM Trans_dim LIMIT 10;

SELECT COUNT(*) FROM Trans_dim;


-- DROP TABLE customer_dim;

CREATE TABLE customer_dim (
	customer_key VARCHAR(8),
	name_ VARCHAR(64),
	contact_no VARCHAR(16),
	nid VARCHAR(16)
);

ALTER TABLE customer_dim ADD PRIMARY KEY (customer_key);

COPY customer_dim (customer_key,name_,contact_no,nid)
FROM 'D:\mauricio\Dev\ADA\banco_dados\Projeto\archive\customer_dim.csv'
DELIMITER ','
CSV HEADER; 

SELECT * FROM customer_dim LIMIT 10;

SELECT COUNT(*) FROM customer_dim;

--DROP TABLE fact_table;

CREATE TABLE fact_table (
	payment_key VARCHAR(6),
	customer_key VARCHAR(8),
	time_key VARCHAR(8),
	item_key VARCHAR(6),
	store_key VARCHAR(128),
	quantity SMALLINT,
	unit VARCHAR(12),
	unit_price DECIMAL,
	total_price DECIMAL
);

ALTER TABLE fact_table ADD FOREIGN KEY (payment_key) REFERENCES Trans_dim(payment_key);
ALTER TABLE fact_table ADD FOREIGN KEY (customer_key) REFERENCES customer_dim(customer_key);
ALTER TABLE fact_table ADD FOREIGN KEY (time_key) REFERENCES time_dim(time_key);
ALTER TABLE fact_table ADD FOREIGN KEY (item_key) REFERENCES item_dim(item_key);
ALTER TABLE fact_table ADD FOREIGN KEY (store_key) REFERENCES store_dim(store_key);

COPY fact_table (payment_key,customer_key,time_key,item_key,store_key,quantity,unit,unit_price,total_price)
FROM 'D:\mauricio\Dev\ADA\banco_dados\Projeto\archive\fact_table.csv'
DELIMITER ','
CSV HEADER; 

SELECT * FROM fact_table LIMIT 10;

SELECT COUNT(*) FROM fact_table;

SELECT column_name, data_type, character_maximum_length
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE table_name = 'item_dim';