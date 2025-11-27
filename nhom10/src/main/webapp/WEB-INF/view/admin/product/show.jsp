<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Manage Products</title>
                <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="/WEB-INF/view/admin/layout/header.jsp"></jsp:include>

                <div id="layoutSidenav">
                    <jsp:include page="/WEB-INF/view/admin/layout/sibar.jsp"></jsp:include>

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <h1 class="mt-4">Manage Products</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Products</li>
                                </ol>

                                <div class="card mb-4">
                                    <div class="card-header d-flex justify-content-between align-items-center">
                                        <div>
                                            <i class="fas fa-table me-1"></i>
                                            Danh sách sản phẩm
                                        </div>
                                        <a href="/admin/product/create" class="btn btn-primary btn-sm">
                                            <i class="fas fa-plus me-1"></i> Create New Product
                                        </a>
                                    </div>

                                    <div class="card-body">
                                        <table class="table table-bordered table-hover">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Name</th>
                                                    <th>Price</th>
                                                    <th>Factory</th>
                                                    <th>Action</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="product" items="${products}">
                                                    <tr>
                                                        <td>${product.id}</td>
                                                        <td>${product.name}</td>
                                                        <td>
                                                            <fmt:formatNumber type="number" value="${product.price}" />
                                                            $
                                                        </td>
                                                        <td>${product.factory}</td>
                                                        <td>
                                                            <a href="/admin/product/detail/${product.id}"
                                                                class="btn btn-sm btn-success">View</a>
                                                            <a href="/admin/product/update/${product.id}"
                                                                class="btn btn-sm btn-warning">Update</a>
                                                            <a href="/admin/product/delete/${product.id}"
                                                                class="btn btn-sm btn-danger">Delete</a>
                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                                <c:if test="${empty products}">
                                                    <tr>
                                                        <td colspan="5" class="text-center">No products found</td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>

                                        <c:if test="${totalPages > 0}">
                                            <div class="d-flex justify-content-center mt-4">
                                                <nav aria-label="Page navigation">
                                                    <ul class="pagination">
                                                        <li class="page-item ${1 eq currentPage ? 'disabled' : ''}">
                                                            <a class="page-link"
                                                                href="/admin/product?page=${currentPage - 1}"
                                                                aria-label="Previous">
                                                                <span aria-hidden="true">&laquo;</span>
                                                            </a>
                                                        </li>

                                                        <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                                                            <li
                                                                class="page-item ${loop.index eq currentPage ? 'active' : ''}">
                                                                <a class="page-link"
                                                                    href="/admin/product?page=${loop.index}">
                                                                    ${loop.index}
                                                                </a>
                                                            </li>
                                                        </c:forEach>

                                                        <li
                                                            class="page-item ${currentPage eq totalPages ? 'disabled' : ''}">
                                                            <a class="page-link"
                                                                href="/admin/product?page=${currentPage + 1}"
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
                        <jsp:include page="/WEB-INF/view/admin/layout/footer.jsp"></jsp:include>
                    </div>
                </div>
                <jsp:include page="/WEB-INF/view/admin/layout/js.jsp"></jsp:include>
            </body>

            </html>