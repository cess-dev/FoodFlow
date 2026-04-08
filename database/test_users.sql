-- =====================================================
-- FoodFlow - Test User Credentials & Setup
-- =====================================================
-- This file contains information about default users
-- and creates a test user with a known password
-- =====================================================

USE foodflow;

-- Display current users
SELECT 
    user_id,
    name AS username,
    email,
    role,
    status,
    created_at
FROM users;

-- =====================================================
-- DEFAULT USER PASSWORDS (SHA-256 hashed)
-- =====================================================
-- The passwords in sample_data.sql are SHA-256 hashes of:
-- 
-- User 1: 'Admin User' 
--   Password: admin123
--   Hash: 240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9
--
-- User 2: 'Department Head'
--   Password: head123
--   Hash: 7fb69d64d085e299af365f6783a4f0e3c77b6fd4bf14febdb3af8ba0416f777d
--
-- User 3: 'Store Keeper'
--   Password: keeper123
--   Hash: 3fef5c1bb564c29eb2f645042e37dbb360d322f66361148424f8b13258530c46
-- =====================================================

-- Create a test user with known credentials
-- Username/Name: Test User
-- Email: test@foodflow.com
-- Password: test1234
-- Role: STOREKEEPER
INSERT INTO users (name, email, password, role, status) VALUES
('Test User', 'test@foodflow.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'STOREKEEPER', 'ACTIVE');

-- Verify the test user was created
SELECT 
    user_id,
    name AS username,
    email,
    role,
    status
FROM users 
WHERE email = 'test@foodflow.com';

-- =====================================================
-- HOW TO LOGIN:
-- =====================================================
-- Option 1: Use existing users
--   Username: Admin User
--   Password: admin123
--
-- Option 2: Use test user (created above)
--   Username: Test User
--   Password: test1234
--
-- Option 3: Sign up for a new account
--   Go to: http://localhost:8080/mavenproject1/signup.jsp
--   Fill in the form with your details
--   Password must be at least 8 characters
-- =====================================================
