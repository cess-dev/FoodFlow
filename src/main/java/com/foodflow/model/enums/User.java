package com.catering.model;

import java.time.LocalDateTime;

public class User {
    private int userId;
    private String fullName;
    private String username;
    private String password; // Hashed
    private String email;
    private String phone;
    private Role role;
    private boolean isActive;
    private boolean accountLocked;
    private int loginAttempts;
    private LocalDateTime createdAt;
    private LocalDateTime lastLogin;
    private LocalDateTime passwordChangedAt;
    
    public enum Role {
        ADMIN("System Administrator"),
        MANAGER("Department Manager"),
        CLERK("Store Clerk");
        
        private String displayName;
        
        Role(String displayName) {
            this.displayName = displayName;
        }
        
        public String getDisplayName() {
            return displayName;
        }
    }
    
    // Check permissions
    public boolean canViewReports() {
        return role == Role.ADMIN || role == Role.MANAGER;
    }
    
    public boolean canManageUsers() {
        return role == Role.ADMIN;
    }
    
    public boolean canAddItems() {
        return role == Role.ADMIN || role == Role.MANAGER;
    }
    
    public boolean canRecordTransactions() {
        return true; // All roles can record supplies/usage/damage
    }
    
    // Getters and setters for all fields
    // ... (generate these in your IDE)
}
