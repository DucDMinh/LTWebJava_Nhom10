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
    <title>Review Management</title>
    <!--css-->
    <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>
    <style>
        .header__search {
            width: 372px;
            height: 56px;
            background-color: var(--bgr-search);
            border-radius: 10px;
            border: 1px solid black;
        }

        .header__search--input {
            border: 0;
            outline: none;
            background-color: transparent;
            padding: 0 10px;
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
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
            font-size: 18px;
        }

        .review-comment {
            max-width: 400px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .filter-section {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 20px;
        }

        .table-responsive {
            overflow-x: auto;
        }

        .action-buttons {
            white-space: nowrap;
        }

        .action-buttons .btn {
            margin: 2px;
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
                    <h1 class="mt-4">Quản lý Đánh giá</h1>
                    <ol class="breadcrumb mb-4">
                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                        <li class="breadcrumb-item active">Reviews</li>
                    </ol>

                    <!-- Filter and Search Section -->
                    <div class="filter-section">
                        <form action="/admin/reviews" method="get" class="row g-3">
                            <div class="col-md-3">
                                <label for="status" class="form-label">Lọc theo trạng thái:</label>
                                <select class="form-select" id="status" name="status" onchange="this.form.submit()">
                                    <option value="ALL" ${statusFilter == 'ALL' ? 'selected' : ''}>Tất cả</option>
                                    <option value="PENDING" ${statusFilter == 'PENDING' ? 'selected' : ''}>Chờ duyệt</option>
                                    <option value="APPROVED" ${statusFilter == 'APPROVED' ? 'selected' : ''}>Đã duyệt</option>
                                    <option value="REJECTED" ${statusFilter == 'REJECTED' ? 'selected' : ''}>Đã từ chối</option>
                                </select>
                            </div>
                            <div class="col-md-6">
                                <label for="search" class="form-label">Tìm kiếm:</label>
                                <div class="header__search d-flex align-items-center">
                                    <label for="search" class="p-2">
                                        <i class="fas fa-search"></i>
                                    </label>
                                    <input type="text" 
                                           placeholder="Tìm theo tên người dùng hoặc nội dung đánh giá" 
                                           name="search" 
                                           class="header__search--input flex-grow-1" 
                                           id="search" 
                                           value="${search}">
                                </div>
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
                            </div>
                            <input type="hidden" name="page" value="0">
                        </form>
                    </div>

                    <!-- Statistics -->
                    <div class="row mb-3">
                        <div class="col-md-12">
                            <div class="card">
                                <div class="card-body">
                                    <p class="mb-0">
                                        <strong>Tổng số đánh giá:</strong> ${totalItems} 
                                        <c:if test="${statusFilter != 'ALL'}">
                                            (Trạng thái: ${statusFilter})
                                        </c:if>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Reviews Table -->
                    <div class="card mb-4">
                        <div class="card-header">
                            <i class="fas fa-table me-1"></i>
                            Danh sách đánh giá
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <thead class="table-light">
                                        <tr>
                                            <th>ID</th>
                                            <th>Người đánh giá</th>
                                            <th>ID Sản phẩm</th>
                                            <th>Đánh giá</th>
                                            <th>Nội dung</th>
                                            <th>Trạng thái</th>
                                            <th>Ngày tạo</th>
                                            <th>Thao tác</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:choose>
                                            <c:when test="${empty reviews}">
                                                <tr>
                                                    <td colspan="8" class="text-center">
                                                        <p class="text-muted mt-3">Không có đánh giá nào.</p>
                                                    </td>
                                                </tr>
                                            </c:when>
                                            <c:otherwise>
                                                <c:forEach var="review" items="${reviews}">
                                                    <tr>
                                                        <td>${review.id}</td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <c:if test="${not empty review.avatar}">
                                                                    <img src="${env}/admin/images/user/${review.avatar}" 
                                                                         alt="Avatar" 
                                                                         class="rounded-circle me-2" 
                                                                         width="30" 
                                                                         height="30"
                                                                         onerror="this.src='${env}/client/img/avatar2.jpg'">
                                                                </c:if>
                                                                <span>${review.fullName != null ? review.fullName : 'N/A'}</span>
                                                            </div>
                                                        </td>
                                                        <td>${review.productId}</td>
                                                        <td>
                                                            <div class="rating-stars">
                                                                <c:forEach begin="1" end="5" var="i">
                                                                    <i class="fas fa-star${i <= review.rating ? '' : '-o'}"></i>
                                                                </c:forEach>
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <div class="review-comment" title="${review.comment}">
                                                                ${fn:substring(review.comment != null ? review.comment : '', 0, 50)}
                                                                ${fn:length(review.comment != null ? review.comment : '') > 50 ? '...' : ''}
                                                            </div>
                                                        </td>
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
                                                        <td>
                                                            <c:if test="${review.createdAt != null}">
                                                                ${fn:replace(fn:substring(review.createdAt.toString(), 0, 16), 'T', ' ')}
                                                            </c:if>
                                                            <c:if test="${review.createdAt == null}">N/A</c:if>
                                                        </td>
                                                        <td>
                                                            <div class="action-buttons">
                                                                <a href="/admin/reviews/${review.id}" 
                                                                   class="btn btn-sm btn-info" 
                                                                   title="Xem chi tiết">
                                                                    <i class="fas fa-eye"></i>
                                                                </a>
                                                                <c:if test="${review.status == 'PENDING'}">
                                                                    <form action="/admin/reviews/approve" 
                                                                          method="post" 
                                                                          style="display: inline-block;">
                                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                        <input type="hidden" name="id" value="${review.id}">
                                                                        <input type="hidden" name="status" value="${statusFilter}">
                                                                        <input type="hidden" name="page" value="${currentPage}">
                                                                        <c:if test="${not empty search}">
                                                                            <input type="hidden" name="search" value="${search}">
                                                                        </c:if>
                                                                        <button type="submit" 
                                                                                class="btn btn-sm btn-success" 
                                                                                title="Duyệt"
                                                                                onclick="return confirm('Bạn có chắc muốn duyệt đánh giá này?');">
                                                                            <i class="fas fa-check"></i>
                                                                        </button>
                                                                    </form>
                                                                    <form action="/admin/reviews/reject" 
                                                                          method="post" 
                                                                          style="display: inline-block;">
                                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                        <input type="hidden" name="id" value="${review.id}">
                                                                        <input type="hidden" name="status" value="${statusFilter}">
                                                                        <input type="hidden" name="page" value="${currentPage}">
                                                                        <c:if test="${not empty search}">
                                                                            <input type="hidden" name="search" value="${search}">
                                                                        </c:if>
                                                                        <button type="submit" 
                                                                                class="btn btn-sm btn-warning" 
                                                                                title="Từ chối"
                                                                                onclick="return confirm('Bạn có chắc muốn từ chối đánh giá này?');">
                                                                            <i class="fas fa-times"></i>
                                                                        </button>
                                                                    </form>
                                                                </c:if>
                                                                <form action="/admin/reviews/delete" 
                                                                      method="post" 
                                                                      style="display: inline-block;">
                                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                                    <input type="hidden" name="id" value="${review.id}">
                                                                    <input type="hidden" name="status" value="${statusFilter}">
                                                                    <input type="hidden" name="page" value="${currentPage}">
                                                                    <c:if test="${not empty search}">
                                                                        <input type="hidden" name="search" value="${search}">
                                                                    </c:if>
                                                                    <button type="submit" 
                                                                            class="btn btn-sm btn-danger" 
                                                                            title="Xóa"
                                                                            onclick="return confirm('Bạn có chắc muốn xóa đánh giá này? Hành động này không thể hoàn tác!');">
                                                                        <i class="fas fa-trash"></i>
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </c:forEach>
                                            </c:otherwise>
                                        </c:choose>
                                    </tbody>
                                </table>
                            </div>

                            <!-- Pagination -->
                            <c:if test="${totalPages > 1}">
                                <div class="paging d-flex justify-content-center align-items-center mt-4">
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination">
                                            <li class="page-item">
                                                <a class="page-link ${currentPage == 0 ? 'disabled' : ''}" 
                                                   href="/admin/reviews?status=${statusFilter}&page=${currentPage - 1}&search=${search != null ? search : ''}" 
                                                   aria-label="Previous">
                                                    <span aria-hidden="true">&laquo;</span>
                                                </a>
                                            </li>
                                            <c:forEach begin="0" end="${totalPages - 1}" varStatus="loop">
                                                <li class="page-item">
                                                    <a class="page-link ${loop.index == currentPage ? 'active' : ''}" 
                                                       href="/admin/reviews?status=${statusFilter}&page=${loop.index}&search=${search != null ? search : ''}">
                                                        ${loop.index + 1}
                                                    </a>
                                                </li>
                                            </c:forEach>
                                            <li class="page-item">
                                                <a class="page-link ${currentPage == totalPages - 1 ? 'disabled' : ''}" 
                                                   href="/admin/reviews?status=${statusFilter}&page=${currentPage + 1}&search=${search != null ? search : ''}" 
                                                   aria-label="Next">
                                                    <span aria-hidden="true">&raquo;</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </div>
                            </c:if>
                        </div>
                    </div>
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

