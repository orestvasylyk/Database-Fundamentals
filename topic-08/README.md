# Subtaks for topic 08. SQL DDL

Create Schema:

```CREATE DATABASE travel_agency;```

>    CREATE DATABASE: Creates a new database.

Create Resorts Table:

```
CREATE TABLE resorts (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  type VARCHAR(50) NOT NULL,
  quality INTEGER,
  location VARCHAR(100),
  price_range DECIMAL (10, 2)
);
```
>CREATE TABLE: Creates a new table.
>
>SERIAL: Automatically generates unique integer values for each new row inserted into a table.
>
>PRIMARY KEY: Defines the primary key for the table.


Create clients Table:
```
CREATE TABLE clients (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) UNIQUE NOT NULL,
  phone_number VARCHAR(20) NOT NULL
);
```


Create agents Table:
```
CREATE TABLE agents (
  id SERIAL PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  commission_percentage DECIMAL
);
```


Create photos Table:
```
CREATE TABLE photos (
  id SERIAL PRIMARY KEY,
  resort_id INTEGER,
  photo_name VARCHAR(255),
  photo_file VARCHAR(255),
  tags TEXT
);
```


Create comments Table:
```
CREATE TABLE comments (
  id SERIAL PRIMARY KEY,
  photo_id INTEGER,
  client_id INTEGER,
  comment_text TEXT,
  comment_date DATE
);
```


Create contracts Table:
```
CREATE TABLE contracts (
  id SERIAL PRIMARY KEY,
  client_id INTEGER,
  agent_id INTEGER,
  resort_id INTEGER,
  contract_date DATE,
  vacation_period VARCHAR(255)
```


Add Foreign Key to contracts table:
```
ALTER TABLE "contracts" ADD FOREIGN KEY ("client_id") REFERENCES "clients"("id");

ALTER TABLE "contracts" ADD FOREIGN KEY ("agent_id") REFERENCES "aqents"("id");

ALTER TABLE "contracts" ADD FOREIGN KEY ("resort_id") REFERENCES "resorts"("id");
```


Add Foreign Key to photos table:

`ALTER TABLE "photos" ADD FOREIGN KEY ("resort_id") REFERENCES "resorts"("id");`


Add Foreign Key to comments table:
```
ALTER TABLE "comments" ADD FOREIGN KEY ("photo_id") REFERENCES "photos"("id");
ALTER TABLE "comments" ADD FOREIGN KEY ("client_id") REFERENCES "clients"("id");
```

>ALTER TABLE: Used to modify the structure of an existing table in a database.

