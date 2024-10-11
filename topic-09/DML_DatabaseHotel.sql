-- Inserting 10 records into Clients table
INSERT INTO Clients (name, numberofpeople, phone, email, regionid, passportid) VALUES
('John Doe', 2, '555-123-4561', 'john.doe@gmail.com', 1, 1),
('Jane Smith', 3, '555-123-4562', 'jane.smith@gmail.com', 2, 2),
('Carlos Rivera', 1, '555-123-4563', 'carlos.rivera@hotmail.com', 3, 3),
('Emily Johnson', 4, '555-123-4564', 'emily.johnson@yahoo.com', 4, 4),
('Ahmed Hassan', 2, '555-123-4565', 'ahmed.hassan@outlook.com', 5, 5),
('Olivia Brown', 3, '555-123-4566', 'olivia.brown@gmail.com', 6, 6),
('Luca Rossi', 5, '555-123-4567', 'luca.rossi@gmail.com', 7, 7),
('Isabella Garcia', 1, '555-123-4568', 'isabella.garcia@yahoo.com', 8, 8),
('William Lee', 4, '555-123-4569', 'william.lee@gmail.com', 9, 9),
('Sophia Martinez', 1, '555-123-4570', 'sophia.martinez@gmail.com', 10, 10);

-- Updating the email for client with clientid = 9
UPDATE Clients
SET email = 'william.lee.updated@gmail.com'
WHERE clientid = 9;

-- Deleting the client with clientid = 10
DELETE FROM Clients
WHERE clientid = 10;
