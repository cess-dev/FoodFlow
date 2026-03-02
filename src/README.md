Backend Guide

#Main Folder
## `config/` Directory

The `config` folder contains all the configuration files necessary for the backend to operate. It serves as the central place for setting up the system environment, database connections, security, and web-related settings. This folder ensures that other modules (DAO, service, controller) can easily access shared configurations.

### Key Files

- **`DatabaseConfig.java`**
  - Handles database connectivity.
  - Provides methods to get a database `Connection` object.
  - Used by DAO classes to interact with the database.
  - Supports connection pooling for efficient resource management.

- **`SecurityConfig.java`**
  - Manages role-based access and authentication logic.
  - Can contain helper methods to verify user roles or permissions.
  - Prepares the backend for integration with Spring Security or custom security checks.

- **`WebConfig.java`**
  - Configures servlet settings, filters, session management, and encoding.
  - Optional for small projects but useful for expanding web functionality.
  - Ensures consistent application behavior across all controllers.

### Purpose

The `config` directory is essential for separating system setup from business logic. By centralizing configuration here, the backend becomes more maintainable, flexible, and secure. All other modules rely on these configurations to function correctly.


