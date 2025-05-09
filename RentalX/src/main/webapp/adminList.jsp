<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Management | RentalX</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f3f4f6;
        }

        /* Sidebar styles */
        .sidebar {
            width: 16rem;
            background-color: #3b82f6;
            color: white;
            height: 100vh;
            position: fixed;
            transition: all 0.3s;
        }

        .sidebar-content {
            padding: 1.5rem;
        }

        .sidebar-item {
            display: block;
            padding: 0.75rem 1rem;
            border-radius: 0.375rem;
            color: white;
            text-decoration: none;
            transition: all 0.2s;
            margin-bottom: 0.5rem;
        }

        .sidebar-item:hover {
            background-color: rgba(255, 255, 255, 0.1);
        }

        .sidebar-item.active {
            background-color: rgba(255, 255, 255, 0.2);
            font-weight: 500;
        }

        /* Main content area */
        .main-content {
            margin-left: 16rem;
            padding: 2rem;
            width: calc(100% - 16rem);
        }

        /* Table styles */
        .admin-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            background-color: white;
            border-radius: 0.5rem;
            overflow: hidden;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
        }

        .admin-table th {
            background-color: #f9fafb;
            padding: 0.75rem 1.5rem;
            text-align: left;
            font-size: 0.75rem;
            font-weight: 600;
            color: #6b7280;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            border-bottom: 1px solid #e5e7eb;
        }

        .admin-table td {
            padding: 1rem 1.5rem;
            border-bottom: 1px solid #e5e7eb;
            color: #374151;
        }

        .admin-table tr:last-child td {
            border-bottom: none;
        }

        .admin-table tr:hover td {
            background-color: #f9fafb;
        }

        /* Action buttons */
        .action-link {
            margin-right: 1rem;
            color: #3b82f6;
            font-weight: 500;
            text-decoration: none;
            transition: color 0.2s;
        }

        .action-link:hover {
            color: #2563eb;
            text-decoration: underline;
        }

        .action-link.delete {
            color: #ef4444;
        }

        .action-link.delete:hover {
            color: #dc2626;
        }

        /* Add admin button */
        .btn-add-admin {
            background-color: #10b981;
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            font-weight: 500;
            transition: background-color 0.2s;
        }

        .btn-add-admin:hover {
            background-color: #059669;
        }
    </style>
</head>
<body>
<div class="flex">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-content">
            <h1 class="text-2xl font-bold mb-8 text-white">RentalX Admin</h1>
            <nav>
                <ul>
                    <li>
                        <a href="adminList.jsp" class="sidebar-item active">Admin Management</a>
                    </li>
                    <li>
                        <a href="vehiclemanagement.jsp" class="sidebar-item">Vehicle Management</a>
                    </li>
                    <li>
                        <a href="dashboard.jsp" class="sidebar-item">System Reports</a>
                    </li>
                </ul>
            </nav>
        </div>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="flex justify-between items-center mb-8">
            <h1 class="text-2xl font-bold text-gray-800">Admin Management</h1>
            <a href="addadmin.jsp" class="btn-add-admin">
                Add New Admin
            </a>
        </div>

        <div class="bg-white rounded-lg shadow overflow-hidden">
            <table class="admin-table">
                <thead>
                <tr>
                    <th>Email</th>
                    <th>Last Login</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="admin" items="${admins}">
                    <tr>
                        <td>${admin.email}</td>
                        <td>
                                ${admin.lastLogin != null ? admin.lastLogin : 'Never logged in'}
                        </td>
                        <td>
                            <a href="admin-management?action=edit&adminId=${admin.userId}"
                               class="action-link">Edit</a>
                            <a href="admin-management?action=delete&adminId=${admin.userId}"
                               class="action-link delete"
                               onclick="return confirm('Are you sure you want to delete this admin?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    // Confirm before deleting an admin
    document.querySelectorAll('.action-link.delete').forEach(link => {
        link.addEventListener('click', function(e) {
            if (!confirm('Are you sure you want to delete this admin?')) {
                e.preventDefault();
            }
        });
    });
</script>
</body>
</html>