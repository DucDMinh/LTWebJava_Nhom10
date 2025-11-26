<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html>

            <head>
                <title>Lịch sử mua hàng - CellWorld</title>
                <meta charset="utf-8">
                <jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>

                <style>
                    .order-history {
                        max-width: 1100px;
                        margin: auto;
                    }

                    .order-table {
                        width: 100%;
                        border-collapse: collapse;
                    }

                    .order-table th,
                    .order-table td {
                        padding: 14px 12px;
                        text-align: left;
                        border-bottom: 1px solid #eee;
                    }

                    .order-table thead {
                        background: #fafafa;
                        font-weight: 600;
                        text-transform: uppercase;
                    }

                    .btn-detail {
                        padding: 5px 12px;
                        background-color: #64d48c6e;
                        border-radius: 6px;
                    }

                    .status {
                        padding: 6px 12px;
                        border-radius: 16px;
                        color: #fff;
                        font-size: 13px;
                    }

                    .paid {
                        background: #28a745;
                    }

                    .pending {
                        background: #ffc107;
                    }

                    .cancelled {
                        background: #dc3545;
                    }
                </style>
            </head>

            <body>
                <jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

                <!-- Banner -->
                <section style="background: url(/client/img/banner.jpg) center/cover no-repeat; height: 300px;">
                </section>

                <main class="mt-5">
                    <div class="container order-history">
                        <!-- Breadcrumb -->
                        <nav aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="/home">Trang chủ</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Lịch sử mua hàng</li>
                            </ol>
                        </nav>

                        <h2 class="fw-bold text-center mb-4">Lịch sử mua hàng</h2>

                        <table class="order-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Mã Đơn</th>
                                    <th>Tổng tiền</th>
                                    <th>Thanh toán</th>
                                    <th>Trạng thái</th>
                                    <th>Chi tiết</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td>${order.id}</td>
                                        <td>${order.paymentRef}</td>
                                        <td>
                                            <fmt:formatNumber value="${order.totalPrice}" type="currency"
                                                currencySymbol="₫" />
                                        </td>
                                        <td>${order.paymentMethod}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${order.status == 'PAID'}">
                                                    <span class="status paid">Đã thanh toán</span>
                                                </c:when>
                                                <c:when test="${order.status == 'PENDING'}">
                                                    <span class="status pending">Chờ xử lý</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status cancelled">Đã hủy</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <a href="/order/detail/${order.id}" class="btn-detail">Xem</a>
                                        </td>
                                    </tr>
                                </c:forEach>

                                <c:if test="${empty orders}">
                                    <tr>
                                        <td colspan="6" class="text-center py-4">Bạn chưa có đơn hàng nào.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </main>

                <jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>
                <jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
            </body>

            </html>