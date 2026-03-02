CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL, -- Store hashed passwords only!
    email VARCHAR(100),
    phone VARCHAR(20),
    
    -- User Role (this controls access)
    role ENUM('admin', 'manager', 'clerk') NOT NULL DEFAULT 'clerk',
    
    -- Account Status
    is_active BOOLEAN DEFAULT TRUE,
    account_locked BOOLEAN DEFAULT FALSE,
    login_attempts INT DEFAULT 0,
    
    -- Timestamps
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    password_changed_at TIMESTAMP NULL,
    
    -- Additional Info
    department VARCHAR(50) DEFAULT 'Catering',
    employee_id VARCHAR(50),
    
    INDEX idx_role (role),
    INDEX idx_username (username),
    INDEX idx_active (is_active)
);

-- Insert default users (passwords should be hashed in real app)
-- Use password_hash('password', PASSWORD_DEFAULT) in PHP/Java
INSERT INTO users (full_name, username, password, role) VALUES
('System Admin', 'admin', '$2y$10$YourHashedPasswordHere', 'admin'),
('Catering Manager', 'manager', '$2y$10$YourHashedPasswordHere', 'manager'),
('Store Clerk One', 'clerk1', '$2y$10$YourHashedPasswordHere', 'clerk'),
('Store Clerk Two', 'clerk2', '$2y$10$YourHashedPasswordHere', 'clerk');

-- Create table for user activity log (audit trail)
CREATE TABLE user_activity_log (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    action VARCHAR(100) NOT NULL,
    module VARCHAR(50),
    description TEXT,
    ip_address VARCHAR(45),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    INDEX idx_user (user_id),
    INDEX idx_timestamp (timestamp)
);

-- Example: Track who did what
INSERT INTO user_activity_log (user_id, action, module, description, ip_address) 
VALUES (3, 'ADD_SUPPLY', 'inventory', 'Added 50kg Sugar', '192.168.1.100');