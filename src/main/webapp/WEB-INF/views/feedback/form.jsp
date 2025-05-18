<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Submit Review - Feedback and Review Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        .card {
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .rating-input {
            display: none;
        }
        .rating-label {
            cursor: pointer;
            font-size: 1.5rem;
            color: #ddd;
            transition: all 0.2s;
        }
        .rating-label:hover,
        .rating-label:hover ~ .rating-label,
        .rating-input:checked ~ .rating-label {
            color: #ffc107;
        }
        .rating-group {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
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
                        <a class="nav-link active" href="/reviews/submit">Submit Review</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-header bg-white py-3">
                        <h4 class="mb-0">Submit New Review</h4>
                    </div>
                    <div class="card-body">
                        <form:form action="/reviews/submit" method="post" modelAttribute="feedback" class="needs-validation" novalidate="true">
                            <form:hidden path="id"/>
                            
                            <div class="mb-3">
                                <label for="userName" class="form-label">Your Name</label>
                                <form:input path="userName" class="form-control" required="true"/>
                                <div class="invalid-feedback">Please enter your name.</div>
                            </div>

                            <div class="mb-3">
                                <label for="vehicleId" class="form-label">Vehicle ID</label>
                                <form:input path="vehicleId" class="form-control" required="true"/>
                                <div class="invalid-feedback">Please enter the vehicle ID.</div>
                            </div>

                            <div class="mb-3">
                                <label class="form-label d-block">Rating</label>
                                <div class="rating-group">
                                    <form:radiobutton path="rating" value="5" id="rating5" class="rating-input"/>
                                    <label for="rating5" class="rating-label" title="5 stars">★</label>
                                    
                                    <form:radiobutton path="rating" value="4" id="rating4" class="rating-input"/>
                                    <label for="rating4" class="rating-label" title="4 stars">★</label>
                                    
                                    <form:radiobutton path="rating" value="3" id="rating3" class="rating-input"/>
                                    <label for="rating3" class="rating-label" title="3 stars">★</label>
                                    
                                    <form:radiobutton path="rating" value="2" id="rating2" class="rating-input"/>
                                    <label for="rating2" class="rating-label" title="2 stars">★</label>
                                    
                                    <form:radiobutton path="rating" value="1" id="rating1" class="rating-input"/>
                                    <label for="rating1" class="rating-label" title="1 star">★</label>
                                </div>
                                <div class="invalid-feedback">Please select a rating.</div>
                            </div>

                            <div class="mb-4">
                                <label for="comment" class="form-label">Your Review</label>
                                <form:textarea path="comment" class="form-control" rows="4" required="true"/>
                                <div class="invalid-feedback">Please enter your review.</div>
                            </div>

                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="bi bi-check-circle me-2"></i>Submit Review
                                </button>
                                <a href="/reviews" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-2"></i>Back to Reviews
                                </a>
                            </div>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function() {
            'use strict';
            var forms = document.querySelectorAll('.needs-validation');
            Array.prototype.slice.call(forms).forEach(function(form) {
                form.addEventListener('submit', function(event) {
                    if (!form.checkValidity()) {
                        event.preventDefault();
                        event.stopPropagation();
                    }
                    form.classList.add('was-validated');
                }, false);
            });
        })();
    </script>
</body>
</html> 