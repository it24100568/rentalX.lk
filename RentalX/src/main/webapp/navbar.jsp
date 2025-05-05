<%@ page contentType="text/html;charset=UTF-8" %>
<nav class="top-nav">
  <div class="nav-container">
    <div class="nav-brand">
      <a href="index.jsp">RentalX</a>
    </div>
    <div class="nav-menu">
      <div class="dropdown">
        <button class="dropbtn">Management</button>
        <div class="dropdown-content">
          <a href="vehiclemanagement.jsp">Vehicle Management</a>
          <a href="user-management.jsp">User Management</a>
          <a href="rental-management.jsp">Rental Management</a>
        </div>
      </div>
      <a href="profile.jsp">Profile</a>
      <form action="logout" method="post" class="nav-logout">
        <button type="submit" class="logout-button">Logout</button>
      </form>
    </div>
  </div>
</nav>

<style>
  /* Navigation Styles */
  .top-nav {
    background-color: #3b82f6;
    color: white;
    padding: 1rem 0;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  }
  .nav-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 2rem;
  }
  .nav-brand a {
    color: white;
    font-weight: 600;
    font-size: 1.5rem;
    text-decoration: none;
  }
  .nav-menu {
    display: flex;
    align-items: center;
    gap: 1.5rem;
  }
  .nav-menu a {
    color: white;
    text-decoration: none;
    font-weight: 500;
    padding: 0.5rem 1rem;
    border-radius: 0.375rem;
  }
  .nav-menu a:hover {
    background-color: rgba(255, 255, 255, 0.1);
  }
  .dropdown {
    position: relative;
    display: inline-block;
  }
  .dropbtn {
    background-color: transparent;
    color: white;
    padding: 0.5rem 1rem;
    font-size: 1rem;
    border: none;
    cursor: pointer;
    font-weight: 500;
    font-family: 'Poppins', sans-serif;
  }
  .dropdown-content {
    display: none;
    position: absolute;
    background-color: white;
    min-width: 200px;
    box-shadow: 0 8px 16px rgba(0,0,0,0.2);
    z-index: 1;
    border-radius: 0.375rem;
  }
  .dropdown-content a {
    color: #111827;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
  }
  .dropdown-content a:hover {
    background-color: #f3f4f6;
  }
  .dropdown:hover .dropdown-content {
    display: block;
  }
  .dropdown:hover .dropbtn {
    background-color: rgba(255, 255, 255, 0.1);
  }
  .nav-logout {
    margin: 0;
  }
  .logout-button {
    background: none;
    border: none;
    color: white;
    font-weight: 500;
    cursor: pointer;
    font-family: 'Poppins', sans-serif;
    padding: 0.5rem 1rem;
  }
  .logout-button:hover {
    background-color: rgba(255, 255, 255, 0.1);
    border-radius: 0.375rem;
  }
</style>