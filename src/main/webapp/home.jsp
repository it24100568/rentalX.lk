<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.sliit.Model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
%>
<html>
<head>
    <title>Home - Vehicle Rental</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        .dropdown-menu a:hover {
            background-color: #e9ecef;
        }
        .welcome-section {
            padding: 80px 0;
            text-align: center;
            background: url('images/car-bg.jpg') no-repeat center center fixed;
            background-size: cover;
            color: white;
            text-shadow: 1px 1px 5px #000;
        }
    </style>
</head>
<body>


<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid">
        <a class="navbar-brand" href="#"><i class="fas fa-car text-primary me-2"></i>Vehicle Rental</a>
        <div class="collapse navbar-collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle text-white" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fas fa-user me-1"></i>
                        <%= (user != null) ? user.getName() : "Login" %>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="userDropdown">
                        <% if (user != null) { %>
                        <li><a class="dropdown-item" href="user_profile.jsp"><i class="fas fa-user-circle me-2"></i>Profile</a></li>
                        <li><a class="dropdown-item" href="user?action=logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a></li>
                        <% } else { %>
                        <li><a class="dropdown-item" href="user_login.jsp"><i class="fas fa-sign-in-alt me-2"></i>Login</a></li>
                        <% } %>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>


<div class="welcome-section">
    <div class="container">
        <h1 class="display-4">
            Welcome <%= (user != null) ? user.getName() + "!" : "to Vehicle Rental!" %>
        </h1>
        <p class="lead mt-3">Rent your dream vehicle today — fast, easy, and reliable.</p>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
