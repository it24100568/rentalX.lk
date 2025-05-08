<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login - RentalX</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, rgb(103, 162, 255) 0%, rgb(103, 162, 255) 100%);
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
        }
        .home-button {
            position: absolute;
            top: 20px;
            left: 20px;
        }
        .input-field {
            transition: all 0.3s ease;
        }
        .input-field:focus {
            box-shadow: 0 0 0 3px rgb(243, 246, 255);
        }

        /* Additional Styles */
        .registration-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }
        .registration-form {
            background: white;
            padding: 2rem;
            border-radius: 0.5rem;
            width: 90%;
            max-width: 500px;
        }
        .nav__btns {
            display: flex;
            gap: 1rem;
        }
    </style>

</head>
<body class="min-h-screen flex items-center justify-center p-4">
<div class="login-card w-full max-w-md p-8 rounded-xl shadow-2xl">
    <div class="text-center mb-8">
        <img src="logo.jpg" alt="RentalX Logo" class="h-16 mx-auto mb-4">
        <h1 class="text-3xl font-bold text-gray-800">Admin Portal</h1>
        <p class="text-gray-600 mt-2">Sign in to access the management dashboard</p>
    </div>

    <form action="admin-login" method="post" class="space-y-6">
        <div>
            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email Address</label>
            <input type="email" id="email" name="email" required
                   class="input-field w-full px-4 py-3 rounded-lg border border-gray-300 focus:outline-none focus:border-blue-500">
        </div>

        <div>
            <div class="flex justify-between items-center mb-1">
                <label for="password" class="block text-sm font-medium text-gray-700">Password</label>
                <a href="#" class="text-sm text-blue-600 hover:text-blue-800">Forgot password?</a>
            </div>
            <input type="password" id="password" name="password" required
                   class="input-field w-full px-4 py-3 rounded-lg border border-gray-300 focus:outline-none focus:border-blue-500">
        </div>

        <div class="flex items-center">
            <input type="checkbox" id="remember" name="remember"
                   class="h-4 w-4 text-blue-600 focus:ring-blue-500 border-gray-300 rounded">
            <label for="remember" class="ml-2 block text-sm text-gray-700">
                Remember me
            </label>
        </div>

        <button type="submit"
                class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-3 px-4 rounded-lg transition duration-300">
            Sign In
        </button>
    </form>

    <div class="mt-6 text-center">
        <p class="text-sm text-gray-600">Not an admin? <a href="login.jsp" class="text-blue-600 hover:text-blue-800">Back to user login</a></p>
    </div>

    <%-- Error message display --%>
    <% if (request.getAttribute("error") != null) { %>
    <div class="mt-4 p-3 bg-red-100 text-red-700 rounded-lg text-sm">
        <%= request.getAttribute("error") %>
    </div>
    <% } %>
</div>
<div class="home-button">
    <a href="index.jsp">Home</a>
</div>
</body>
</html>