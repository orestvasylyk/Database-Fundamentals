# Subtaks for topic 08. SQL DDL

Countries Table
```
CREATE TABLE Countries (
    countryid SERIAL PRIMARY KEY,
    countryname VARCHAR(100) NOT NULL
);
```
Regions Table (linked to Countries)
```
CREATE TABLE Regions (
    regionid SERIAL PRIMARY KEY,
    regionname VARCHAR(100) NOT NULL,
    countryid INT,
    FOREIGN KEY (countryid) REFERENCES Countries(countryid)
);
```

Clients Table (linked to Regions and PassportDetails)
```
CREATE TABLE Clients (
    clientid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    numberofpeople INT NOT NULL,
    phone VARCHAR(15),
    email VARCHAR(100) NOT NULL,
    regionid INT,         -- Foreign key to Regions table
    passportid INT,       -- Foreign key to PassportDetails table (One-way relationship)
    FOREIGN KEY (regionid) REFERENCES Regions(regionid),
    FOREIGN KEY (passportid) REFERENCES PassportDetails(passportid)
);
```

PassportDetails Table (No reference back to Clients, one-way relationship)
```
CREATE TABLE PassportDetails (
    passportid SERIAL PRIMARY KEY,
    series VARCHAR(10) NOT NULL,
    number VARCHAR(20) NOT NULL,
    issued_by VARCHAR(100),       -- Issuing authority
    issued_date DATE              -- Issue date of the passport
);
```

Agents Table
```
CREATE TABLE Agents (
    agentid SERIAL PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    commissionrate DECIMAL(5, 2) NOT NULL
);
```

Rooms Table (Stores details about hotel rooms)
```
CREATE TABLE Rooms (
    roomnumber INT PRIMARY KEY,
    numberofbeds INT,
    roomtype VARCHAR(50),
    costperday DECIMAL(10, 2)
);
```

Centralized Orders Table (links orders for room bookings, car rentals, insurance)
```
CREATE TABLE Orders (
    orderid SERIAL PRIMARY KEY,
    clientid INT,
    orderdate DATE NOT NULL,
    totalamount DECIMAL(10, 2),
    orderstatus VARCHAR(50),
    FOREIGN KEY (clientid) REFERENCES Clients(clientid)
);
```

Orderlines Table (links orders to rooms, cars, or insurance)
```
CREATE TABLE Orderlines (
    orderlineid SERIAL PRIMARY KEY,
    orderid INT,
    itemtype VARCHAR(50),  -- room, car, insurance
    quantity INT,
    unitprice DECIMAL(10, 2),
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (orderid) REFERENCES Orders(orderid)
);
```

Bookings Table (Clients booking rooms, linked to orderlines)
```
CREATE TABLE Bookings (
    bookingid SERIAL PRIMARY KEY,
    roomnumber INT,
    checkindatetime TIMESTAMP,
    checkoutdatetime TIMESTAMP,
    orderlineid INT, -- Linked to the Orderlines table
    FOREIGN KEY (roomnumber) REFERENCES Rooms(roomnumber),
    FOREIGN KEY (orderlineid) REFERENCES Orderlines(orderlineid)
);
```
Room Popularity Table (Stores room ratings or likes)
```
CREATE TABLE RoomPopularity (
    popularityid SERIAL PRIMARY KEY,
    roomnumber INT,
    likes INT DEFAULT 0,   -- You can track likes or ratings
    FOREIGN KEY (roomnumber) REFERENCES Rooms(roomnumber)
);
```

CarModels Table (Details about different car models)
```
CREATE TABLE CarModels (
    carmodelid SERIAL PRIMARY KEY,
    manufacturer VARCHAR(50),
    brand VARCHAR(50),
    cartype VARCHAR(50),
    costperday DECIMAL(10, 2)
);
```

Cars Table (Details about the cars available for rent)
```
CREATE TABLE Cars (
    carnumber INT PRIMARY KEY,
    carmodelid INT,
    color VARCHAR(50),
    FOREIGN KEY (carmodelid) REFERENCES CarModels(carmodelid)
);
```

Rental Agreements Table (Car rental details, linked to an orderline)
```
CREATE TABLE RentalAgreements (
    agreementid SERIAL PRIMARY KEY,
    carnumber INT,
    rentalstartdate DATE,
    rentalenddate DATE,
    orderlineid INT, -- Linked to the Orderlines table
    FOREIGN KEY (carnumber) REFERENCES Cars(carnumber),
    FOREIGN KEY (orderlineid) REFERENCES Orderlines(orderlineid)
);
```

Insurance Contracts Table (Insurance details linked to car rentals and agents)
```
CREATE TABLE InsuranceContracts (
    insurancecontractid SERIAL PRIMARY KEY,
    orderlineid INT,
    agentid INT, -- Linked to Agents
    insuranceamount DECIMAL(10, 2),
    premium DECIMAL(10, 2),
    signingdate DATE,
    expirydate DATE,
    cost DECIMAL(10, 2),
    FOREIGN KEY (orderlineid) REFERENCES Orderlines(orderlineid),
    FOREIGN KEY (agentid) REFERENCES Agents(agentid)
);
```

Agent Commissions Table (Now only linked to InsuranceContracts)
```
CREATE TABLE AgentCommissions (
    commissionid SERIAL PRIMARY KEY,
    insurancecontractid INT, -- Linked to InsuranceContracts (which already links to Agents)
    commissionamount DECIMAL(10, 2),
    FOREIGN KEY (insurancecontractid) REFERENCES InsuranceContracts(insurancecontractid)
);
```
