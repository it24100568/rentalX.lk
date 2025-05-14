<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice | RentalX</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        /* Shared styles from your original CSS */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f3f4f6;
        }
        .navbar {
            background-color: #3b82f6;
            color: white;
            padding: 1rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-links {
            display: flex;
            gap: 1.5rem;
        }
        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 0.25rem;
            transition: background-color 0.3s;
        }
        .nav-links a:hover {
            background-color: #2563eb;
        }
        .logo {
            font-weight: 600;
            font-size: 1.25rem;
        }
        button {
            padding: 0.5rem 1rem;
            background-color: #3b82f6;
            color: white;
            border: none;
            border-radius: 0.375rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #2563eb;
        }
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 1rem;
        }

        /* Invoice-specific styles */
        .invoice-card {
            background: white;
            border-radius: 0.5rem;
            padding: 2rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        .invoice-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 2rem;
            border-bottom: 1px solid #e5e7eb;
            padding-bottom: 1rem;
        }
        .invoice-details {
            display: flex;
            gap: 3rem;
            margin-bottom: 2rem;
        }
        .detail-col {
            flex: 1;
        }
        .detail-row {
            margin-bottom: 0.75rem;
        }
        .detail-label {
            font-weight: 500;
            color: #6b7280;
        }
        .invoice-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }
        .invoice-table th, .invoice-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }
        .invoice-table th {
            background-color: #f9fafb;
        }
        .total-row {
            font-weight: 600;
            font-size: 1.1rem;
        }
        .invoice-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }
        .btn-print {
            background-color: #6b7280;
        }
        .btn-print:hover {
            background-color: #4b5563;
        }
        .btn-download {
            background-color: #10b981;
        }
        .btn-download:hover {
            background-color: #059669;
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="logo">
        <a href="index.jsp" style="color: white; text-decoration: none;">RentalX</a>
    </div>
    <div class="nav-links">
        <a href="profile.jsp">My Profile</a>
        <a href="paymentcheckout.jsp">Payment Checkout </a>
        <a href="invoice.jsp">Invoice </a>
        <a href="paymenthistory.jsp">Payment History</a>
    </div>
    <div>
        <button onclick="logout()">Logout</button>
    </div>
</nav>

<div class="container">
    <div class="invoice-card">
        <div class="invoice-header">
            <div>
                <h1>Invoice</h1>
                <div class="detail-row">
                    <span class="detail-label">Invoice #</span>
                    <span>INV-${payment.id}</span>
                </div>
                <div class="detail-row">
                    <span class="detail-label">Date</span>
                    <span>${payment.date}</span>
                </div>
            </div>
            <div style="text-align: right;">
                <img src="logo.png" alt="RentalX Logo" style="height: 50px; margin-bottom: 1rem;">
                <div>RentalX Vehicle Rentals</div>
                <div>123 Rental Street</div>
                <div>Colombo, Sri Lanka</div>
            </div>
        </div>

        <div class="invoice-details">
            <div class="detail-col">
                <h3>Billed To</h3>
                <div class="detail-row">
                    <div>${user.name}</div>
                    <div>${user.email}</div>
                    <div>${user.phone}</div>
                </div>
            </div>
            <div class="detail-col">
                <h3>Payment Method</h3>
                <div class="detail-row">
                    <div>${payment.method}</div>
                    <div>**** **** **** ${payment.lastFour}</div>
                </div>
            </div>
        </div>

        <table class="invoice-table">
            <thead>
            <tr>
                <th>Description</th>
                <th>Duration</th>
                <th>Rate</th>
                <th>Amount</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>${rental.vehicleMake} ${rental.vehicleModel}</td>
                <td>${rental.duration} days</td>
                <td>$${rental.dailyRate}/day</td>
                <td>$${rental.subtotal}</td>
            </tr>
            <tr>
                <td colspan="3">Taxes</td>
                <td>$${rental.taxes}</td>
            </tr>
            <tr class="total-row">
                <td colspan="3">Total</td>
                <td>$${rental.totalAmount}</td>
            </tr>
            </tbody>
        </table>

        <div class="invoice-actions">
            <button class="btn-print" onclick="window.print()">Print Invoice</button>
            <button class="btn-download">Download PDF</button>
        </div>
    </div>
</div>
<script>
    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = 'login.jsp';
        }
    }
</script>
</body>
</html>