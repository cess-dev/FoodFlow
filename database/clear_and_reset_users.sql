-- =====================================================
-- FoodFlow - Clear Users and Reset Database
-- =====================================================
-- This script clears all users and inserts fresh test users
-- with properly hashed passwords
-- =====================================================

USE foodflow;

-- Clear all existing users (be careful with foreign key constraints)
-- First, clear dependent tables if needed
DELETE FROM system_logs WHERE user_id IS NOT NULL;
DELETE FROM store_requests;
DELETE FROM request_details;
DELETE FROM damage_log;
DELETE FROM issue_transactions;
DELETE FROM borrow_transactions;
DELETE FROM supply;

-- Now clear all users
DELETE FROM users;

-- Reset auto-increment
ALTER TABLE users AUTO_INCREMENT = 1;

-- =====================================================
-- Insert Fresh Test Users with SHA-256 Hashed Passwords
-- =====================================================
-- Password hashing: SHA-256
-- All passwords are hashed using PasswordUtil.hashPassword()
-- =====================================================

-- User 1: Admin
-- Name: Admin User
-- Password: admin123
-- Hash: SHA-256("admin123")
INSERT INTO users (name, email, password, role, status) VALUES
('Admin User', 'admin@foodflow.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', 'ADMIN', 'ACTIVE');

-- User 2: Department Head
-- Name: Department Head
-- Password: head123
-- Hash: SHA-256("head123")
INSERT INTO users (name, email, password, role, status) VALUES
('Department Head', 'head@foodflow.com', '7fb69d64d085e299af365f6783a4f0e3c77b6fd4bf14febdb3af8ba0416f777d', 'DEPARTMENT_HEAD', 'ACTIVE');

-- User 3: Storekeeper
-- Name: Store Keeper
-- Password: keeper123
-- Hash: SHA-256("keeper123")
INSERT INTO users (name, email, password, role, status) VALUES
('Store Keeper', 'keeper@foodflow.com', '3fef5c1bb564c29eb2f645042e37dbb360d322f66361148424f8b13258530c46', 'STOREKEEPER', 'ACTIVE');

-- User 4: Test User (easy to remember)
-- Name: Test User
-- Password: test1234
-- Hash: SHA-256("test1234")
INSERT INTO users (name, email, password, role, status) VALUES
('Test User', 'test@foodflow.com', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'STOREKEEPER', 'ACTIVE');

-- =====================================================
-- Verify Users Were Created
-- =====================================================
SELECT 
    user_id,
    name AS 'Username (Use this to login)',
    email AS 'Email',
    role AS 'Role',
    status AS 'Status',
    LENGTH(password) AS 'Password Hash Length',
    created_at AS 'Created'
FROM users
ORDER BY user_id;

-- =====================================================
-- LOGIN CREDENTIALS SUMMARY
-- =====================================================
-- 
-- IMPORTANT: Login uses the 'name' field (Full Name)
-- 
-- Username: Admin User
-- Password: admin123
-- Role: ADMIN
-- 
-- Username: Department Head
-- Password: head123
-- Role: DEPARTMENT_HEAD
-- 
-- Username: Store Keeper
-- Password: keeper123
-- Role: STOREKEEPER
-- 
-- Username: Test User
-- Password: test1234
-- Role: STOREKEEPER
-- 
-- =====================================================
