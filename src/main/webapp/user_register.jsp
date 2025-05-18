<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>User Registration - Vehicle Rental</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            margin: 0;
            padding: 0;
            background: url('images/car-bg.jpg') no-repeat center center fixed;
            background-size: cover;
            position: relative;
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
            animation: slideUp 1.2s ease-out;
        }

        @keyframes slideUp {
            from {
                transform: translateY(60px);
                opacity: 0;
            }
            to {
                transform: translateY(0px);
                opacity: 1;
            }
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .form-label {
            font-weight: 500;
        }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center vh-100">

<div class="card shadow p-4" style="width: 100%; max-width: 450px;">
    <h4 class="text-center text-success mb-4">
        <i class="fas fa-user-plus me-2"></i>Create Your Account
    </h4>

    <form action="user" method="post">
        <input type="hidden" name="action" value="register">

        <div class="mb-3">
            <label class="form-label"><i class="fas fa-id-card me-1"></i> ID</label>
            <input type="text" name="id" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label"><i class="fas fa-user me-1"></i> Name</label>
            <input type="text" name="name" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label"><i class="fas fa-envelope me-1"></i> Email</label>
            <input type="email" name="email" class="form-control" required />
        </div>

        <div class="mb-3">
            <label class="form-label"><i class="fas fa-lock me-1"></i> Password</label>
            <input type="password" name="password" class="form-control" required />
        </div>

        <button class="btn btn-success w-100" type="submit">
            <i class="fas fa-user-plus me-1"></i> Register
        </button>
    </form>

    <p class="mt-3 text-center text-dark">
        Already registered? <a href="user_login.jsp">Login here</a>
    </p>
</div>

</body>
</html>
