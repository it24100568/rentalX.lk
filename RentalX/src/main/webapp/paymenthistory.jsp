<%@ page contentType="text/html;charset=UTF-8" %>
<%--<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment History | RentalX</title>
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
            max-width: 1200px;
            margin: 2rem auto;
            padding: 1rem;
        }

        /* Payment history specific styles */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        .search-box {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        .search-box input {
            flex: 1;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
        }
        .payment-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        .payment-table th, .payment-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }
        .payment-table th {
            background-color: #f9fafb;
            font-weight: 600;
        }
        .payment-method {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .payment-status {
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
        }
        .status-completed {
            background-color: #d1fae5;
            color: #065f46;
        }
        .status-pending {
            background-color: #fef3c7;
            color: #92400e;
        }
        .status-failed {
            background-color: #fee2e2;
            color: #991b1b;
        }
        .action-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
        }
        .action-link:hover {
            text-decoration: underline;
        }
        .pagination {
            display: flex;
            justify-content: center;
            gap: 0.5rem;
            margin-top: 2rem;
        }
        .page-link {
            padding: 0.5rem 1rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
            text-decoration: none;
            color: #4b5563;
        }
        .page-link.active {
            background-color: #3b82f6;
            color: white;
            border-color: #3b82f6;
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
    <div class="page-header">
        <h1>Payment History</h1>
        <button onclick="window.location.href='payment-checkout.jsp'">Make Payment</button>
    </div>

    <div class="search-box">
        <input type="text" placeholder="Search payments...">
        <button>Search</button>
    </div>

    <table class="payment-table">
        <thead>
        <tr>
            <th>Payment ID</th>
            <th>Date</th>
            <th>Method</th>
            <th>Amount</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="payment" items="${payments}">
            <tr>
                <td>${payment.id}</td>
                <td>${payment.date}</td>
                <td class="payment-method">
                    <c:choose>
                        <c:when test="${payment.method == 'Credit Card'}">
                            <i class="fas fa-credit-card"></i>
                        </c:when>
                        <c:when test="${payment.method == 'Debit Card'}">
                            <i class="fas fa-credit-card"></i>
                        </c:when>
                        <c:when test="${payment.method == 'PayPal'}">
                            <i class="fab fa-paypal"></i>
                        </c:when>
                    </c:choose>
                        ${payment.method}
                </td>
                <td>$${payment.amount}</td>
                <td>
                        <span class="payment-status ${payment.status == 'Completed' ? 'status-completed' :
                                                payment.status == 'Pending' ? 'status-pending' : 'status-failed'}">
                                ${payment.status}
                        </span>
                </td>
                <td>
                    <a href="invoice.jsp?id=${payment.id}" class="action-link">View Invoice</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="pagination">
        <a href="#" class="page-link">Previous</a>
        <a href="#" class="page-link active">1</a>
        <a href="#" class="page-link">2</a>
        <a href="#" class="page-link">3</a>
        <a href="#" class="page-link">Next</a>
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