# Changelog

All notable changes to this project will be documented in this file.

## [3.0.0] - 2026-06-28

This is a major release that transforms the project into a fully functioning containerized Banking Payment System with robust CI/CD validation.

### Added
- **Payment Processing Core**: Added `Transaction`, `PaymentException`, and `PaymentService` classes to the `server` module to handle bank transfers in memory with transaction history.
- **JUnit Test Suite**: Added a comprehensive suite of unit tests for the payment service covering successful transfers and edge-case exceptions.
- **Bank Dashboard**: Replaced the registration JSP stub with a modern, sleek glassmorphism dashboard in `webapp/index.jsp` to perform money transfers.
- **Payment Servlet**: Added `PaymentServlet` in `webapp` and registered it in `web.xml` to handle payments and display transactional receipts or detailed error logs.
- **GitHub Actions CI/CD**: Added a full validation pipeline in `.github/workflows/main.yml` that compiles the app with JDK 8, executes JUnit tests, uploads build artifacts, builds the Docker container, and validates Terraform/Packer syntax.
- **Packer Syntax Validation**: Integrated `packer validate` check into the CI workflow.

### Fixed
- **Dockerfile Copy Path**: Changed the target archive copy source from `./*.war` to `webapp/target/*.war` because compiled binaries reside in module build directories.
- **Docker Base Image**: Swapped out the private `andreichenko/mytomcat:v1.0` image for the public and official `tomcat:9.0-jre8-alpine` to fix pull access denied errors in CI.
- **Terraform Provider & Variables**:
  - Renamed variables and aliases using hyphens (e.g., `region-common`, `webserver-port`) to modern snake_case standard (`region_common`, `webserver_port`) to prevent parsing warnings.
  - Moved provider versions out of `provider.tf` into `backend.tf` block.
- **Packer Template Errors**: Fixed a missing closing bracket in the `secret_key` variables block inside all 5 Packer templates and renamed them from `.pkr.hcl` to `.json` to match their JSON format.

---

## [2.1.0] - Older Release

Older version containing early drafts of Packer and Terraform scripts for AWS deployments.
