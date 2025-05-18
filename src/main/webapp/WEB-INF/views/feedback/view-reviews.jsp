<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Reviews - Feedback and Review Management</title>
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
        .action-buttons {
            position: absolute;
            top: 10px;
            right: 10px;
            display: none;
        }
        .review-card:hover .action-buttons {
            display: block;
        }
        .rating-input {
            display: none;
        }
        .modal .rating-label {
            cursor: pointer;
            font-size: 1.5rem;
            color: #ddd;
            transition: all 0.2s;
        }
        .modal .rating-label:hover,
        .modal .rating-label:hover ~ .rating-label,
        .modal .rating-input:checked ~ .rating-label {
            color: #ffc107;
        }
        .modal .rating-group {
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
                        <a class="nav-link active" href="/reviews">View Reviews</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/reviews/submit">Submit Review</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container my-4">
        <div class="row">
            <div class="col-12">
                <div class="card">
                    <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                        <h4 class="mb-0">Customer Reviews</h4>
                        <a href="/reviews/submit" class="btn btn-primary">
                            <i class="bi bi-plus-circle me-2"></i>Submit New Review
                        </a>
                    </div>
                    <div class="card-body">
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

                        <c:choose>
                            <c:when test="${not empty reviews}">
                                <div class="row g-4">
                                    <c:forEach items="${reviews}" var="review">
                                        <div class="col-md-6 col-lg-4">
                                            <div class="card review-card h-100 position-relative">
                                                <div class="action-buttons">
                                                    <button class="btn btn-sm btn-outline-primary me-1" 
                                                            onclick="editReview('${review.id}', '${review.vehicleId}', '${review.userName}', ${review.rating}, '${review.comment}')"
                                                            title="Edit Review">
                                                        <i class="bi bi-pencil"></i>
                                                    </button>
                                                </div>
                                                <div class="card-body">
                                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                                        <h5 class="card-title mb-0">Vehicle ID: ${review.vehicleId}</h5>
                                                        <div class="rating-stars">
                                                            <c:forEach begin="1" end="5" var="star">
                                                                <i class="bi ${star <= review.rating ? 'bi-star-fill' : 'bi-star'}"></i>
                                                            </c:forEach>
                                                        </div>
                                                    </div>
                                                    <p class="card-text">${review.comment}</p>
                                                    <div class="d-flex justify-content-between align-items-center mt-3">
                                                        <small class="text-muted">By: ${review.userName}</small>
                                                        <small class="text-muted">
                                                            <fmt:formatDate value="${review.reviewDate}" pattern="MMM dd, yyyy HH:mm"/>
                                                        </small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="text-center py-5">
                                    <i class="bi bi-chat-square-text display-1 text-muted mb-3"></i>
                                    <h5>No Reviews Yet</h5>
                                    <p class="text-muted">Be the first to share your experience!</p>
                                    <a href="/reviews/submit" class="btn btn-primary">
                                        <i class="bi bi-plus-circle me-2"></i>Submit a Review
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Edit Review Modal -->
    <div class="modal fade" id="editReviewModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Edit Review</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="editReviewForm" action="/reviews/update" method="post">
                        <input type="hidden" id="editReviewId" name="id">
                        
                        <div class="mb-3">
                            <label for="editVehicleId" class="form-label">Vehicle ID</label>
                            <input type="text" class="form-control" id="editVehicleId" name="vehicleId" required>
                        </div>

                        <div class="mb-3">
                            <label for="editUserName" class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="editUserName" name="userName" required>
                        </div>

                        <div class="mb-3">
                            <label class="form-label d-block">Rating</label>
                            <div class="rating-group">
                                <input type="radio" name="rating" value="5" id="editRating5" class="rating-input" required>
                                <label for="editRating5" class="rating-label" title="5 stars">★</label>
                                
                                <input type="radio" name="rating" value="4" id="editRating4" class="rating-input">
                                <label for="editRating4" class="rating-label" title="4 stars">★</label>
                                
                                <input type="radio" name="rating" value="3" id="editRating3" class="rating-input">
                                <label for="editRating3" class="rating-label" title="3 stars">★</label>
                                
                                <input type="radio" name="rating" value="2" id="editRating2" class="rating-input">
                                <label for="editRating2" class="rating-label" title="2 stars">★</label>
                                
                                <input type="radio" name="rating" value="1" id="editRating1" class="rating-input">
                                <label for="editRating1" class="rating-label" title="1 star">★</label>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="editComment" class="form-label">Your Review</label>
                            <textarea class="form-control" id="editComment" name="comment" rows="4" required></textarea>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" form="editReviewForm" class="btn btn-primary">Save Changes</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Initialize edit modal
        const editModal = new bootstrap.Modal(document.getElementById('editReviewModal'));
        
        // Function to populate and show edit modal
        function editReview(id, vehicleId, userName, rating, comment) {
            document.getElementById('editReviewId').value = id;
            document.getElementById('editVehicleId').value = vehicleId;
            document.getElementById('editUserName').value = userName;
            document.getElementById('editComment').value = comment;
            document.getElementById('editRating' + rating).checked = true;
            editModal.show();
        }
    </script>
</body>
</html> 