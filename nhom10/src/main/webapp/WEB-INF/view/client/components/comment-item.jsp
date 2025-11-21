<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<div class="comment mb-4 p-4 border rounded">
    <div class="comment-header d-flex align-items-center mb-3">
        <div class="user-avatar me-3">
            <c:choose>
                <c:when test="${not empty comment.user.avatar and comment.user.avatar != null}">
                    <img src="${pageContext.request.contextPath}/images/user/${comment.user.avatar}" 
                         class="rounded-circle" width="50" height="50" alt="Avatar">
                </c:when>
                <c:otherwise>
                    <div class="rounded-circle bg-secondary d-flex align-items-center justify-content-center" 
                         style="width: 50px; height: 50px;">
                        <span class="text-white fw-bold">${fn:substring(comment.user.fullName, 0, 1)}</span>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
        <div class="user-info">
            <h6 class="mb-0">${comment.user.fullName}</h6>
            <div class="rating-stars d-flex">
                <c:forEach begin="1" end="5" var="star">
                    <c:choose>
                        <c:when test="${star <= comment.rating}">
                            <svg class="me-1" width="16" height="16" fill="currentColor">
                                <use xlink:href="#star-fill"></use>
                            </svg>
                        </c:when>
                        <c:when test="${star - 0.5 <= comment.rating}">
                            <svg class="me-1" width="16" height="16" fill="currentColor">
                                <use xlink:href="#star-half"></use>
                            </svg>
                        </c:when>
                        <c:otherwise>
                            <svg class="me-1" width="16" height="16" fill="currentColor">
                                <use xlink:href="#star-empty"></use>
                            </svg>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <span class="text-muted ms-2 small">
                    <fmt:formatDate value="${comment.createdDate}" pattern="dd/MM/yyyy" />
                </span>
            </div>
        </div>
    </div>
    
    <div class="comment-content mb-3">
        <p class="mb-0">${comment.comment}</p>
    </div>
    
    <div class="comment-footer d-flex justify-content-between align-items-center">
        <div class="comment-actions">
            <button class="btn btn-sm btn-outline-secondary me-2 thumb-up-btn" onclick="toggleThumbUp(this)">
                <svg width="16" height="16" fill="currentColor" class="me-1">
                    <use xlink:href="#hand-thumbs-up"></use>
                </svg>
                <span class="thumb-count">24</span>
            </button>
            <button class="btn btn-sm btn-outline-secondary">
                <svg width="16" height="16" fill="currentColor" class="me-1">
                    <use xlink:href="#cart"></use>
                </svg>
                Trả lời
            </button>
        </div>
    </div>
</div>