-- Step 1: Create roles with different permissions
-- Creating a read-only role
CREATE ROLE readonly_role;

-- Creating a read-write role
CREATE ROLE readwrite_role;

-- Step 2: Create users and assign roles to them
-- Creating user1 with read-only access
CREATE USER readonly_user WITH PASSWORD 'password123';
GRANT readonly_role TO readonly_user;

-- Creating user2 with read-write access
CREATE USER readwrite_user WITH PASSWORD 'password456';
GRANT readwrite_role TO readwrite_user;

-- Step 3: Grant privileges to the roles
-- Grant read-only privileges (SELECT) to the readonly_role on all tables in the public schema
GRANT CONNECT ON DATABASE your_database TO readonly_role;
GRANT USAGE ON SCHEMA public TO readonly_role;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly_role;

-- Grant read-write privileges (SELECT, INSERT, UPDATE, DELETE) to the readwrite_role on all tables in the public schema
GRANT CONNECT ON DATABASE your_database TO readwrite_role;
GRANT USAGE ON SCHEMA public TO readwrite_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO readwrite_role;

-- Step 4: (Optional) Ensure that future tables in the public schema inherit these privileges
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly_role;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO readwrite_role;
