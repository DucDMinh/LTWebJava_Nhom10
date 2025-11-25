<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="" />
                    <meta name="author" content="" />
                    <title>order</title>
                    <!--css-->
                    <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>
                    <style>
                        /* Header */
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

                                <div class="container mt-5">
                                    <h1 class="mt-4">Manage order</h1>
                                    <ol class="breadcrumb mb-4">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item active">orders</li>
                                    </ol>
                                    <div class="row">
                                        <div class="col-12 mx-auto">
                                            <table class="table table-bordered table table-hover">
                                                <thead>
                                                    <tr>
                                                        <th scope="col">ID</th>
                                                        <th scope="col">Name</th>
                                                        <th scope="col">Total Price</th>
                                                        <th scope="col">Payment Method</th>
                                                        <th scope="col">Payment Status</th>
                                                        <th scope="col">Action</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="order" items="${orders}">
                                                        <tr>
                                                            <td>${order.id}</td>
                                                            <td>${order.user.fullName}</td>
                                                            <td>
                                                                <fmt:formatNumber type="number"
                                                                    value="${order.totalPrice}" />
                                                                $
                                                            </td>
                                                            <td>${order.paymentMethod}</td>
                                                            <td>${order.paymentStatus}</td>
                                                            <td>
                                                                <a href="/admin/orders/${order.id}" type="submit"
                                                                    class="btn btn-success">View</a>
                                                                <a href="/admin/order/update/${order.id}" type="submit"
                                                                    class="btn btn-warning">Update</a>
                                                                <a href="/admin/order/delete-${order.id}" type="submit"
                                                                    class="btn btn-danger">Delete</a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                            <a href="/admin" class="btn btn-success">Back</a>
                                            <c:if test="${totalPages > 0}">
                                                <div class="paging d-flex justify-content-center align-items-center ">
                                                    <nav aria-label="Page navigation example">
                                                        <ul class="pagination ">
                                                            <li class="page-item">
                                                                <a class="${1 eq currentPage ? 'd-none' : 'page-link'}"
                                                                    href="/admin/users?page=${currentPage -1}&name=${nameSearch}"
                                                                    aria-label="Previous">
                                                                    <span aria-hidden="true">&laquo;</span>
                                                                </a>
                                                            </li>
                                                            <c:forEach begin="0" end="${totalPages -1}"
                                                                varStatus="loop">
                                                                <li class="page-item">
                                                                    <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                                                        href="/admin/users?page=${loop.index + 1}&name=${nameSearch}">
                                                                        ${loop.index + 1}
                                                                    </a>
                                                                </li>
                                                            </c:forEach>
                                                            <li class="page-item">
                                                                <a class="${currentPage eq totalPages? 'd-none' : 'page-link'}"
                                                                    href="/admin/users?page=${currentPage +1}&name=${nameSearch}"
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