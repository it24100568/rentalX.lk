<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Review Moderation - Feedback and Review Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .card {
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .rating-stars {
            color: #ffc107;
            font-size: 1.2rem;
        }
        .review-card {
            transition: transform 0.2s;
        }
        .review-card:hover {
            transform: translateY(-5px);
        }
        .filter-section {
            background-color: #f8f9fa;
            border-radius: 0.5rem;
            padding: 1rem;
            margin-bottom: 2rem;
        }
        .badge-verified {
            background-color: #198754;
            color: white;
            font-size: 0.8rem;
            padding: 0.3rem 0.6rem;
            border-radius: 1rem;
        }
        .badge-unverified {
            background-color: #dc3545;
            color: white;
            font-size: 0.8rem;
            padding: 0.3rem 0.6rem;
            border-radius: 1rem;
        }
    </style>
</head>
<body class="bg-light">
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
                        <a class="nav-link active" href="/admin/reviews">Admin Panel</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-white py-3">
                        <h4 class="mb-0">Admin Review Management</h4>
                    </div>
                    <div class="card-body">
                        <!-- Filter Section -->
                        <div class="filter-section mb-4">
                            <form action="/admin/reviews/filter" method="get" class="row g-3">
                                <div class="col-md-3">
                                    <label class="form-label">Filter by Rating</label>
                                    <select name="rating" class="form-select">
                                        <option value="">All Ratings</option>
                                        <option value="1">1 Star</option>
                                        <option value="2">2 Stars</option>
                                        <option value="3">3 Stars</option>
                                        <option value="4">4 Stars</option>
                                        <option value="5">5 Stars</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Filter by Date</label>
                                    <select name="dateFilter" class="form-select">
                                        <option value="">All Time</option>
                                        <option value="7">Last 7 Days</option>
                                        <option value="30">Last 30 Days</option>
                                        <option value="90">Last 90 Days</option>
                                    </select>
                                </div>
                                <div class="col-md-3">
                                    <label class="form-label">Filter by Status</label>
                                    <select name="status" class="form-select">
                                        <option value="">All Reviews</option>
                                        <option value="verified">Verified</option>
                                        <option value="unverified">Unverified</option>
                                    </select>
                                </div>
                                <div class="col-md-3 d-flex align-items-end">
                                    <button type="submit" class="btn btn-primary w-100">
                                        <i class="bi bi-funnel me-2"></i>Apply Filters
                                    </button>
                                </div>
                            </form>
                        </div>

                        <!-- Success/Error Messages -->
                        <c:if test="${not empty successMessage}">
                            <div class="alert alert-success alert-dismissible fade show" role="alert">
                                ${successMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>
                        
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                                ${errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                            </div>
                        </c:if>

                        <!-- Reviews List -->
                        <div class="row g-4">
                            <c:forEach items="${reviews}" var="review">
                                <div class="col-md-6 col-lg-4">
                                    <div class="card review-card h-100">
                                        <div class="card-body">
                                            <div class="d-flex justify-content-between align-items-center mb-3">
                                                <h5 class="card-title mb-0">Vehicle ID: ${review.vehicleId}</h5>
                                                <span class="badge ${review.verified ? 'badge-verified' : 'badge-unverified'}">
                                                    ${review.verified ? 'Verified' : 'Unverified'}
                                                </span>
                                            </div>
                                            <div class="rating-stars mb-2">
                                                <c:forEach begin="1" end="5" var="star">
                                                    <i class="bi ${star <= review.rating ? 'bi-star-fill' : 'bi-star'}"></i>
                                                </c:forEach>
                                            </div>
                                            <p class="card-text">${review.comment}</p>
                                            <div class="d-flex justify-content-between align-items-center mt-3">
                                                <small class="text-muted">By: ${review.userName}</small>
                                                <small class="text-muted">
                                                    <fmt:formatDate value="${review.reviewDate}" pattern="MMM dd, yyyy HH:mm"/>
                                                </small>
                                            </div>
                                            <div class="mt-3 d-flex justify-content-between">
                                                <form action="/admin/reviews/verify/${review.id}" method="post" style="display: inline;">
                                                    <button type="submit" class="btn btn-sm ${review.verified ? 'btn-outline-warning' : 'btn-outline-success'}">
                                                        <i class="bi ${review.verified ? 'bi-x-circle' : 'bi-check-circle'} me-1"></i>
                                                        ${review.verified ? 'Unverify' : 'Verify'}
                                                    </button>
                                                </form>
                                                <form action="/admin/reviews/delete/${review.id}" method="post" style="display: inline;"
                                                      onsubmit="return confirm('Are you sure you want to delete this review? This action cannot be undone.')">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger">
                                                        <i class="bi bi-trash me-1"></i>Delete
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>

                        <!-- Empty State -->
                        <c:if test="${empty reviews}">
                            <div class="text-center py-5">
                                <i class="bi bi-clipboard-x display-1 text-muted mb-3"></i>
                                <h5>No Reviews Found</h5>
                                <p class="text-muted">There are no reviews matching your criteria.</p>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 