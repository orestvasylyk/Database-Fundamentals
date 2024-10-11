-- Horizontal View: Select all columns from the Clients table
CREATE VIEW ClientFullInfo AS
SELECT clientid, name, numberofpeople, phone, email, regionid, passportid
FROM Clients;

-- Vertical View: Select a subset of columns from the Clients table
CREATE VIEW ClientContactInfo AS
SELECT name, phone, email
FROM Clients;

-- Mixed View: Select columns with calculated fields
CREATE VIEW ClientSummary AS
SELECT 
    name, 
    numberofpeople, 
    CONCAT('Phone: ', phone) AS phone_with_label,
    CASE 
        WHEN numberofpeople > 1 THEN 'Group Client' 
        ELSE 'Individual Client' 
    END AS client_type
FROM Clients;

-- View with Joining: Join Clients and Regions tables
CREATE VIEW ClientRegionInfo AS
SELECT 
    c.clientid, 
    c.name, 
    c.phone, 
    r.regionname
FROM Clients c
JOIN Regions r ON c.regionid = r.regionid;

-- View with Subquery: Retrieve country name for each client based on their region
CREATE VIEW ClientCountryInfo AS
SELECT 
    c.clientid, 
    c.name, 
    (SELECT countryname 
     FROM Countries co 
     JOIN Regions r ON r.countryid = co.countryid 
     WHERE r.regionid = c.regionid) AS countryname
FROM Clients c;

-- View with Union: Combine Clients from two different regions (e.g., Kyiv and Lviv)
CREATE VIEW CombinedClientRegions AS
SELECT name, phone, regionid
FROM Clients
WHERE regionid = (SELECT regionid FROM Regions WHERE regionname = 'Kyiv')
UNION
SELECT name, phone, regionid
FROM Clients
WHERE regionid = (SELECT regionid FROM Regions WHERE regionname = 'Lviv');

-- View on View: Create a new view based on another view (ClientFullInfo)
CREATE VIEW ClientPhoneDirectory AS
SELECT clientid, name, phone
FROM ClientFullInfo;

-- View with Check Option: Clients from the Kyiv region only
CREATE VIEW KyivClients AS
SELECT clientid, name, phone, regionid
FROM Clients
WHERE regionid = (SELECT regionid FROM Regions WHERE regionname = 'Kyiv')
WITH CHECK OPTION;
