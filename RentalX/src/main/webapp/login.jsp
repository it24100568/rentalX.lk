<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login | RentalX</title>
  <div class="home-button">
    <a href="index.jsp">Home</a>
  </div>
  <style>
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
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #f3f4f6;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        margin: 0;
    }
    .login-container {
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
    .register-link {
        text-align: center;
        margin-top: 1rem;
    }
    .forgot-password {
        text-align: right;
        margin-bottom: 1rem;
    }
  </style>
</head>
<body>
<%--<div class="login-container">--%>
<%--  <h1>Sign In</h1>--%>
<%--  <form id="loginForm" method="post">--%>
<%--    <div class="form-group">--%>
<%--      <label for="email">Email</label>--%>
<%--      <input type="email" id="email" name="email" required>--%>
<%--    </div>--%>
<%--    <div class="form-group">--%>
<%--      <label for="password">Password</label>--%>
<%--      <input type="password" id="password" name="password" required>--%>
<%--    </div>--%>
<%--    <div class="forgot-password">--%>
<%--      <a href="forgot-password.html">Forgot password?</a>--%>
<%--    </div>--%>
<%--    <button type="submit">Sign In</button>--%>
<%--  </form>--%>
<%--  <div class="register-link">--%>
<%--    Don't have an account? <a href="registration.jsp">Sign up</a>--%>
<%--  </div>--%>
<%--</div>--%>
<h1>Login</h1>
<form action="login" method="post">
  <input type="text" name="username" placeholder="Username" required><br>
  <input type="password" name="password" placeholder="Password" required><br>
  <button type="submit">Login</button>
</form>
<p style="color: red;">${error}</p>

<% if (request.getParameter("success") != null) { %>
<div style="color: green; margin-bottom: 1rem;">
  <%= request.getParameter("success") %>
</div>
<% } %>

</body>
</html>