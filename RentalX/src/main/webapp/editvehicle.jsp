<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Vehicle | RentalX</title>
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
            max-width: 800px;
            margin: 2rem auto;
            padding: 1rem;
        }
        .edit-card {
            background: white;
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            padding: 2rem;
        }
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
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
        input, select, textarea {
            width: 100%;
            padding: 0.5rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
        }
        .btn-save {
            background-color: #10b981;
            width: 100%;
            padding: 0.75rem;
            font-size: 1rem;
        }
        .btn-save:hover {
            background-color: #059669;
        }
        .btn-delete {
            background-color: #ef4444;
            margin-top: 1rem;
        }
        .btn-delete:hover {
            background-color: #dc2626;
        }
        .vehicle-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            border-radius: 0.5rem;
            margin-bottom: 1rem;
        }
        .image-upload {
            margin-bottom: 1.5rem;
        }
        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 9999px;
            font-size: 0.875rem;
            font-weight: 500;
        }
        .status-available {
            background-color: #d1fae5;
            color: #065f46;
        }
        .status-rented {
            background-color: #fee2e2;
            color: #991b1b;
        }
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
    <div class="edit-card">
        <div class="page-header">
            <h1>Edit Vehicle</h1>
            <span class="status-badge ${vehicle.available ? 'status-available' : 'status-rented'}">
                ${vehicle.available ? 'Available' : 'Rented'}
            </span>
        </div>

        <div class="image-upload">
            <img src="${vehicle.imageUrl != null ? vehicle.imageUrl : 'https://via.placeholder.com/800x400?text=Vehicle+Image'}"
                 alt="Vehicle Image" class="vehicle-image">
            <input type="file" id="vehicleImage" accept="image/*" style="display: none;">
            <button onclick="document.getElementById('vehicleImage').click()">Upload New Image</button>
        </div>

        <form action="update-vehicle" method="post">
            <input type="hidden" name="id" value="${vehicle.id}">

            <div class="form-group">
                <label for="model">Model</label>
                <input type="text" id="model" name="model" value="${vehicle.model}" required>
            </div>

            <div class="form-group">
                <label for="type">Type</label>
                <select id="type" name="type" required>
                    <option value="CAR" ${vehicle.type == 'CAR' ? 'selected' : ''}>Car</option>
                    <option value="BIKE" ${vehicle.type == 'BIKE' ? 'selected' : ''}>Bike</option>
                    <option value="VAN" ${vehicle.type == 'VAN' ? 'selected' : ''}>Van</option>
                    <option value="SUV" ${vehicle.type == 'SUV' ? 'selected' : ''}>SUV</option>
                    <option value="TRUCK" ${vehicle.type == 'TRUCK' ? 'selected' : ''}>Truck</option>
                </select>
            </div>

            <div class="form-group">
                <label for="year">Year</label>
                <input type="number" id="year" name="year" value="${vehicle.year}" min="1900" max="2023" required>
            </div>

            <div class="form-group">
                <label for="color">Color</label>
                <input type="text" id="color" name="color" value="${vehicle.color}">
            </div>

            <div class="form-group">
                <label for="license">License Plate</label>
                <input type="text" id="license" name="license" value="${vehicle.licensePlate}" required>
            </div>

            <div class="form-group">
                <label for="price">Price per Day ($)</label>
                <input type="number" id="price" name="price" step="0.01" value="${vehicle.pricePerDay}" required>
            </div>

            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description">${vehicle.description}</textarea>
            </div>

            <button type="submit" class="btn-save">Save Changes</button>
            <button type="button" class="btn-delete" onclick="confirmDelete()">Delete Vehicle</button>
        </form>
    </div>
</div>

<script>
    function logout() {
        if (confirm('Are you sure you want to logout?')) {
            window.location.href = 'login.jsp';
        }
    }

    function confirmDelete() {
        if (confirm('Are you sure you want to delete this vehicle? This action cannot be undone.')) {
            window.location.href = 'delete-vehicle?id=${vehicle.id}';
        }
    }

    // Preview image when a new one is selected
    document.getElementById('vehicleImage').addEventListener('change', function(e) {
        const file = e.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(event) {
                document.querySelector('.vehicle-image').src = event.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>