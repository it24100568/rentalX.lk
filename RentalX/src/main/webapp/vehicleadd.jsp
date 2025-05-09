<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add Vehicle | RentalX</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0; padding: 0;
            background-color: #f3f4f6;
        }
        .navbar {
            background-color: #3b82f6; color: white;
            padding: 1rem; display: flex;
            justify-content: space-between; align-items: center;
        }
        .nav-links { display: flex; gap: 1.5rem; }
        .nav-links a {
            color: white; text-decoration: none; font-weight: 500;
            padding: 0.5rem 1rem; border-radius: 0.25rem;
            transition: background-color 0.3s;
        }
        .nav-links a:hover { background-color: #2563eb; }
        .logo { font-weight: 600; font-size: 1.25rem; }
        button {
            padding: 0.5rem 1rem; background-color: #3b82f6; color: white;
            border: none; border-radius: 0.375rem; cursor: pointer;
            transition: background-color 0.3s;
        }
        button:hover { background-color: #2563eb; }
        .container {
            max-width: 1200px; margin: 2rem auto; padding: 1rem;
        }
        table { width: 100%; border-collapse: collapse; margin-top: 1rem; }
        th, td {
            text-align: left; padding: 0.75rem;
            border-bottom: 1px solid #e5e7eb;
        }

        body { font-family: 'Poppins', sans-serif; margin: 0; padding: 0; background-color: #f3f4f6; }
        .container { max-width: 800px; margin: 2rem auto; padding: 2rem; background: white; border-radius: 0.5rem; box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1); }
        .form-group { margin-bottom: 1.5rem; }
        label { display: block; margin-bottom: 0.5rem; font-weight: 500; }
        input, select, textarea { width: 100%; padding: 0.75rem; border: 1px solid #d1d5db; border-radius: 0.375rem; }
        button { padding: 0.75rem 1.5rem; background-color: #3b82f6; color: white; border: none; border-radius: 0.375rem; cursor: pointer; }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="logo">
        <a href="index.jsp" style="color: white; text-decoration: none;">RentalX</a>
    </div>
    <div class="nav-links">
        <a href="dashboard.jsp">Dashboard </a>
        <a href="vehiclemanagement.jsp">Vehicle Management </a>
        <a href="editvehicle.jsp">Edit Vehicle </a>
        <a href="vehicleadd.jsp">Add Vehicle </a>
    </div>
    <div>
        <button onclick="logout()">Logout</button>
    </div>
</nav>

<div class="container">
    <h1>Add New Vehicle</h1>
    <form action="VehicleAddServlet" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="make">Make</label>
            <input type="text" id="make" name="make" required>
        </div>
        <div class="form-group">
            <label for="model">Model</label>
            <input type="text" id="model" name="model" required>
        </div>
        <div class="form-group">
            <label for="type">Vehicle Type</label>
            <select id="type" name="type" required>
                <option value="sedan">Sedan</option>
                <option value="suv">SUV</option>
                <option value="truck">Truck</option>
                <option value="luxury">Luxury</option>
            </select>
        </div>
        <div class="form-group">
            <label for="price">Daily Price (LKR)</label>
            <input type="number" id="price" name="price" required>
        </div>
        <div class="form-group">
            <label for="image">Vehicle Image</label>
            <input type="file" id="image" name="image" accept="image/*" required>
        </div>
        <div class="form-group">
            <label for="features">Features (comma separated)</label>
            <textarea id="features" name="features" rows="3">5 Seats, Automatic, AC</textarea>
        </div>
        <button type="submit">Add Vehicle</button>
    </form>
</div>
</body>
</html>