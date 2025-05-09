<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vehicle Management | RentalX</title>
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
        .form-container {
            background: white;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        .form-row {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        .form-group {
            flex: 1;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        input, select {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
        }
        .vehicle-table {
            width: 100%;
            border-collapse: collapse;
            background: white;
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        .vehicle-table th, .vehicle-table td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e5e7eb;
        }
        .vehicle-table th {
            background-color: #f9fafb;
            font-weight: 600;
            color: #374151;
        }
        .vehicle-table tr:hover {
            background-color: #f9fafb;
        }
        .action-link {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            margin-right: 1rem;
        }
        .action-link:hover {
            text-decoration: underline;
        }
        .action-link.delete {
            color: #ef4444;
        }
        .search-box {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .search-box input {
            flex: 1;
            padding: 0.5rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
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
        <a href="vehiclemanagement.jsp">Vehicle Management</a>
<%--        <a href="book-vehicle.html">Book a Vehicle</a>--%>
<%--        <a href="rental-status.html">Rental Status</a>--%>
<%--        <a href="rental-history.html">Rental History</a>--%>
<%--    </div>--%>
    <div>
        <button onclick="logout()">Logout</button>
    </div>
</nav>

<div class="container">
    <div class="page-header">
        <h1>Vehicle Management</h1>
        <button onclick="window.location.href='addvehicle.jsp'">Add New Vehicle</button>
    </div>

    <!-- Search Box -->
    <form action="search-vehicles" method="get" class="search-box">
        <input type="text" name="query" placeholder="Search by model, type...">
        <button type="submit">Search</button>
    </form>

    <!-- Add Vehicle Form -->
    <div class="form-container">
        <h2>Add New Vehicle</h2>
        <form action="add-vehicle" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="model">Model</label>
                    <input type="text" id="model" name="model" required>
                </div>
                <div class="form-group">
                    <label for="type">Type</label>
                    <select id="type" name="type" required>
                        <option value="CAR">Car</option>
                        <option value="BIKE">Bike</option>
                        <option value="VAN">Van</option>
                        <option value="SUV">SUV</option>
                        <option value="TRUCK">Truck</option>
                    </select>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="price">Price per Day ($)</label>
                    <input type="number" id="price" name="price" step="0.01" required>
                </div>
                <div class="form-group">
                    <label for="year">Year</label>
                    <input type="number" id="year" name="year" min="1900" max="2023" required>
                </div>
            </div>
            <div class="form-row">
                <div class="form-group">
                    <label for="color">Color</label>
                    <input type="text" id="color" name="color">
                </div>
                <div class="form-group">
                    <label for="license">License Plate</label>
                    <input type="text" id="license" name="license" required>
                </div>
            </div>
            <button type="submit">Add Vehicle</button>
        </form>
    </div>

    <!-- Vehicle List -->
    <h2>Vehicle Inventory</h2>
    <table class="vehicle-table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Model</th>
            <th>Type</th>
            <th>Year</th>
            <th>Color</th>
            <th>Price/Day</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="vehicle" items="${vehicles}">
            <tr>
                <td>${vehicle.id}</td>
                <td>${vehicle.model}</td>
                <td>${vehicle.type}</td>
                <td>${vehicle.year}</td>
                <td>${vehicle.color}</td>
                <td>$${vehicle.pricePerDay}</td>
                <td>
                        <span style="color: ${vehicle.available ? '#10b981' : '#ef4444'}">
                                ${vehicle.available ? 'Available' : 'Rented'}
                        </span>
                </td>
                <td>
                    <a href="edit-vehicle?id=${vehicle.id}" class="action-link">Edit</a>
                    <a href="delete-vehicle?id=${vehicle.id}" class="action-link delete"
                       onclick="return confirm('Are you sure you want to delete this vehicle?')">Delete</a>
                </td>
            </tr>
<%--        </c:forEach>--%>
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