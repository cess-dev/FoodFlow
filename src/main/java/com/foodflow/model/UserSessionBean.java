package com.foodflow.model;

import java.io.Serializable;
import java.time.LocalDateTime;

public class UserSessionBean implements Serializable {

    private static final long serialVersionUID = 1L;

    private int userId;
    private String fullName;
    private String role;
    private LocalDateTime authenticatedAt;

    public UserSessionBean() {
        
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public LocalDateTime getAuthenticatedAt() {
        return authenticatedAt;
    }

    public void setAuthenticatedAt(LocalDateTime authenticatedAt) {
        this.authenticatedAt = authenticatedAt;
    }
}
