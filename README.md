# FoodFlow

FoodFlow is a Jakarta Servlet + MySQL web application for school catering inventory work. The codebase currently contains the backend structure, database scripts, and early web layer for authentication, inventory, supply, usage, damage, reporting, and user management.

## Current Status

This repository is in an in-progress backend-first state.

- The domain and database design are defined in the repo.
- Core Java packages exist for config, controllers, DAOs, models, services, and utilities.
- Servlet routes are primarily mapped with annotations such as `@WebServlet`.
- The web entrypoint is still minimal, and several controllers/services are placeholders or partial implementations.
- There are currently no real automated tests in `src/test`.

## What Exists Today

### Backend

- Java 11 Maven WAR project
- Jakarta EE 10 API dependency
- Servlet controllers under `src/main/java/com/foodflow/controller`
- DAO classes under `src/main/java/com/foodflow/dao`
- Models and enums under `src/main/java/com/foodflow/model`
- Utility/config classes such as database connection, password handling, and role checks

### Database

- MySQL schema in [database/schema.sql](C:\Users\Byron\Documents\NetBeansProjects\FoodFlow\database\schema.sql)
- Sample data in [database/sample_data.sql](C:\Users\Byron\Documents\NetBeansProjects\FoodFlow\database\sample_data.sql)
- SQL query collections in [database/queries](C:\Users\Byron\Documents\NetBeansProjects\FoodFlow\database\queries)
- Setup and reference docs in the top-level [database](C:\Users\Byron\Documents\NetBeansProjects\FoodFlow\database) folder

### Web Layer

- `web.xml` is present but minimal and currently only sets session timeout.
- Annotation-based servlet mapping is the primary routing mechanism.
- `WebConfig.AppFilter` exists in code but is not currently registered, so it is not active.
- The default web entry page is still a placeholder.

## Canonical Database Folder

The repo-root [database](C:\Users\Byron\Documents\NetBeansProjects\FoodFlow\database) folder is the canonical source for SQL and database docs.

- Maven is configured to package that folder into the application resources at build time.
- Build output ends up under `target/classes/database` and `WEB-INF/classes/database`.
- `src/main/resources/database` is no longer the source of truth for SQL files.

## Project Structure

```text
FoodFlow/
├── database/                   # Canonical SQL scripts and database docs
├── docs/                       # Extra project documentation
├── scripts/                    # Helper scripts
├── src/
│   ├── main/
│   │   ├── java/com/foodflow/
│   │   │   ├── config/
│   │   │   ├── controller/
│   │   │   ├── dao/
│   │   │   ├── model/
│   │   │   ├── service/
│   │   │   └── util/
│   │   ├── resources/
│   │   └── webapp/
│   └── test/
├── pom.xml
└── README.md
```

## Tech Stack

- Java 11
- Jakarta EE 10 APIs
- Maven
- MySQL
- WAR packaging for deployment to a compatible servlet container

## Build And Run

### Prerequisites

- Java 11+
- Maven 3.6+
- MySQL 8+
- A servlet container such as Tomcat

### Database Setup

```bash
mysql -u root -p < database/schema.sql
mysql -u root -p foodflow < database/sample_data.sql
```

### Build

```bash
mvn clean package
```

The build produces a WAR and packages the canonical `database/` folder into the application classpath.

## Implementation Notes

- `DatabaseConfig` currently uses `DriverManager` with hardcoded local connection settings.
- `SecurityConfig` provides basic role/permission helpers.
- Some code and docs still reference older naming or planned features, so expect ongoing cleanup.
- If you are looking for the actual packaged SQL resources, check the build output under `target/classes/database`.

## Next Cleanup Targets

- Align docs with the code and schema as implementation evolves.
- Register shared web filters only if they are actually needed.
- Replace placeholder pages and forwards with real JSP or view templates.
- Add tests around DAO and controller behavior.
