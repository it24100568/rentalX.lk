<%@ page import="java.util.*" %>
<%@ page import="lk.sliit.Model.User" %>
<%@ page import="lk.sliit.Service.FileService" %>
<%@ page session="true" %>
<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
    String keyword = request.getParameter("keyword");
    List<lk.sliit.Model.User> results = new ArrayList<>();
    if (keyword != null) {
        lk.sliit.Service.FileService fs = new lk.sliit.Service.FileService();
        for (lk.sliit.Model.User u : fs.readUsers()) {
            if (u.getName().contains(keyword) || u.getEmail().contains(keyword)) {
                results.add(u);
            }
        }
    }
%>
<html>
<head>
    <title>Search User</title>
    <link href="css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="container mt-5">
<h2>Search Users</h2>
<form method="get" action="search_user.jsp" class="mb-3">
    <input type="text" name="keyword" placeholder="Enter name or email" class="form-control" required />
    <button class="btn btn-primary mt-2">Search</button>
</form>
<% if (!results.isEmpty()) { %>
<table class="table table-bordered">
    <thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Status</th></tr></thead>
    <tbody>
    <% for (lk.sliit.Model.User u : results) { %>
    <tr>
        <td><%= u.getId() %></td>
        <td><%= u.getName() %></td>
        <td><%= u.getEmail() %></td>
        <td><%= u.isBlocked() ? "Blocked" : "Active" %></td>
    </tr>
    <% } %>
    </tbody>
</table>
<% } else if (keyword != null) { %>
<p>No user found.</p>
<% } %>
<a href="admin_dashboard.jsp" class="btn btn-secondary">Back</a>
</body>
</html>
