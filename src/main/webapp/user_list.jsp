<%@ page import="java.util.List" %>
<%@ page import="lk.sliit.Service.FileService" %>
<%@ page import="lk.sliit.Model.User" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
    FileService fs = new FileService();
    List<User> users = fs.readUsers();
%>
<html>
<head>
    <title>All Users - Admin Panel</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background-color: #f5f7fa;
            animation: fadeIn 0.5s ease-in-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }

        .table-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 12px rgba(0,0,0,0.1);
            margin-top: 40px;
        }

        .search-box {
            margin-bottom: 20px;
        }

        .table thead {
            background-color: #343a40;
            color: white;
        }

        .btn {
            margin: 0 2px;
        }

        .badge {
            font-size: 0.9em;
        }
    </style>
    <script>
        function filterUsers() {
            const input = document.getElementById("searchInput").value.toLowerCase();
            const rows = document.querySelectorAll("#userTable tbody tr");
            rows.forEach(row => {
                const name = row.querySelector("td:nth-child(2)").textContent.toLowerCase();
                const email = row.querySelector("td:nth-child(3)").textContent.toLowerCase();
                row.style.display = name.includes(input) || email.includes(input) ? "" : "none";
            });
        }

        function confirmBlock() {
            return confirm("Are you sure you want to block this user?");
        }

        function confirmUnblock() {
            return confirm("Are you sure you want to unblock this user?");
        }

        function confirmDelete() {
            return confirm("Are you sure you want to delete this user?");
        }
    </script>
</head>
<body class="container">

<div class="table-container">
    <h3 class="mb-4"><i class="fas fa-users me-2 text-primary"></i>All Registered Users</h3>

    <div class="row search-box">
        <div class="col-md-6">
            <input type="text" id="searchInput" class="form-control" onkeyup="filterUsers()" placeholder="Search by name or email..." />
        </div>
    </div>

    <div class="table-responsive">
        <table class="table table-bordered table-hover" id="userTable">
            <thead>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% for (User u : users) { %>
            <tr>
                <td><%= u.getId() %></td>
                <td><%= u.getName() %></td>
                <td><%= u.getEmail() %></td>
                <td>
                        <span class="badge <%= u.isBlocked() ? "bg-danger" : "bg-success" %>">
                            <%= u.isBlocked() ? "Blocked" : "Active" %>
                        </span>
                </td>
                <td>
                    <% if (!u.isBlocked()) { %>
                    <form action="admin" method="post" style="display:inline-block" onsubmit="return confirmBlock()">
                        <input type="hidden" name="action" value="blockUser">
                        <input type="hidden" name="userId" value="<%= u.getId() %>">
                        <button type="submit" class="btn btn-warning btn-sm">
                            <i class="fas fa-ban"></i> Block
                        </button>
                    </form>
                    <% } else { %>
                    <form action="admin" method="post" style="display:inline-block" onsubmit="return confirmUnblock()">
                        <input type="hidden" name="action" value="unblockUser">
                        <input type="hidden" name="userId" value="<%= u.getId() %>">
                        <button type="submit" class="btn btn-success btn-sm">
                            <i class="fas fa-lock-open"></i> Unblock
                        </button>
                    </form>
                    <% } %>
                    <form action="admin" method="post" style="display:inline-block" onsubmit="return confirmDelete()">
                        <input type="hidden" name="action" value="deleteUser">
                        <input type="hidden" name="userId" value="<%= u.getId() %>">
                        <button type="submit" class="btn btn-danger btn-sm">
                            <i class="fas fa-trash"></i> Delete
                        </button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>

    <div class="text-end mt-3">
        <a href="admin_dashboard.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left me-1"></i> Back to Dashboard</a>
    </div>
</div>

</body>
</html>
