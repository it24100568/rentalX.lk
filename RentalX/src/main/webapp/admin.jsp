<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | RentalX</title>

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
        .dashboard-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 1rem;
        }
        .user-list {
            margin-top: 2rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        th {
            background-color: #f3f4f6;
        }
        button {
            padding: 0.5rem 1rem;
            background-color: #3b82f6;
            color: white;
            border: none;
            border-radius: 0.375rem;
            cursor: pointer;
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="logo">RentalX Admin</div>
    <div>
        <button onclick="logout()">Logout</button>
    </div>
</nav>

<div class="dashboard-container">
    <h1>User Management</h1>

    <div class="user-list">
        <table id="usersTable">
            <thead>
            <tr>
                <th>Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Registered On</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <!-- Users will be populated here -->
            </tbody>
        </table>
    </div>
</div>

<script>
    // Check if admin is logged in
    const currentUser = JSON.parse(localStorage.getItem('currentUser'));
    if (!currentUser || currentUser.email !== 'admin@rentalx.com') {
        window.location.href = 'login.html';
    }

    // Get all users from localStorage
    function getAllUsers() {
        const users = [];
        for (let i = 0; i < localStorage.length; i++) {
            const key = localStorage.key(i);
            if (key.startsWith('user_')) {
                const user = JSON.parse(localStorage.getItem(key));
                users.push(user);
            }
        }
        return users;
    }

    // Display users in table
    function displayUsers() {
        const users = getAllUsers();
        const tableBody = document.querySelector('#usersTable tbody');
        tableBody.innerHTML = '';

        users.forEach(user => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${user.fullName}</td>
                <td>${user.email}</td>
                <td>${user.phone || '-'}</td>
                <td>${user.registrationDate}</td>
                <td>
                    <button onclick="editUser('${user.email}')">Edit</button>
                    <button onclick="deleteUser('${user.email}')">Delete</button>
                </td>
            `;
            tableBody.appendChild(row);
        });
    }

    function editUser(email) {
        alert(`Edit user with email: ${email}`);
        // Implement edit functionality
    }

    function deleteUser(email) {
        if (confirm(`Are you sure you want to delete user ${email}?`)) {
            localStorage.removeItem('user_' + email);
            displayUsers();
        }
    }

    function logout() {
        localStorage.removeItem('isLoggedIn');
        localStorage.removeItem('currentUser');
        window.location.href = 'login.jsp';
    }

    // Initialize the page
    //Page
    displayUsers();
</script>
</body>
</html>index.jsp