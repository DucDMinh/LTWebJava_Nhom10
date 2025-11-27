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

                        <h2>Chi tiết đơn hàng #${order.id}</h2>
                        <p>Trạng thái: ${order.status}</p>
                        <p>Phương thức thanh toán: ${order.paymentMethod}</p>
                        <p>Tổng tiền:
                            <fmt:formatNumber value="${order.totalPrice}" type="currency" currencySymbol="₫" />
                        </p>

                        <table>
                            <thead>
                                <tr>
                                    <th>Sản phẩm</th>
                                    <th>Giá</th>
                                    <th>Số lượng</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${order.items}">
                                    <tr>
                                        <td>${item.productName}</td>
                                        <td>
                                            <fmt:formatNumber value="${item.price}" type="currency"
                                                currencySymbol="₫" />
                                        </td>
                                        <td>${item.quantity}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </main>

                <jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>
                <jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
            </body>

            </html>