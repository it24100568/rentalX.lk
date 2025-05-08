<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
        }
        .sidebar {
            width: 16rem;
            background-color: rgb(59, 130, 246);
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
            background-color: rgba(30, 64, 175, 0.68);
        }
        .sidebar-item.active {
            background-color: rgba(30, 64, 175, 0.68);
            font-weight: 500;
        }
        .card {
            background: white;
            padding: 1.5rem;
            border-radius: 0.5rem;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }
        .activity-table {
            width: 100%;
            border-collapse: collapse;
        }
        .activity-table tr:nth-child(even) {
            background-color: #f9fafb;
        }
        .activity-table td {
            padding: 0.75rem 1.5rem;
            border-bottom: 1px solid #e5e7eb;
        }
        .nav__btns {
            display: flex;
            gap: 1rem;
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
                    <a href="adminList.jsp" class="sidebar-item hover:bg-blue-700">Admin Management</a>
                </li>
                <li>
                    <a href="vehiclemanagement.jsp" class="sidebar-item hover:bg-blue-700">Vehicle Management</a>
                </li>
                <li>
                    <a href="dashboard.jsp" class="sidebar-item active">System Reports</a>
                </li>
            </ul>
        </nav>
    </div>

    <!-- Main Content -->
    <div class="flex-1 p-8 overflow-auto">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
            <div class="card">
                <h3 class="text-lg font-semibold mb-2">Total Vehicles</h3>
                <p class="text-3xl font-bold">${totalVehicles}</p>
            </div>
            <div class="card">
                <h3 class="text-lg font-semibold mb-2">Available Vehicles</h3>
                <p class="text-3xl font-bold text-green-600">${availableVehicles}</p>
            </div>
            <div class="card">
                <h3 class="text-lg font-semibold mb-2">Active Admins</h3>
                <p class="text-3xl font-bold">${admins.size()}</p>
            </div>
        </div>

        <div class="card">
            <h2 class="text-xl font-semibold mb-4">Recent Activities</h2>
            <div class="overflow-y-auto max-h-96">
                <table class="activity-table">
                    <tbody>
                    <c:forEach var="activity" items="${activities}">
                        <tr>
                            <td class="text-sm text-gray-500">
                                    ${activity}
                            </td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</body>
</html>