-- scripts/seed.sql
-- This script inserts the initial set of skills into the database.
-- It uses ON CONFLICT DO NOTHING to prevent errors if the skills already exist.

INSERT INTO skill (id, name) VALUES
                                 (gen_random_uuid(), 'Java'),
                                 (gen_random_uuid(), 'Spring Boot'),
                                 (gen_random_uuid(), 'Database Design'),
                                 (gen_random_uuid(), 'Frontend Development')
    ON CONFLICT (name) DO NOTHING;

-- You can add more seed data here for other tables as needed.
-- For example, to create a test user, you would need to generate a UUID
-- and a hashed password and insert them into the app_user table.
