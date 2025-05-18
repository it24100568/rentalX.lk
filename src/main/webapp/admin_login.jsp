<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Login - Vehicle Rental</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: url('images/car-bg.jpg') no-repeat center center fixed;
            background-size: cover;
            animation: fadeIn 1.5s ease-in;
        }
        body::before {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background-color: rgba(0, 0, 0, 0.6);
            z-index: 0;
        }

        .card {
            position: relative;
            z-index: 1;
            background-color: white;
            border-radius: 10px;
            padding: 30px;
            animation: slideUp 1s ease;
            box-shadow: 0 0 10px rgba(0,0,0,0.2);
        }

        @keyframes slideUp {
            from { transform: translateY(50px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center vh-100">

<div class="card" style="width: 100%; max-width: 450px;">
    <h4 class="text-center text-primary mb-4"><i class="fas fa-user-shield me-2"></i>Admin Login</h4>
    <form action="admin" method="post">
        <input type="hidden" name="action" value="login">

        <div class="mb-3">
            <label class="form-label"><i class="fas fa-envelope me-1"></i> Email</label>
            <input type="email" name="email" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label"><i class="fas fa-lock me-1"></i> Password</label>
            <input type="password" name="password" class="form-control" required />
        </div>

        <button class="btn btn-primary w-100" type="submit">
            <i class="fas fa-arrow-right-to-bracket me-1"></i>Login
        </button>
    </form>

    <p class="mt-3 text-center text-dark">
        Don't have an admin account? <a href="admin_register.jsp">Register here</a>
    </p>
</div>

</body>
</html>
