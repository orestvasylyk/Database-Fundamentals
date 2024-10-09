-- Countries Table (To store country information)
CREATE TABLE Countries (
    countryid SERIAL PRIMARY KEY,
    countryname VARCHAR(100) NOT NULL
);

-- Regions Table (To store region information, linked to Countries)
CREATE TABLE Regions (
    regionid SERIAL PRIMARY KEY,
    regionname VARCHAR(100) NOT NULL,
    countryid INT,
    FOREIGN KEY (countryid) REFERENCES Countries(countryid)
);

-- Clients Table (Must be created after Countries and Regions)
CREATE TABLE Clients (
    clientid SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    numberofpeople INT NOT NULL,
    passportdata VARCHAR(50) NOT NULL,
    phone VARCHAR(15),     email VARCHAR(100) NOT NULL,
    countryid INT,        -- Foreign key to Countries table
    regionid INT,         -- Foreign key to Regions table
    FOREIGN KEY (countryid) REFERENCES Countries(countryid),
    FOREIGN KEY (regionid) REFERENCES Regions(regionid)
);

-- Agents Table (Needed for the Orders and InsuranceContracts tables)
CREATE TABLE Agents (
    agentid SERIAL PRIMARY KEY,
    fullname VARCHAR(100) NOT NULL,
    commissionrate DECIMAL(5, 2) NOT NULL
);

-- Centralized Orders Table
CREATE TABLE Orders (
    orderid SERIAL PRIMARY KEY,
    clientid INT,
    orderdate DATE NOT NULL,
    totalamount DECIMAL(10, 2),
    orderstatus VARCHAR(50),
    FOREIGN KEY (clientid) REFERENCES Clients(clientid)
);

-- Orderlines Table
CREATE TABLE Orderlines (
    orderlineid SERIAL PRIMARY KEY,
    orderid INT,
    itemtype VARCHAR(50),  -- room, car, insurance
    quantity INT,
    unitprice DECIMAL(10, 2),
    subtotal DECIMAL(10, 2),
    FOREIGN KEY (orderid) REFERENCES Orders(orderid)
);

-- Rooms Table
CREATE TABLE Rooms (
    roomnumber INT PRIMARY KEY,
    numberofbeds INT,
    roomtype VARCHAR(50),
    costperday DECIMAL(10, 2)
);

-- CarModels Table (Needed before Cars)
CREATE TABLE CarModels (
    carmodelid SERIAL PRIMARY KEY,
    manufacturer VARCHAR(50),
    brand VARCHAR(50),
    cartype VARCHAR(50),
    costperday DECIMAL(10, 2)
);

-- Cars Table
CREATE TABLE Cars (
    carnumber INT PRIMARY KEY,
    carmodelid INT,
    color VARCHAR(50),
    FOREIGN KEY (carmodelid) REFERENCES CarModels(carmodelid)  -- Connect to CarModels
);

-- Bookings Table
CREATE TABLE Bookings (
    bookingid SERIAL PRIMARY KEY,
    orderlineid INT,
    roomnumber INT,
    checkindatetime TIMESTAMP,
    checkoutdatetime TIMESTAMP,
    FOREIGN KEY (orderlineid) REFERENCES Orderlines(orderlineid),
    FOREIGN KEY (roomnumber) REFERENCES Rooms(roomnumber)
);

-- Rental Agreements Table
CREATE TABLE RentalAgreements (
    agreementid SERIAL PRIMARY KEY,
    orderlineid INT,
    carnumber INT,
    rentalstartdate DATE,
    rentalenddate DATE,
    FOREIGN KEY (orderlineid) REFERENCES Orderlines(orderlineid),
    FOREIGN KEY (carnumber) REFERENCES Cars(carnumber)
);

-- Insurance Contracts Table
CREATE TABLE InsuranceContracts (
    insurancecontractid SERIAL PRIMARY KEY,
    orderlineid INT,
    agentid INT,
    insuranceamount DECIMAL(10, 2),
    premium DECIMAL(10, 2),
    signingdate DATE,
    expirydate DATE,
    cost DECIMAL(10, 2),
    FOREIGN KEY (orderlineid) REFERENCES Orderlines(orderlineid),
    FOREIGN KEY (agentid) REFERENCES Agents(agentid)
);
