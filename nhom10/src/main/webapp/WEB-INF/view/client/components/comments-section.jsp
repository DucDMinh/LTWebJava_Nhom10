<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="comments-section mt-5">
    <h3 class="mb-4">Bình luận sản phẩm</h3>

    <!-- Success/Error Messages -->
    <c:if test="${not empty msg}">
        <div class="alert alert-success alert-dismissible fade show mb-4" role="alert">
            <i class="fas fa-check-circle me-2"></i>${msg}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show mb-4" role="alert">
            <i class="fas fa-exclamation-circle me-2"></i>${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>

    <!-- Comment form -->
    <c:choose>
        <c:when test="${not empty sessionScope.id}">
            <div class="comment-form mb-5">

                <!-- Validation Message -->
                <div id="validationMessage" class="alert alert-dismissible fade d-none mb-3" role="alert">
                    <span id="validationText"></span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>

                <form id="commentForm" action="${pageContext.request.contextPath}/client/review/add" method="post">
                    <div class="mb-3">
                        <textarea class="form-control" id="commentText" name="commentText" rows="4"
                                  placeholder="Viết bình luận của bạn về sản phẩm này..." 
                                  required 
                                  minlength="10"
                                  maxlength="1000"></textarea>
                        <small class="text-muted">Tối thiểu 10 ký tự, tối đa 1000 ký tự</small>
                    </div>

                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div class="rating-input">
                            <label class="form-label text-muted small mb-1 me-2">Đánh giá: <span class="text-danger">*</span></label>
                            <div class="d-flex align-items-center">
                                <c:forEach begin="1" end="5" var="star">
                                    <button type="button" class="btn btn-sm p-0 me-1 star-rating" data-rating="${star}" 
                                            title="${star} sao">
                                        <svg width="28" height="28" fill="currentColor" class="text-warning">
                                            <use xlink:href="#star-empty"></use>
                                        </svg>
                                    </button>
                                </c:forEach>
                                <span id="ratingText" class="ms-2 text-muted small">Chưa chọn</span>
                            </div>
                        </div>
                        <button type="submit" class="btn btn-primary" id="submitBtn">
                            <span class="spinner-border spinner-border-sm d-none" id="submitSpinner" role="status" aria-hidden="true"></span>
                            <span id="submitText">Gửi bình luận</span>
                        </button>
                    </div>

                    <input type="hidden" id="ratingValue" name="rating" value="0">
                    <input type="hidden" name="productId" value="${product.id}">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                </form>
            </div>
        </c:when>

        <c:otherwise>
            <div class="alert alert-info mb-4">
                <p class="mb-0">
                    Vui lòng <a href="${pageContext.request.contextPath}/home/signin">đăng nhập</a> để bình luận sản phẩm.
                </p>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Comments list -->
    <div class="comments-list">

        <c:if test="${empty comments}">
            <div class="alert alert-secondary">Chưa có bình luận nào. Hãy là người đầu tiên!</div>
        </c:if>

        <c:forEach var="cmt" items="${comments}">
            <div class="comment mb-4 p-4 border rounded shadow-sm">

                <!-- Header -->
                <div class="comment-header d-flex align-items-center mb-3">
                    <div class="user-avatar me-3">
                        <c:choose>
                            <c:when test="${not empty cmt.avatar}">
                                <img src="${pageContext.request.contextPath}/admin/images/user/${cmt.avatar}"
                                     class="rounded-circle" width="50" height="50" alt="Avatar"
                                     onerror="this.src='${pageContext.request.contextPath}/client/img/default-avatar.png'">
                            </c:when>
                            <c:otherwise>
                                <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center text-white fw-bold"
                                     style="width: 50px; height: 50px;">
                                    ${fn:substring(cmt.fullName != null ? cmt.fullName : 'U', 0, 1)}
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="user-info flex-grow-1">
                        <h6 class="mb-1 fw-bold">${cmt.fullName != null ? cmt.fullName : 'Người dùng'}</h6>

                        <div class="rating-stars d-flex align-items-center">
                            <div class="d-flex me-2">
                                <c:forEach begin="1" end="5" var="star">
                                    <svg class="me-1" width="16" height="16" fill="currentColor">
                                        <c:choose>
                                            <c:when test="${star <= cmt.rating}">
                                                <use xlink:href="#star-fill"></use>
                                            </c:when>
                                            <c:otherwise>
                                                <use xlink:href="#star-empty"></use>
                                            </c:otherwise>
                                        </c:choose>
                                    </svg>
                                </c:forEach>
                            </div>
                            <span class="text-muted small">
                                <c:if test="${cmt.createdAt != null}">
                                    ${fn:replace(fn:substring(cmt.createdAt.toString(), 0, 10), '-', '/')}
                                </c:if>
                            </span>
                        </div>
                    </div>
                </div>

                <!-- Content -->
                <div class="comment-content mb-3">
                    <p class="mb-0 text-secondary">${cmt.comment}</p>
                </div>

                <!-- Footer -->
                <div class="comment-footer">
                    <button class="btn btn-sm btn-outline-secondary thumb-up-btn"
                            onclick="toggleThumbUp(this)"
                            data-comment-id="${cmt.id}">
                        <svg width="16" height="16" fill="currentColor" class="me-1">
                            <use xlink:href="#hand-thumbs-up"></use>
                        </svg>
                        <span class="thumb-count">0</span>
                    </button>
                </div>

            </div>
        </c:forEach>

    </div>
</div>
