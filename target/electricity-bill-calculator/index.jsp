<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Electricity Bill Calculator</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.12.4.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <style>
        body {
            background: linear-gradient(135deg, #eef6ff, #ffffff);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        .card {
            border: none;
            border-radius: 18px;
            box-shadow: 0 12px 30px rgba(0, 0, 0, 0.10);
        }
        .result-box {
            animation: fadeIn 0.5s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(8px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-7 col-md-9 col-sm-12">
            <div class="card p-4 p-md-5">
                <div class="text-center mb-4">
                    <h2 class="fw-bold text-primary">Electricity Bill Calculator</h2>
                    <p class="text-muted mb-0">Calculate your electricity bill using slab-wise tariff rates.</p>
                </div>

                <form action="${pageContext.request.contextPath}/calculate" method="post" id="billForm">
                    <div class="mb-3">
                        <label for="customerName" class="form-label fw-semibold">Customer Name</label>
                        <input type="text" name="customerName" id="customerName" class="form-control form-control-lg" placeholder="e.g. John Doe" required value="${customerName}">
                    </div>

                    <div class="mb-3">
                        <label for="customerId" class="form-label fw-semibold">Customer ID</label>
                        <input type="text" name="customerId" id="customerId" class="form-control form-control-lg" placeholder="e.g. CUST-001" required value="${customerId}">
                    </div>

                    <div class="mb-3">
                        <label for="units" class="form-label fw-semibold">Enter Units Consumed</label>
                        <input type="number" step="0.01" min="0" name="units" id="units" class="form-control form-control-lg" placeholder="e.g. 180" required value="${units}">
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg w-100">Calculate Bill</button>
                </form>

                <div class="alert alert-danger mt-3 ${empty error ? 'd-none' : ''}" role="alert">
                    ${error}
                </div>

                <div class="result-box card mt-4 p-4 ${empty bill ? 'd-none' : ''}" id="resultBox">
                    <h4 class="text-success">Estimated Total Bill</h4>
                    <div class="mb-3 text-secondary">
                        <p class="mb-1"><strong>Customer Name:</strong> ${customerName}</p>
                        <p class="mb-1"><strong>Customer ID:</strong> ${customerId}</p>
                    </div>
                    <h3 class="fw-bold">${bill}</h3>
                    <div class="mt-3 text-secondary">
                        <p class="mb-1"><strong>Breakdown:</strong></p>
                        <div>${breakdown}</div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).ready(function () {
        $('#billForm').on('submit', function () {
            $('#resultBox').show();
        });
    });
</script>
</body>
</html>
