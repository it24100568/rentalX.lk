<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>RentalX - Vehicle Management</title>
    <style>
        /* Navigation Bar Styles */
        .navbar {
            background-color: #3b82f6;
            overflow: hidden;
            padding: 10px 20px;
            margin-bottom: 20px;
        }
        .navbar a {
            float: left;
            color: white;
            text-align: center;
            padding: 10px 16px;
            text-decoration: none;
            font-size: 16px;
        }
        .navbar a:hover {
            background-color: #2563eb;
        }
        .navbar-right {
            float: right;
        }

        /* Existing Body Styles */
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
        }
        .content {
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .form-group {
            margin-bottom: 15px;
        }
        button {
            padding: 5px 10px;
            cursor: pointer;
            background-color: #3b82f6;
            color: white;
            border: none;
            border-radius: 4px;
        }
        button:hover {
            background-color: #2563eb;
        }
        input, select {
            padding: 6px;
            width: 200px;
        }
    </style>
</head>
<body>
<!-- Navigation Bar -->
<div class="navbar">
    <a href="profile.jsp">Profile</a>
    <div class="navbar-right">
        <a href="login.jsp">Logout</a>
    </div>
</div>

<div class="content">
    <h1>Welcome, ${user}!</h1>
    <hr>

    <!-- Add Vehicle Form -->
    <h2>Add New Vehicle</h2>
    <form action="add-vehicle" method="post">
        <div class="form-group">
            <label>Model:</label>
            <input type="text" name="model" required>
        </div>
        <div class="form-group">
            <label>Type:</label>
            <select name="type" required>
                <option value="CAR">Car</option>
                <option value="BIKE">Bike</option>
                <option value="VAN">Van</option>
            </select>
        </div>
        <div class="form-group">
            <label>Price per Day ($):</label>
            <input type="number" name="price" step="0.01" required>
        </div>
        <button type="submit">Add Vehicle</button>
    </form>

    <!-- Search Vehicles -->
    <h2>Search Vehicles</h2>
    <form action="search-vehicles" method="get">
        <input type="text" name="query" placeholder="Search by model...">
        <button type="submit">Search</button>
    </form>

    <!-- Vehicle List -->
    <h2>Vehicle List</h2>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Model</th>
            <th>Type</th>
            <th>Price/Day ($)</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="vehicle" items="${vehicles}">
            <tr>
                <td>${vehicle.id}</td>
                <td>${vehicle.model}</td>
                <td>${vehicle.type}</td>
                <td>${vehicle.pricePerDay}</td>
                <td>
                    <a href="edit-vehicle?id=${vehicle.id}">Edit</a> |
                    <a href="delete-vehicle?id=${vehicle.id}" onclick="return confirm('Are you sure?')">Delete</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>