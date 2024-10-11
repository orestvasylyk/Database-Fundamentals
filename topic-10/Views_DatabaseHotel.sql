-- Horizontal view
CREATE VIEW ClientFullInfo AS
SELECT clientid, name, numberofpeople, phone, email, regionid, passportid
FROM Clients;

-- Vertical view
CREATE VIEW ClientContactInfo AS
SELECT name, phone, email
FROM Clients;

-- Mixed view
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

-- View with joining
CREATE VIEW ClientRegionInfo AS
SELECT 
    c.clientid, 
    c.name, 
    c.phone, 
    r.regionname
FROM Clients c
JOIN Regions r ON c.regionid = r.regionid;

-- View with subquery
CREATE VIEW ClientCountryInfo AS
SELECT 
    c.clientid, 
    c.name, 
    (SELECT countryname 
     FROM Countries co 
     JOIN Regions r ON r.countryid = co.countryid 
     WHERE r.regionid = c.regionid) AS countryname
FROM Clients c;

-- View with union
CREATE VIEW CombinedClientRegions AS
SELECT name, phone, regionid
FROM Clients
WHERE regionid = (SELECT regionid FROM Regions WHERE regionname = 'Kyiv')
UNION
SELECT name, phone, regionid
FROM Clients
WHERE regionid = (SELECT regionid FROM Regions WHERE regionname = 'Lviv');

-- View on the select from another view
CREATE VIEW ClientPhoneDirectory AS
SELECT clientid, name, phone
FROM ClientFullInfo;

-- View with check option
CREATE VIEW KyivClients AS
SELECT clientid, name, phone, regionid
FROM Clients
WHERE regionid = (SELECT regionid FROM Regions WHERE regionname = 'Kyiv')
WITH CHECK OPTION;
