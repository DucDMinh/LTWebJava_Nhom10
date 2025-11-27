<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Manage Orders</title>
                <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="/WEB-INF/view/admin/layout/header.jsp"></jsp:include>

                <div id="layoutSidenav">
                    <jsp:include page="/WEB-INF/view/admin/layout/sibar.jsp"></jsp:include>

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Manage Orders</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Orders</li>
                                </ol>

                                <div class="card mb-4">
                                    <div class="card-header">
                                        <i class="fas fa-table me-1"></i>
                                        Orders List
                                    </div>
                                    <div class="card-body">
                                        <table class="table table-bordered table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Customer</th>
                                                    <th>Total Price</th>
                                                    <th>Payment</th>
                                                    <th>Status</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${orders}">
                                                    <tr>
                                                        <td>${order.id}</td>
                                                        <td>${order.user.fullName}</td>
                                                        <td>
                                                            <fmt:formatNumber type="number"
                                                                value="${order.totalPrice}" /> $
                                                        </td>
                                                        <td>${order.paymentMethod}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${order.status == 'COMPLETED'}">
                                                                    <span class="badge bg-success">Completed</span>
                                                                </c:when>
                                                                <c:when test="${order.status == 'CANCELLED'}">
                                                                    <span class="badge bg-danger">Cancelled</span>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <span
                                                                        class="badge bg-warning text-dark">${order.status}</span>
                                                                </c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>
                                                            <a href="/admin/orders/${order.id}"
                                                                class="btn btn-sm btn-success">View</a>
                                                            <a href="/admin/orders/updates/${order.id}"
                                                                class="btn btn-sm btn-warning">Update</a>
                                                            <a href="/admin/orders/deletes/${order.id}"
                                                                class="btn btn-sm btn-danger"
                                                                onclick="return confirm('Are you sure you want to delete order #${order.id}?');">
                                                                Delete
                                                            </a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                                <c:if test="${empty orders}">
                                                    <tr>
                                                        <td colspan="6" class="text-center">No orders found</td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>

                                        <c:if test="${totalPages > 0}">
                                            <nav aria-label="Page navigation">
                                                <ul class="pagination justify-content-center">
                                                    <li class="page-item ${1 eq currentPage ? 'disabled' : ''}">
                                                        <a class="page-link"
                                                            href="/admin/orders?page=${currentPage - 1}"
                                                            aria-label="Previous">
                                                            <span aria-hidden="true">&laquo;</span>
                                                        </a>
                                                    </li>

                                                    <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                                                        <li
                                                            class="page-item ${loop.index eq currentPage ? 'active' : ''}">
                                                            <a class="page-link"
                                                                href="/admin/orders?page=${loop.index}">
                                                                ${loop.index}
                                                            </a>
                                                        </li>
                                                    </c:forEach>

                                                    <li
                                                        class="page-item ${currentPage eq totalPages ? 'disabled' : ''}">
                                                        <a class="page-link"
                                                            href="/admin/orders?page=${currentPage + 1}"
                                                            aria-label="Next">
                                                            <span aria-hidden="true">&raquo;</span>
                                                        </a>
                                                    </li>
                                                </ul>
                                            </nav>
                                        </c:if>
                                    </div>
                                </div>
                            </div>
                        </main>
                        <jsp:include page="/WEB-INF/view/admin/layout/footer.jsp"></jsp:include>
                    </div>
                </div>
                <jsp:include page="/WEB-INF/view/admin/layout/js.jsp"></jsp:include>
            </body>

            </html>
