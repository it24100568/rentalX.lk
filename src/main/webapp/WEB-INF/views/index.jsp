<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome - Feedback and Review Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .hero {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)), url('/images/hero-bg.jpg');
            background-size: cover;
            background-position: center;
            color: white;
            padding: 100px 0;
        }
        .feature-card {
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            transition: transform 0.3s;
        }
        .feature-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="/">Feedback & Review Management</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="/reviews">View Reviews</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/reviews/submit">Submit Review</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <section class="hero text-center">
        <div class="container">
            <h1 class="display-4 mb-4">Welcome to Feedback & Review Management</h1>
            <p class="lead mb-5">Share your experience and help us improve our services</p>
            <div class="d-grid gap-3 d-sm-flex justify-content-sm-center">
                <a href="/reviews/submit" class="btn btn-primary btn-lg px-4 gap-3">
                    <i class="bi bi-plus-circle me-2"></i>Submit Review
                </a>
                <a href="/reviews" class="btn btn-outline-light btn-lg px-4">
                    <i class="bi bi-star me-2"></i>View Reviews
                </a>
            </div>
        </div>
    </section>

    <section class="py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-star-fill text-warning display-4 mb-3"></i>
                            <h3 class="card-title h4">Share Your Experience</h3>
                            <p class="card-text">Rate and review our vehicles to help others make informed decisions.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-chat-dots-fill text-primary display-4 mb-3"></i>
                            <h3 class="card-title h4">Provide Feedback</h3>
                            <p class="card-text">Your feedback helps us improve our services and vehicle quality.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card feature-card h-100">
                        <div class="card-body text-center">
                            <i class="bi bi-people-fill text-success display-4 mb-3"></i>
                            <h3 class="card-title h4">Join Our Community</h3>
                            <p class="card-text">Be part of our growing community of satisfied customers.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="bg-dark text-white py-4 mt-5">
        <div class="container text-center">
            <p class="mb-0">&copy; 2024 Feedback & Review Management. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 