<%@ page import="lk.sliit.Model.Admin" %>
<%@ page session="true" %>
<%
  Admin admin = (lk.sliit.Model.Admin) session.getAttribute("admin");
  if (admin == null) {
    response.sendRedirect("admin_login.jsp");
    return;
  }
%>
<html>
<head>
  <title>Admin Dashboard</title>
  <link href="css/bootstrap.min.css" rel="stylesheet" />
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f5f5f5;
      animation: fadeIn 1.2s ease-in-out;
    }

    @keyframes fadeIn {
      from { opacity: 0; }
      to { opacity: 1; }
    }

    .sidebar {
      width: 220px;
      height: 100vh;
      position: fixed;
      top: 0; left: 0;
      background-color: #343a40;
      color: white;
      padding-top: 20px;
      animation: slideLeft 0.8s ease-out;
    }

    @keyframes slideLeft {
      from { transform: translateX(-100%); }
      to { transform: translateX(0); }
    }

    .sidebar h4 {
      text-align: center;
      color: #17a2b8;
      margin-bottom: 30px;
    }

    .sidebar a {
      display: block;
      padding: 12px 20px;
      color: white;
      text-decoration: none;
      transition: background 0.3s;
    }

    .sidebar a:hover {
      background-color: #495057;
    }

    .content {
      margin-left: 220px;
      padding: 30px;
    }

    .card {
      border-radius: 10px;
      padding: 25px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
      background: white;
      animation: slideUp 0.7s ease;
    }

    @keyframes slideUp {
      from { transform: translateY(30px); opacity: 0; }
      to { transform: translateY(0); opacity: 1; }
    }
  </style>
</head>
<body>

<div class="sidebar">
  <h4><i class="fas fa-user-shield me-2"></i>Admin Panel</h4>
  <a href="admin_dashboard.jsp"><i class="fas fa-home me-2"></i>Dashboard</a>
  <a href="user_list.jsp"><i class="fas fa-users me-2"></i>View All Users</a>
  <a href="admin?action=logout"><i class="fas fa-sign-out-alt me-2"></i>Logout</a>
</div>


<div class="content">
  <div class="card">
    <h2 class="mb-4">Welcome, <%= admin.getName() %> 🎉</h2>
    <p class="lead">You are logged into the administrator dashboard. From here you can manage users, view statistics, and perform other admin tasks.</p>

    <div class="mt-4">
      <a href="user_list.jsp" class="btn btn-outline-info me-2">
        <i class="fas fa-users me-1"></i>View All Users
      </a>
      <a href="admin?action=logout" class="btn btn-outline-danger">
        <i class="fas fa-sign-out-alt me-1"></i>Logout
      </a>
    </div>
  </div>
</div>

</body>
</html>
