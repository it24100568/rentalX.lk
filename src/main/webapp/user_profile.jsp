<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="lk.sliit.Model.User" %>
<%@ page session="true" %>
<%
  User user = (User) session.getAttribute("user");
  if (user == null) {
    response.sendRedirect("user_login.jsp");
    return;
  }
  String success = (String) session.getAttribute("success");
%>
<html>
<head>
  <title>User Profile - Vehicle Rental</title>
  <link href="css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
  <style>
    body {
      background: #f5f7fa;
    }
    .profile-card {
      background-color: white;
      border-radius: 10px;
      padding: 30px;
      max-width: 700px;
      margin: 40px auto;
      box-shadow: 0 0 10px rgba(0,0,0,0.1);
    }
    .profile-image {
      width: 120px;
      height: 120px;
      object-fit: cover;
      border-radius: 50%;
      border: 3px solid #007bff;
    }
  </style>
</head>
<body>


<nav class="navbar navbar-dark bg-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="home.jsp"><i class="fas fa-car text-primary me-2"></i>Vehicle Rental</a>
    <div class="d-flex">
      <a class="btn btn-outline-light" href="user?action=logout"><i class="fas fa-sign-out-alt me-1"></i>Logout</a>
    </div>
  </div>
</nav>


<div class="container mt-4 text-center">
  <a href="home.jsp" class="btn btn-outline-primary">
    <i class="fas fa-arrow-left me-1"></i> Back to Home
  </a>
</div>


<% if (success != null) { %>
<div class="alert alert-success text-center mx-auto mt-4" style="max-width: 600px;">
  <%= success %>
</div>
<%
  session.removeAttribute("success");
%>
<% } %>


<div class="profile-card">
  <h3 class="text-center text-primary mb-4"><i class="fas fa-user-circle me-2"></i>Your Profile</h3>

  <form action="user" method="post" enctype="multipart/form-data">
    <input type="hidden" name="action" value="update">

    <div class="text-center mb-4">
      <img src="<%= (user.getProfileImagePath() != null && !user.getProfileImagePath().isEmpty()) ? user.getProfileImagePath() : "images/default-profile.png" %>" class="profile-image" alt="Profile Image" />
    </div>

    <div class="mb-3">
      <label>ID</label>
      <input type="text" name="id" class="form-control" value="<%= user.getId() %>" readonly />
    </div>

    <div class="mb-3">
      <label>Name</label>
      <input type="text" name="name" class="form-control" value="<%= user.getName() %>" required />
    </div>

    <div class="mb-3">
      <label>Email</label>
      <input type="email" name="email" class="form-control" value="<%= user.getEmail() %>" required />
    </div>

    <div class="mb-3">
      <label>Password</label>
      <input type="password" name="password" class="form-control" value="<%= user.getPassword() %>" required />
    </div>

    <div class="mb-3">
      <label>Address Line 1</label>
      <input type="text" name="address1" class="form-control" value="<%= user.getAddress1() != null ? user.getAddress1() : "" %>" />
    </div>

    <div class="mb-3">
      <label>Address Line 2</label>
      <input type="text" name="address2" class="form-control" value="<%= user.getAddress2() != null ? user.getAddress2() : "" %>" />
    </div>

    <div class="mb-3">
      <label>Profile Image</label>
      <input type="file" name="profileImage" class="form-control" />
    </div>

    <button type="submit" class="btn btn-success w-100">
      <i class="fas fa-save me-1"></i> Update Profile
    </button>
  </form>
</div>

</body>
</html>
