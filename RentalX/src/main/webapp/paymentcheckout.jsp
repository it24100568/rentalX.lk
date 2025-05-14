<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Checkout | RentalX</title>
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

        /* Payment-specific styles */
        .checkout-card {
            background: white;
            border-radius: 0.5rem;
            padding: 2rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        .payment-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 2rem;
        }
        .form-group {
            margin-bottom: 1.5rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        input, select {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
        }
        .payment-summary {
            background: #f9fafb;
            padding: 1.5rem;
            border-radius: 0.5rem;
            margin-bottom: 2rem;
        }
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
        }
        .total-row {
            border-top: 1px solid #e5e7eb;
            padding-top: 1rem;
            font-weight: 600;
            font-size: 1.1rem;
        }
        .btn-pay {
            background-color: #10b981;
            width: 100%;
            padding: 1rem;
            font-size: 1.1rem;
        }
        .btn-pay:hover {
            background-color: #059669;
        }
        .payment-methods {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .payment-method {
            flex: 1;
            text-align: center;
            padding: 1rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
            cursor: pointer;
            transition: all 0.3s;
        }
        .payment-method:hover {
            border-color: #3b82f6;
        }
        .payment-method.active {
            border-color: #3b82f6;
            background-color: #e0e7ff;
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
    <div class="checkout-card">
        <div class="payment-header">
            <h1>Payment Checkout</h1>
            <span>Order #RXL-${rental.id}</span>
        </div>

        <div class="payment-summary">
            <h3>Rental Summary</h3>
            <div class="summary-row">
                <span>${rental.vehicleMake} ${rental.vehicleModel}</span>
                <span>$${rental.dailyRate}/day</span>
            </div>
            <div class="summary-row">
                <span>Rental Period</span>
                <span>${rental.pickupDate} to ${rental.returnDate}</span>
            </div>
            <div class="summary-row">
                <span>Subtotal</span>
                <span>$${rental.subtotal}</span>
            </div>
            <div class="summary-row">
                <span>Taxes</span>
                <span>$${rental.taxes}</span>
            </div>
            <div class="summary-row total-row">
                <span>Total Amount</span>
                <span>$${rental.totalAmount}</span>
            </div>
        </div>

        <h3>Payment Method</h3>
        <div class="payment-methods">
            <div class="payment-method active" onclick="selectPaymentMethod(this, 'credit')">
                <i class="fas fa-credit-card"></i>
                <div>Card Payment</div>
            </div>

            </div>
        </div>

        <form id="paymentForm">
            <div class="form-group">
                <label for="cardNumber">Card Number</label>
                <input type="text" id="cardNumber" placeholder="1234 5678 9012 3456" required>
            </div>

            <div class="form-group">
                <label for="cardName">Name on Card</label>
                <input type="text" id="cardName" placeholder="John Doe" required>
            </div>

            <div class="form-row" style="display: flex; gap: 1rem;">
                <div class="form-group" style="flex: 1;">
                    <label for="expiryDate">Expiry Date</label>
                    <input type="text" id="expiryDate" placeholder="MM/YY" required>
                </div>
                <div class="form-group" style="flex: 1;">
                    <label for="cvv">CVV</label>
                    <input type="text" id="cvv" placeholder="123" required>
                </div>
            </div>

            <button type="submit" class="btn-pay">Pay $${rental.totalAmount}</button>
        </form>
    </div>
</div>

<script>
    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = 'login.jsp';
        }
    }

    function selectPaymentMethod(element, method) {
        document.querySelectorAll('.payment-method').forEach(el => {
            el.classList.remove('active');
        });
        element.classList.add('active');
        // You would set the selected payment method here
    }

    document.getElementById('paymentForm').addEventListener('submit', function(e) {
        e.preventDefault();
        // Process payment here
        alert('Payment processed successfully!');
        window.location.href = 'invoice.jsp?id=${rental.id}';
    });
</script>
</body>
</html>