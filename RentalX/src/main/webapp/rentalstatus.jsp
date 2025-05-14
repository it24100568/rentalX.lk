<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rental Status | RentalX</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
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
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }
        th {
            background-color: #f9fafb;
            font-weight: 600;
        }
        .status-active {
            color: #10b981;
            font-weight: 500;
        }
        .status-completed {
            color: #64748b;
            font-weight: 500;
        }
        .status-cancelled {
            color: #ef4444;
            font-weight: 500;
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
        <a href="bookingmanagement.jsp">Book a Vehicle</a>
        <a href="rentalstatus.jsp" style="background-color: #2563eb;">Rental Status</a>
        <a href="rentalhistory.jsp">Rental History</a>
    </div>
    <div>
        <button onclick="logout()">Logout</button>
    </div>
</nav>

<div class="container">
    <div class="page-header">
        <h1>Current Rentals</h1>
        <button onclick="window.location.href='bookingmanagement.jsp'">Book Another Vehicle</button>
    </div>

    <table>
        <thead>
        <tr>
            <th>Rental ID</th>
            <th>Vehicle</th>
            <th>Pickup Date</th>
            <th>Return Date</th>
            <th>Total Cost</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>R1001</td>
            <td>Toyota Camry</td>
            <td>2023-06-15</td>
            <td>2023-06-20</td>
            <td>LKR 5,000</td>

        <tr>
            <td>R1002</td>
            <td>Honda CR-V</td>
            <td>2023-06-18</td>
            <td>2023-06-25</td>
            <td>LKR 15,000</td>
        </tr>
        </tbody>
    </table>
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