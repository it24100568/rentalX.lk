<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Management</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        .sidebar {
            width: 16rem;
            background-color: #3b82f6;
            color: white;
            padding: 1rem;
            transition: all 0.3s;
        }
        .sidebar-item {
            display: block;
            padding: 0.5rem 1rem;
            border-radius: 0.375rem;
            transition: all 0.2s;
        }
        .sidebar-item:hover {
            background-color: #1e3a8a;
        }
        .sidebar-item.active {
            background-color: rgba(30, 64, 175, 0.68);
            font-weight: 500;
        }
        .table-container {
            background: white;
            border-radius: 0.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            overflow: hidden;
        }
        .table-header {
            background-color: #f9fafb;
        }
        .table-row:hover {
            background-color: #f8fafc;
        }
    </style>
</head>
<body class="bg-gray-100">
<div class="flex h-screen">
    <!-- Sidebar -->
    <div class="sidebar">
        <h1 class="text-2xl font-bold mb-8">RentalX Admin</h1>
        <nav>
            <ul class="space-y-2">
                <li>
                    <a href="vehiclemanagement.jsp" class="sidebar-item hover:bg-blue-700">Admin Management</a>
                </li>
                <li>
                    <a href="vehicle-management?action=list" class="sidebar-item hover:bg-blue-700">Vehicle Management</a>
                </li>
                <li>
                    <a href="admin-management?action=reports" class="sidebar-item">System Reports</a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="flex-1 p-8 overflow-auto">
        <div class="flex justify-between items-center mb-6">
            <h1 class="text-2xl font-bold">Admin Management</h1>
            <a href="admin/addAdmin.jsp"
               class="px-4 py-2 bg-green-600 text-white rounded-md hover:bg-green-700 transition-colors">
                Add New Admin
            </a>
        </div>

        <div class="table-container">
            <table class="min-w-full divide-y divide-gray-200">
                <thead class="table-header">
                <tr>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Email</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Last Login</th>
                    <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                </tr>
                </thead>
                <tbody class="divide-y divide-gray-200">
                <c:forEach var="admin" items="${admins}">
                    <tr class="table-row">
                        <td class="px-6 py-4 whitespace-nowrap">${admin.email}</td>
                        <td class="px-6 py-4 whitespace-nowrap">
                                ${admin.lastLogin != null ? admin.lastLogin : 'Never'}
                        </td>
                        <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                            <a href="admin-management?action=edit&adminId=${admin.userId}"
                               class="text-blue-600 hover:text-blue-900 mr-3">Edit</a>
                            <a href="admin-management?action=delete&adminId=${admin.userId}"
                               class="text-red-600 hover:text-red-900"
                               onclick="return confirm('Are you sure you want to delete this admin?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>