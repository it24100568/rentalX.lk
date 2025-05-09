<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" conitle>

    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            padding: 0;
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
        .profile-container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 1rem;
            display: flex;
            gap: 2rem;
        }
        .profile-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        .profile-photo-section {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .profile-photo {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #3b82f6;
            margin-bottom: 1rem;
        }
        .profile-details {
            flex: 2;
            background: white;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        .detail-row {
            display: flex;
            margin-bottom: 1rem;
        }
        .detail-label {
            font-weight: bold;
            width: 150px;
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
        .logo {
            font-weight: 600;
            font-size: 1.25rem;
        }
        .photo-upload {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 0.5rem;
        }
        .photo-upload input {
            display: none;
        }
        .photo-upload-label {
            cursor: pointer;
            color: #3b82f6;
            font-weight: 500;
            text-decoration: underline;
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
        <a href="bookingmanagement.jsp">Rental & Booking</a>
        <a href="payment-management.html">Payment Management</a>
        <a href="crud-operations.html">CRUD Operations</a>
        <a href="feedback-management.html">Feedback & Reviews</a>
    </div>
    <div>
        <button onclick="logout()">Logout</button>
    </div>
</nav>

<div class="profile-container">
    <!-- Profile Photo Section -->
    <div class="profile-photo-section">
        <img id="profilePhoto" src="https://via.placeholder.com/150" alt="Profile Photo" class="profile-photo">
        <div class="photo-upload">
            <input type="file" id="photoUpload" accept="image/*">
            <label for="photoUpload" class="photo-upload-label">Change Photo</label>
        </div>
    </div>

    <!-- Profile Details Section -->
    <div class="profile-details">
        <div class="profile-header">
            <h1>My Profile</h1>
            <button onclick="window.location.href='update-profile.html'">Edit Profile</button>
        </div>

        <div class="detail-row">
            <div class="detail-label">Full Name:</div>
            <div id="fullName"></div>
        </div>
        <div class="detail-row">
            <div class="detail-label">Email:</div>
            <div id="email"></div>
        </div>
        <div class="detail-row">
            <div class="detail-label">Phone:</div>
            <div id="phone"></div>
        </div>
        <div class="detail-row">
            <div class="detail-label">Member Since:</div>
            <div id="registrationDate"></div>
        </div>
    </div>
</div>
