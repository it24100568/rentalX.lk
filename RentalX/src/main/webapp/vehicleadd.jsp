<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Add Vehicle | RentalX</title>
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
    .add-card {
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
  </style>
</head>
<body>
<nav class="navbar">
  <div class="logo">
    <a href="index.jsp" style="color: white; text-decoration: none;">RentalX</a>
  </div>
  <div class="nav-links">
    <a href="dashboard.jsp">Dashboard</a>
    <a href="vehiclemanagement.jsp">Vehicle Management</a>
    <a href="vehicleadd.jsp" style="background-color: #2563eb;">Vehicle Add</a>
    <a href="editvehicle.jsp">Vehicle Edit</a>

  </div>
  <div>
    <button onclick="logout()">Logout</button>
  </div>
</nav>

<div class="container">
  <div class="add-card">
    <div class="page-header">
      <h1>Add New Vehicle</h1>
    </div>

    <div class="image-upload">
      <img src="https://via.placeholder.com/800x400?text=Vehicle+Image"
           alt="Vehicle Image" class="vehicle-image" id="previewImage">
      <input type="file" id="vehicleImage" name="image" accept="image/*" style="display: none;" required>
      <button type="button" onclick="document.getElementById('vehicleImage').click()">Upload Image</button>
    </div>

    <form action="add-vehicle" method="post" enctype="multipart/form-data">
      <div class="form-group">
        <label for="make">Make</label>
        <input type="text" id="make" name="make" required>
      </div>

      <div class="form-group">
        <label for="model">Model</label>
        <input type="text" id="model" name="model" required>
      </div>

      <div class="form-group">
        <label for="type">Type</label>
        <select id="type" name="type" required>
          <option value="">Select Vehicle Type</option>
          <option value="CAR">Car</option>
          <option value="BIKE">Bike</option>
          <option value="VAN">Van</option>
          <option value="SUV">SUV</option>
          <option value="TRUCK">Truck</option>
        </select>
      </div>

      <div class="form-group">
        <label for="year">Year</label>
        <input type="number" id="year" name="year" min="1900" max="2023" required>
      </div>

      <div class="form-group">
        <label for="color">Color</label>
        <input type="text" id="color" name="color">
      </div>

      <div class="form-group">
        <label for="license">License Plate</label>
        <input type="text" id="license" name="license" required>
      </div>

      <div class="form-group">
        <label for="price">Price per Day (LKR)</label>
        <input type="number" id="price" name="price" step="1000" required>
      </div>

      <div class="form-group">
        <label for="description">Description</label>
        <textarea id="description" name="description"></textarea>
      </div>

      <button type="submit" class="btn-save">Add Vehicle</button>
    </form>
  </div>
</div>

<script>
  function logout() {
    if (confirm('Are you sure you want to logout?')) {
      window.location.href = 'login.jsp';
    }
  }

  // Image preview functionality
  document.getElementById('vehicleImage').addEventListener('change', function(e) {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = function(event) {
        document.getElementById('previewImage').src = event.target.result;
      };
      reader.readAsDataURL(file);
    }
  });
</script>
</body>
</html>