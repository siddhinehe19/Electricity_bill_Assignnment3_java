# Electricity Bill Calculator

A responsive electricity bill estimator built with Java 17, Jakarta Servlet, and JSP. Usage is charged progressively by slab:

| Usage slab | Rate |
| --- | ---: |
| First 50 units | Rs. 3.50 per unit |
| Next 100 units (51–150) | Rs. 4.00 per unit |
| Next 100 units (151–250) | Rs. 5.20 per unit |
| Above 250 units | Rs. 6.50 per unit |

The estimate covers energy charges only; taxes and other utility fees are not included.

## Build and run

1. Run `mvn test package`.
2. Deploy `target/electricity-bill.war` to a Jakarta EE 10-compatible servlet container such as Apache Tomcat 10.1.
3. Open `http://localhost:8080/electricity-bill/bill`.

The application accepts whole, non-negative unit counts and displays the charge breakdown by slab.
