<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Vehicle | RentalX</title>
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
        .vehicle-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }
        .vehicle-card {
            background: white;
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s;
        }
        .vehicle-card:hover {
            transform: translateY(-5px);
        }
        .vehicle-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .vehicle-details {
            padding: 1.5rem;
        }
        .vehicle-name {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }
        .vehicle-price {
            color: #3b82f6;
            font-weight: 500;
            margin-bottom: 1rem;
        }
        .vehicle-features {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }
        .feature-badge {
            background-color: #e0e7ff;
            color: #3b82f6;
            padding: 0.25rem 0.5rem;
            border-radius: 9999px;
            font-size: 0.75rem;
        }
        .search-filters {
            background: white;
            padding: 1.5rem;
            border-radius: 0.5rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            margin-bottom: 2rem;
        }
        .filter-row {
            display: flex;
            gap: 1rem;
            margin-bottom: 1rem;
        }
        .filter-group {
            flex: 1;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        select, input {
            width: 100%;
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
        <a href="book-vehicle.html">Book a Vehicle</a>
        <a href="rental-status.html">Rental Status</a>
        <a href="rental-history.html">Rental History</a>
    </div>
    <div>
        <button onclick="logout()">Logout</button>
    </div>
</nav>

<div class="container">
    <div class="page-header">
        <h1>Book a Vehicle</h1>
        <button onclick="window.location.href='rental-status.html'">View My Rentals</button>
    </div>

    <div class="search-filters">
        <h3>Search Filters</h3>
        <div class="filter-row">
            <div class="filter-group">
                <label for="vehicle-type">Vehicle Type</label>
                <select id="vehicle-type">
                    <option value="">All Types</option>
                    <option value="sedan">Sedan</option>
                    <option value="suv">SUV</option>
                    <option value="truck">Truck</option>
                    <option value="luxury">Luxury</option>
                </select>
            </div>
            <div class="filter-group">
                <label for="price-range">Price Range</label>
                <select id="price-range">
                    <option value="">Any Price</option>
                    <option value="0-50">$0 - $50/day</option>
                    <option value="50-100">$50 - $100/day</option>
                    <option value="100-200">$100 - $200/day</option>
                    <option value="200+">$200+/day</option>
                </select>
            </div>
        </div>
        <div class="filter-row">
            <div class="filter-group">
                <label for="pickup-date">Pickup Date</label>
                <input type="date" id="pickup-date">
            </div>
            <div class="filter-group">
                <label for="return-date">Return Date</label>
                <input type="date" id="return-date">
            </div>
            <div class="filter-group" style="align-self: flex-end;">
                <button style="width: 100%;">Search</button>
            </div>
        </div>
    </div>

    <div class="vehicle-grid">
        <!-- Vehicle Card 1 -->
        <div class="vehicle-card">
            <img src="https://via.placeholder.com/300x200?text=Sedan" alt="Sedan" class="vehicle-image">
            <div class="vehicle-details">
                <h3 class="vehicle-name">Toyota Camry</h3>
                <div class="vehicle-price">$45/day</div>
                <div class="vehicle-features">
                    <span class="feature-badge">5 Seats</span>
                    <span class="feature-badge">Automatic</span>
                    <span class="feature-badge">AC</span>
                </div>
                <button style="width: 100%;" onclick="window.location.href='book-details.html?id=1'">Book Now</button>
            </div>
        </div>

        <!-- Vehicle Card 2 -->
        <div class="vehicle-card">
            <img src="https://via.placeholder.com/300x200?text=SUV" alt="SUV" class="vehicle-image">
            <div class="vehicle-details">
                <h3 class="vehicle-name">Honda CR-V</h3>
                <div class="vehicle-price">$65/day</div>
                <div class="vehicle-features">
                    <span class="feature-badge">7 Seats</span>
                    <span class="feature-badge">Automatic</span>
                    <span class="feature-badge">4WD</span>
                </div>
                <button style="width: 100%;" onclick="window.location.href='book-details.html?id=2'">Book Now</button>
            </div>
        </div>

        <!-- Vehicle Card 3 -->
        <div class="vehicle-card">
            <img src="https://via.placeholder.com/300x200?text=Luxury" alt="Luxury" class="vehicle-image">
            <div class="vehicle-details">
                <h3 class="vehicle-name">BMW 5 Series</h3>
                <div class="vehicle-price">$120/day</div>
                <div class="vehicle-features">
                    <span class="feature-badge">5 Seats</span>
                    <span class="feature-badge">Automatic</span>
                    <span class="feature-badge">Premium</span>
                </div>
                <button style="width: 100%;" onclick="window.location.href='book-details.html?id=3'">Book Now</button>
            </div>
        </div>

        <!-- Vehicle Card 4 -->
        <div class="vehicle-card">
            <img src="https://via.placeholder.com/300x200?text=Truck" alt="Truck" class="vehicle-image">
            <div class="vehicle-details">
                <h3 class="vehicle-name">Ford F-150</h3>
                <div class="vehicle-price">$85/day</div>
                <div class="vehicle-features">
                    <span class="feature-badge">5 Seats</span>
                    <span class="feature-badge">Automatic</span>
                    <span class="feature-badge">Towing</span>
                </div>
                <button style="width: 100%;" onclick="window.location.href='book-details.html?id=4'">Book Now</button>
            </div>
        </div>
    </div>
</div>

<script>
    function logout() {
        // Implement logout functionality
        alert('Logging out...');
        window.location.href = 'login.html';
    }
</script>
</body>
</html>