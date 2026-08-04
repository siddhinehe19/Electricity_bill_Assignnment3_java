# Electricity Bill Calculator

A responsive Java web application built with `Servlet` + `JSP` and Bootstrap, using slab-based electricity tariff rules.

## Tariff Rules
- First 50 units: ₹3.50 per unit
- Next 100 units: ₹4.00 per unit
- Next 100 units: ₹5.20 per unit
- Above 250 units: ₹6.50 per unit

## Project Structure
- `src/main/java/com/example/ElectricityBillServlet.java` – servlet for bill calculation
- `src/main/webapp/index.jsp` – responsive UI with Bootstrap and jQuery
- `src/main/webapp/WEB-INF/web.xml` – deployment descriptor
- `pom.xml` – Maven build configuration

## Run
1. Install Maven on your system.
2. Open a terminal in the project folder.
3. Run:
   ```bash
   mvn clean package
   ```
4. Deploy the generated WAR file from `target/` into Tomcat.
5. Open:
   ```text
   http://localhost:8080/electricity-bill-calculator/
   ```
