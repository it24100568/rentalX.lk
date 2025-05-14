<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login | RentalX</title>
  <style>
    body {
      font-family: 'Poppins', sans-serif;
      background-color: #d9f1ff;
      display: flex;
      justify-content: center;
      align-items: center;
      min-height: 100vh;
      margin: 0;
      position: relative;
    }
    .home-button {
      position: absolute;
      top: 20px;
      left: 20px;
    }
    .home-button a {
      text-decoration: none;
      color: #000000;
      font-weight: 500;
      font-size: 1rem;
    }
    .home-button a:hover {
      text-decoration: underline;
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
      box-sizing: border-box;
    }
    button {
      width: 100%;
      padding: 0.75rem;
      background-color: #3b82f6;
      color: white;
      border: none;
      border-radius: 0.375rem;
      cursor: pointer;
      font-weight: 500;
    }
    button:hover {
      background-color: #2563eb;
    }
    .register-link, .forgot-password {
      text-align: center;
      margin-top: 1rem;
    }
    .forgot-password {
      margin-bottom: 1rem;
    }
    .message {
      padding: 0.75rem;
      margin-bottom: 1rem;
      border-radius: 0.375rem;
    }
    .success {
      background-color: #d1fae5;
      color: #065f46;
    }
    .error {
      background-color: #fee2e2;
      color: #b91c1c;
    }
  </style>
</head>
<body>
<div class="home-button">
  <a href="index.jsp">Home</a>
</div>

<div class="login-container">
  <h1>Sign In</h1>

  <%-- Success message from session --%>
  <c:if test="${not empty sessionScope.message}">
    <div class="message success">
        ${sessionScope.message}
      <c:remove var="message" scope="session" />
    </div>
  </c:if>

  <%-- Error message from request --%>
  <c:if test="${not empty requestScope.error}">
    <div class="message error">
        ${requestScope.error}
    </div>
  </c:if>

  <form id="loginForm" method="post" action="login">
    <div class="form-group">
      <label for="email">Email</label>
      <input type="email" id="email" name="email" required autocomplete="username">
    </div>
    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" id="password" name="password" required autocomplete="current-password">
    </div>
    <div class="forgot-password">
      <a href="forgot-password.jsp">Forgot Password?</a>
    </div>
    <button type="submit">Sign In</button>
  </form>

  <div class="register-link">
    Don't have an account? <a href="registration.jsp">Sign up</a>
  </div>
</div>
</body>
</html>