<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Vehicles | RentalX</title>
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
            margin-bottom: 2rem;
        }
        .search-container {
            background: white;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        .search-form {
            display: flex;
            gap: 1rem;
        }
        .search-input {
            flex: 1;
            padding: 0.5rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
        }
        .filter-row {
            display: flex;
            gap: 1rem;
            margin-top: 1rem;
        }
        .filter-group {
            flex: 1;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        select {
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
        .no-results {
            text-align: center;
            padding: 2rem;
            color: #6b7280;
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
    </div>
    <div>
        <button onclick="logout()">Logout</button>
    </div>
</nav>

<div class="container">
    <div class="page-header">
        <h1>Search Vehicles</h1>
    </div>

    <div class="search-container">
        <form action="search-vehicles" method="get" class="search-form">
            <input type="text" name="query" value="${param.query}" class="search-input" placeholder="Search by model, type, color...">
            <button type="submit">Search</button>
        </form>
        <div class="filter-row">
            <div class="filter-group">
                <label for="type">Vehicle Type</label>
                <select id="type" name="type" onchange="this.form.submit()">
                    <option value="">All Types</option>
                    <option value="CAR" ${param.type == 'CAR' ? 'selected' : ''}>Car</option>
                    <option value="BIKE" ${param.type == 'BIKE' ? 'selected' : ''}>Bike</option>
                    <option value="VAN" ${param.type == 'VAN' ? 'selected' : ''}>Van</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="status">Availability</label>
                <select id="status" name="status" onchange="this.form.submit()">
                    <option value="">All</option>
                    <option value="available" ${param.status == 'available' ? 'selected' : ''}>Available</option>
                    <option value="rented" ${param.status == 'rented' ? 'selected' : ''}>Rented</option>
                </select>
            </div>
        </div>
    </div>

    <table class="vehicle-table">
        <thead>
        <tr>
            <th>Model</th>
            <th>Type</th>
            <th>Year</th>
            <th>Color</th>
            <th>Price/Day</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
<%--        <c:choose>--%>
<%--            <c:when test="${not empty vehicles}">--%>
<%--                <c:forEach var="vehicle" items="${vehicles}">--%>
                    <tr>
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
                            <a href="edit-vehicle?id=${vehicle.id}" style="color: #3b82f6; text-decoration: none;">View/Edit</a>
                        </td>
                    </tr>
<%--                </c:forEach>--%>
<%--            </c:when>--%>
<%--            <c:otherwise>--%>
                <tr>
                    <td colspan="7" class="no-results">No vehicles found matching your search criteria</td>
                </tr>
<%--            </c:otherwise>--%>
<%--        </c:choose>--%>
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