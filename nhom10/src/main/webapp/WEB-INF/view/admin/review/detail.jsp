<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:include page="/WEB-INF/view/common/variables.jsp"></jsp:include>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Review Detail</title>
    <!--css-->
    <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>
    <style>
        .status-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            display: inline-block;
        }

        .status-pending {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-approved {
            background-color: #d4edda;
            color: #155724;
        }

        .status-rejected {
            background-color: #f8d7da;
            color: #721c24;
        }

        .rating-stars {
            color: #ffc107;
            font-size: 24px;
        }

        .review-detail-card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }

        .user-info {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #dee2e6;
        }

        .user-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            margin-right: 20px;
        }

        .comment-section {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 8px;
            margin-top: 15px;
        }
    </style>
</head>
<body class="sb-nav-fixed">
    <!--header-->
    <jsp:include page="/WEB-INF/view/admin/layout/header.jsp"></jsp:include>
    <div id="layoutSidenav">
        <!--sibar-->
        <jsp:include page="/WEB-INF/view/admin/layout/sibar.jsp"></jsp:include>
        <div id="layoutSidenav_content">
            <main>
                <div class="container-fluid px-4 mt-4">
                    <h1 class="mt-4">Chi tiết Đánh giá</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="/admin/reviews">Reviews</a></li>
                        <li class="breadcrumb-item active">Detail</li>
                    </ol>

                    <c:choose>
                        <c:when test="${empty review}">
                            <div class="alert alert-warning" role="alert">
                                Không tìm thấy đánh giá này.
                            </div>
                            <a href="/admin/reviews" class="btn btn-primary">Quay lại danh sách</a>
                        </c:when>
                        <c:otherwise>
                            <div class="row">
                                <div class="col-md-8 mx-auto">
                                    <div class="review-detail-card">
                                        <!-- User Info -->
                                        <div class="user-info">
                                            <c:if test="${not empty review.avatar}">
                                                <img src="${env}/admin/images/user/${review.avatar}" 
                                                     alt="Avatar" 
                                                     class="user-avatar"
                                                     onerror="this.src='${env}/client/img/default-avatar.png'">
                                            </c:if>
                                            <div>
                                                <h4 class="mb-1">${review.fullName != null ? review.fullName : 'N/A'}</h4>
                                                <p class="text-muted mb-0">User ID: ${review.userId}</p>
                                            </div>
                                        </div>

                                        <!-- Review Info -->
                                        <div class="mb-3">
                                            <h5>Thông tin đánh giá</h5>
                                            <table class="table table-bordered">
                                                <tr>
                                                    <th width="30%">ID Đánh giá:</th>
                                                    <td>${review.id}</td>
                                                </tr>
                                                <tr>
                                                    <th>ID Sản phẩm:</th>
                                                    <td>${review.productId}</td>
                                                </tr>
                                                <tr>
                                                    <th>Đánh giá:</th>
                                                    <td>
                                                        <div class="rating-stars">
                                                            <c:forEach begin="1" end="5" var="i">
                                                                <i class="fas fa-star${i <= review.rating ? '' : '-o'}"></i>
                                                            </c:forEach>
                                                            <span class="ms-2">${review.rating} / 5 sao</span>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>Trạng thái:</th>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${review.status == 'PENDING'}">
                                                                <span class="status-badge status-pending">Chờ duyệt</span>
                                                            </c:when>
                                                            <c:when test="${review.status == 'APPROVED'}">
                                                                <span class="status-badge status-approved">Đã duyệt</span>
                                                            </c:when>
                                                            <c:when test="${review.status == 'REJECTED'}">
                                                                <span class="status-badge status-rejected">Đã từ chối</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="status-badge">${review.status}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>Ngày tạo:</th>
                                                    <td>
                                                        <c:if test="${review.createdAt != null}">
                                                            ${fn:replace(review.createdAt.toString(), 'T', ' ')}
                                                        </c:if>
                                                        <c:if test="${review.createdAt == null}">N/A</c:if>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>

                                        <!-- Comment Section -->
                                        <div class="comment-section">
                                            <h6 class="mb-3">Nội dung đánh giá:</h6>
                                            <p class="mb-0">${review.comment != null ? review.comment : 'Không có nội dung'}</p>
                                        </div>

                                        <!-- Action Buttons -->
                                        <div class="mt-4 d-flex gap-2">
                                            <c:if test="${review.status == 'PENDING'}">
                                                <form action="/admin/reviews/approve" method="post" style="display: inline-block;">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <input type="hidden" name="id" value="${review.id}">
                                                    <button type="submit" 
                                                            class="btn btn-success" 
                                                            onclick="return confirm('Bạn có chắc muốn duyệt đánh giá này?');">
                                                        <i class="fas fa-check me-2"></i>Duyệt đánh giá
                                                    </button>
                                                </form>
                                                <form action="/admin/reviews/reject" method="post" style="display: inline-block;">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                    <input type="hidden" name="id" value="${review.id}">
                                                    <button type="submit" 
                                                            class="btn btn-warning" 
                                                            onclick="return confirm('Bạn có chắc muốn từ chối đánh giá này?');">
                                                        <i class="fas fa-times me-2"></i>Từ chối
                                                    </button>
                                                </form>
                                            </c:if>
                                            <form action="/admin/reviews/delete" method="post" style="display: inline-block;">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <input type="hidden" name="id" value="${review.id}">
                                                <button type="submit" 
                                                        class="btn btn-danger" 
                                                        onclick="return confirm('Bạn có chắc muốn xóa đánh giá này? Hành động này không thể hoàn tác!');">
                                                    <i class="fas fa-trash me-2"></i>Xóa đánh giá
                                                </button>
                                            </form>
                                            <a href="/admin/reviews" class="btn btn-secondary">
                                                <i class="fas fa-arrow-left me-2"></i>Quay lại
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </main>
            <!--footer-->
            <jsp:include page="/WEB-INF/view/admin/layout/footer.jsp"></jsp:include>
        </div>
    </div>
    <!--js-->
    <jsp:include page="/WEB-INF/view/admin/layout/js.jsp"></jsp:include>
</body>
</html>

