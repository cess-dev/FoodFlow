package com.foodflow.util;

/**
 * Test utility to verify password hashing and verification
 * Run this to test if passwords are being hashed/verified correctly
 */
public class PasswordTest {
    
    public static void main(String[] args) {
        System.out.println("=== PASSWORD HASHING TEST ===\n");
        
        // Test passwords
        String[] testPasswords = {
            "admin123",
            "head123",
            "keeper123",
            "test1234",
            "MyPassword123!"
        };
        
        for (String password : testPasswords) {
            String hash = PasswordUtil.hashPassword(password);
            boolean verify = PasswordUtil.verifyPassword(password, hash);
            
            System.out.println("Password: " + password);
            System.out.println("Hash: " + hash);
            System.out.println("Hash Length: " + hash.length());
            System.out.println("Verification: " + (verify ? "✓ PASS" : "✗ FAIL"));
            System.out.println();
        }
        
        // Test with stored hashes from database
        System.out.println("=== TESTING DATABASE HASHES ===\n");
        
        String[][] dbUsers = {
            {"Admin User", "240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9", "admin123"},
            {"Department Head", "7fb69d64d085e299af365f6783a4f0e3c77b6fd4bf14febdb3af8ba0416f777d", "head123"},
            {"Store Keeper", "3fef5c1bb564c29eb2f645042e37dbb360d322f66361148424f8b13258530c46", "keeper123"},
            {"Test User", "ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f", "test1234"}
        };
        
        for (String[] user : dbUsers) {
            String name = user[0];
            String storedHash = user[1];
            String plainPassword = user[2];
            
            boolean verify = PasswordUtil.verifyPassword(plainPassword, storedHash);
            
            System.out.println("User: " + name);
            System.out.println("Expected Hash: " + storedHash);
            System.out.println("Password: " + plainPassword);
            System.out.println("Verification: " + (verify ? "✓ PASS" : "✗ FAIL"));
            System.out.println();
        }
        
        System.out.println("=== TEST COMPLETE ===");
    }
}
