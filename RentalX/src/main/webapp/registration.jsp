<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | RentalX</title>
     <div class="home-button">
        <a href="index.jsp">Home</a>
      </div>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f3f4f6;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .registration-container {
            background: white;
            padding: 2rem;
            border-radius: 0.5rem;
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }
        .form-group {
            margin-bottom: 1rem;
        }
        label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }
        input {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #d1d5db;
            border-radius: 0.375rem;
        }
        button {
            width: 100%;
            padding: 0.75rem;
            background-color: #3b82f6;
            color: white;
            border: none;
            border-radius: 0.375rem;
            cursor: pointer;
        }
        .login-link {
            text-align: center;
            margin-top: 1rem;
        }
        .home-button {
            position: absolute;
            top: 20px;
            left: 20px;
          }
          .home-button a {
            text-decoration: none;
            color: #3b82f6;
            font-weight: 500;
            font-size: 1rem;
          }
          .home-button a:hover {
            text-decoration: underline;
          }
    </style>
</head>
<body>
<div class="registration-container">
    <h1>Create Account</h1>
    <form id="registrationForm" method="post">
        <div class="form-group">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" required>
        </div>
        <div class="form-group">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div class="form-group">
            <label for="phone">Phone Number</label>
            <input type="tel" id="phone" name="phone">
        </div>
        <div class="form-group">
            <label for="password">Password</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" required>
        </div>
        <div class="form-group">
            <input type="checkbox" id="terms" name="terms" required>
            <label for="terms">I agree to the Terms and Conditions</label>
        </div>
        <button type="submit">Register</button>
    </form>
    <div class="login-link">
        Already have an account? <a href="login.jsp">Sign in</a>
    </div>
</div>
</body>
</html>