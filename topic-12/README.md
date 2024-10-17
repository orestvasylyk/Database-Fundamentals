# Subtaks for topic 12. DB Administration

Script for Functions

1. Stored Procedure for Selecting and Inserting Clients
This stored procedure retrieves a client’s information and inserts a new client into the database.
```
CREATE OR REPLACE FUNCTION calculate_total_cost(room_rate DECIMAL, days INT) 
RETURNS DECIMAL AS $$
BEGIN
    RETURN room_rate * days;
END;
$$ LANGUAGE plpgsql;
```

2. Function to Get the Full Name of a Client
This function returns the full name of a client based on the client ID.
```
CREATE OR REPLACE FUNCTION get_client_name(client_id INT) 
RETURNS VARCHAR AS $$
DECLARE
    client_name VARCHAR;
BEGIN
    SELECT name INTO client_name FROM Clients WHERE clientid = client_id;
    RETURN client_name;
END;
$$ LANGUAGE plpgsql;
```

3. Function to Check Room Availability
This function checks whether a room is available between certain dates.
```
CREATE OR REPLACE FUNCTION is_room_available(room_id INT, start_date DATE, end_date DATE) 
RETURNS BOOLEAN AS $$
DECLARE
    room_count INT;
BEGIN
    SELECT COUNT(*) INTO room_count 
    FROM Bookings
    WHERE roomnumber = room_id 
    AND (checkindatetime, checkoutdatetime) OVERLAPS (start_date, end_date);
    
    IF room_count > 0 THEN
        RETURN FALSE;  -- Room is not available
    ELSE
        RETURN TRUE;   -- Room is available
    END IF;
END;
$$ LANGUAGE plpgsql;
```

Script for Stored Procedures

1. Stored Procedure for Selecting and Inserting Clients
This stored procedure retrieves a client’s information and inserts a new client into the database.
```
CREATE OR REPLACE PROCEDURE select_and_insert_client(
    new_name VARCHAR, new_phone VARCHAR, new_email VARCHAR, new_regionid INT, new_passportid INT
)
LANGUAGE plpgsql AS $$
BEGIN
    -- Select all clients
    RAISE NOTICE 'Current Clients:';
    FOR rec IN SELECT * FROM Clients LOOP
        RAISE NOTICE 'Client: %', rec.name;
    END LOOP;
    
    -- Insert a new client
    INSERT INTO Clients(name, phone, email, regionid, passportid)
    VALUES (new_name, new_phone, new_email, new_regionid, new_passportid);
    
    RAISE NOTICE 'New client inserted: %', new_name;
END;
$$;
```

2. Stored Procedure for Selecting and Inserting Room Bookings
This procedure checks if a room is available, and if it is, inserts a new booking.
```
CREATE OR REPLACE PROCEDURE select_and_insert_booking(
    client_id INT, room_id INT, checkin DATE, checkout DATE
)
LANGUAGE plpgsql AS $$
DECLARE
    is_available BOOLEAN;
BEGIN
    -- Check if the room is available
    is_available := is_room_available(room_id, checkin, checkout);
    
    IF is_available THEN
        -- Insert the booking if the room is available
        INSERT INTO Bookings(clientid, roomnumber, checkindatetime, checkoutdatetime)
        VALUES (client_id, room_id, checkin, checkout);
        
        RAISE NOTICE 'Booking successfully created for client % in room %.', client_id, room_id;
    ELSE
        RAISE NOTICE 'Room % is not available for the requested dates.', room_id;
    END IF;
END;
$$;
```

Script for Stored Procedures with UPDATE

1. Stored Procedure for Updating Client Information
This stored procedure updates the phone number and email of a client.
```
CREATE OR REPLACE PROCEDURE update_client_info(
    client_id INT, new_phone VARCHAR, new_email VARCHAR
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Clients
    SET phone = new_phone, email = new_email
    WHERE clientid = client_id;
    
    RAISE NOTICE 'Client % information updated successfully.', client_id;
END;
$$;
```

2. Stored Procedure for Updating Room Information
This stored procedure updates the room type and cost for a specific room.
```
CREATE OR REPLACE PROCEDURE update_room_info(
    room_id INT, new_roomtype VARCHAR, new_costperday DECIMAL
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE Rooms
    SET roomtype = new_roomtype, costperday = new_costperday
    WHERE roomnumber = room_id;
    
    RAISE NOTICE 'Room % information updated successfully.', room_id;
END;
$$;
```

