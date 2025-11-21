<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<div class="comments-section mt-5">
    <h3 class="mb-4">Bình luận sản phẩm</h3>
    
    <!-- Comment form (only visible to logged in users) -->
    <c:choose>
        <c:when test="${not empty sessionScope.id}">
            <div class="comment-form mb-5">
                <!-- Validation message area -->
                <div id="validationMessage" class="alert alert-dismissible fade d-none mb-3" role="alert">
                    <span id="validationText"></span>
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
                
                <form id="commentForm" action="${pageContext.request.contextPath}/client/comment" method="post">
                    <div class="mb-3">
                        <textarea class="form-control" id="commentText" name="commentText" rows="3" 
                                  placeholder="Viết bình luận của bạn..." required></textarea>
                    </div>
                    <div class="d-flex justify-content-between align-items-center">
                        <div class="rating-input">
                            <label class="form-label text-muted small mb-1 me-2">Đánh giá:</label>
                            <c:forEach begin="1" end="5" var="star">
                                <button type="button" class="btn btn-sm p-0 star-rating" 
                                        data-rating="${star}">
                                    <svg width="24" height="24" fill="currentColor">
                                        <use xlink:href="#star-empty"></use>
                                    </svg>
                                </button>
                            </c:forEach>
                        </div>
                        <button type="submit" class="btn btn-primary">Gửi bình luận</button>
                    </div>
                    <input type="hidden" id="ratingValue" name="rating" value="0">
                </form>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info mb-4">
                <p class="mb-0">Vui lòng <a href="${pageContext.request.contextPath}/home/signin">đăng nhập</a> để bình luận sản phẩm.</p>
            </div>
        </c:otherwise>
    </c:choose>
    
    <!-- Comments list -->
    <div class="comments-list">
        <!-- Since we don't have actual comment data yet, we'll show hardcoded examples -->
        <!-- This would be a real comment from a user, but using a realistic example for now -->
        <div class="comment mb-4 p-4 border rounded">
            <div class="comment-header d-flex align-items-center mb-3">
                <div class="user-avatar me-3">
                    <img src="${pageContext.request.contextPath}/client/img/commentor-item1.jpg"
                         class="rounded-circle" width="50" height="50" alt="Avatar">
                </div>
                <div class="user-info">
                    <h6 class="mb-0">Nguyễn Văn A</h6>
                    <div class="rating-stars d-flex">
                        <svg class="me-1" width="16" height="16" fill="currentColor">
                            <use xlink:href="#star-fill"></use>
                        </svg>
                        <svg class="me-1" width="16" height="16" fill="currentColor">
                            <use xlink:href="#star-fill"></use>
                        </svg>
                        <svg class="me-1" width="16" height="16" fill="currentColor">
                            <use xlink:href="#star-fill"></use>
                        </svg>
                        <svg class="me-1" width="16" height="16" fill="currentColor">
                            <use xlink:href="#star-fill"></use>
                        </svg>
                        <svg class="me-1" width="16" height="16" fill="currentColor">
                            <use xlink:href="#star-empty"></use>
                        </svg>
                        <span class="text-muted ms-2 small">15/10/2024</span>
                    </div>
                </div>
            </div>

            <div class="comment-content mb-3">
                <p class="mb-0">Sản phẩm rất tốt, chất lượng vượt trội so với giá tiền. Mình đã sử dụng được 2 tháng và hoàn toàn hài lòng.</p>
            </div>

            <div class="comment-footer">
                <div class="comment-actions">
                    <button class="btn btn-sm btn-outline-secondary thumb-up-btn" onclick="toggleThumbUp(this)">
                        <svg width="16" height="16" fill="currentColor" class="me-1">
                            <use xlink:href="#hand-thumbs-up"></use>
                        </svg>
                        <span class="thumb-count">24</span>
                    </button>
                </div>
            </div>
        </div>
        
        <div class="comment mb-4 p-4 border rounded">
            <div class="comment-header d-flex align-items-center mb-3">
                <div class="user-avatar me-3">
                    <img src="${pageContext.request.contextPath}/client/img/commentor-item2.jpg" 
                         class="rounded-circle" width="50" height="50" alt="Avatar">
                </div>
                <div class="user-info">
                    <h6 class="mb-0">Trần Thị B</h6>
                    <div class="rating-stars d-flex">
                        <svg class="me-1" width="16" height="16" fill="currentColor">
                            <use xlink:href="#star-fill"></use>
                        </svg>
                        <svg class="me-1" width="16" height="16" fill="currentColor">
                            <use xlink:href="#star-fill"></use>
                        </svg>
                        <svg class="me-1" width="16" height="16" fill="currentColor">
                            <use xlink:href="#star-fill"></use>
                        </svg>
                        <svg class="me-1" width="16" height="16" fill="currentColor">
                            <use xlink:href="#star-empty"></use>
                        </svg>
                        <svg class="me-1" width="16" height="16" fill="currentColor">
                            <use xlink:href="#star-empty"></use>
                        </svg>
                        <span class="text-muted ms-2 small">10/10/2024</span>
                    </div>
                </div>
            </div>
            
            <div class="comment-content mb-3">
                <p class="mb-0">Máy chạy nhanh, mượt, pin khỏe. Tuy nhiên camera chưa thực sự xuất sắc như quảng cáo.</p>
            </div>
            
            <div class="comment-footer">
                <div class="comment-actions">
                    <button class="btn btn-sm btn-outline-secondary thumb-up-btn" onclick="toggleThumbUp(this)">
                        <svg width="16" height="16" fill="currentColor" class="me-1">
                            <use xlink:href="#hand-thumbs-up"></use>
                        </svg>
                        <span class="thumb-count">18</span>
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>