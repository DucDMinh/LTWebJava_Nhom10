<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <title>Admin Dashboard - CellWorld</title>

                <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>

                <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

                <style>
                    .card-dashboard {
                        border: none;
                        border-radius: 12px;
                        box-shadow: 0 0.15rem 1.75rem 0 rgba(58, 59, 69, 0.15);
                        transition: transform 0.2s;
                    }

                    .card-dashboard:hover {
                        transform: translateY(-5px);
                    }

                    .border-left-primary {
                        border-left: 0.25rem solid #4e73df !important;
                    }

                    .border-left-success {
                        border-left: 0.25rem solid #1cc88a !important;
                    }

                    .border-left-info {
                        border-left: 0.25rem solid #36b9cc !important;
                    }

                    .border-left-warning {
                        border-left: 0.25rem solid #f6c23e !important;
                    }

                    .text-gray-300 {
                        color: #dddfeb !important;
                    }

                    .text-gray-800 {
                        color: #5a5c69 !important;
                    }

                    .chart-area {
                        position: relative;
                        height: 400px;
                        /* Bắt buộc phải có chiều cao cố định */
                        width: 100%;
                    }
                </style>
            </head>

            <body class="sb-nav-fixed">
                <jsp:include page="/WEB-INF/view/admin/layout/header.jsp"></jsp:include>

                <div id="layoutSidenav">
                    <jsp:include page="/WEB-INF/view/admin/layout/sibar.jsp"></jsp:include>

                    <div id="layoutSidenav_content">
                        <main>
                            <div class="container-fluid px-4">
                                <div class="d-sm-flex align-items-center justify-content-between mb-4 mt-4">
                                    <h1 class="h3 mb-0 text-gray-800">Tổng Quan</h1>
                                </div>

                                <div class="row">
                                    <div class="col-xl-3 col-md-6 mb-4">
                                        <div class="card border-start border-primary border-4 shadow h-100 py-2">
                                            <div class="card-body">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs fw-bold text-primary text-uppercase mb-1">
                                                            Tổng Doanh Thu</div>
                                                        <div class="h5 mb-0 fw-bold text-dark">
                                                            <c:choose>
                                                                <c:when test="${not empty countRevenue}">
                                                                    <fmt:formatNumber value="${countRevenue}"
                                                                        type="currency" currencySymbol="₫" />
                                                                </c:when>
                                                                <c:otherwise>0 ₫</c:otherwise>
                                                            </c:choose>
                                                        </div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <i class="fas fa-dollar-sign fa-2x text-gray-300"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-3 col-md-6 mb-4">
                                        <div class="card border-start border-success border-4 shadow h-100 py-2">
                                            <div class="card-body">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs fw-bold text-success text-uppercase mb-1">
                                                            Tổng Đơn Hàng</div>
                                                        <div class="h5 mb-0 fw-bold text-dark">
                                                            ${not empty countOrders ? countOrders : 0}
                                                        </div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <i class="fas fa-file-invoice fa-2x text-gray-300"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-3 col-md-6 mb-4">
                                        <div class="card border-start border-info border-4 shadow h-100 py-2">
                                            <div class="card-body">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs fw-bold text-info text-uppercase mb-1">SP Đã
                                                            Bán</div>
                                                        <div class="h5 mb-0 fw-bold text-dark">
                                                            ${not empty countSold ? countSold : 0}
                                                        </div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <i class="fas fa-box fa-2x text-gray-300"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-3 col-md-6 mb-4">
                                        <div class="card border-start border-warning border-4 shadow h-100 py-2">
                                            <div class="card-body">
                                                <div class="row no-gutters align-items-center">
                                                    <div class="col mr-2">
                                                        <div class="text-xs fw-bold text-warning text-uppercase mb-1">
                                                            Khách Hàng</div>
                                                        <div class="h5 mb-0 fw-bold text-dark">
                                                            ${not empty countUser ? countUser : 0}
                                                        </div>
                                                    </div>
                                                    <div class="col-auto">
                                                        <i class="fas fa-users fa-2x text-gray-300"></i>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xl-12 col-lg-12">
                                        <div class="card card-dashboard mb-4">
                                            <div
                                                class="card-header py-3 d-flex flex-row align-items-center justify-content-between bg-white border-bottom-0">
                                                <h6 class="m-0 font-weight-bold text-primary">Biểu Đồ Doanh Thu (Thực
                                                    tế)</h6>
                                            </div>
                                            <div class="card-body">
                                                <div class="chart-area">
                                                    <canvas id="revenueChart"></canvas>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="card card-dashboard mb-4">
                                    <div class="card-header py-3 bg-white border-bottom-0">
                                        <h6 class="m-0 font-weight-bold text-primary"><i class="fas fa-eye me-1"></i>
                                            Top Sản Phẩm Xem Nhiều Nhất</h6>
                                    </div>
                                    <div class="card-body">
                                        <table id="datatablesSimple" class="table table-bordered table-hover">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Tên Sản Phẩm</th>
                                                    <th>Giá</th>
                                                    <th>Đã Bán</th>
                                                    <th>Lượt Xem</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="p" items="${mostViewedProducts}">
                                                    <tr>
                                                        <td>#${p.id}</td>
                                                        <td>
                                                            <div class="d-flex align-items-center">
                                                                <img src="/images/product/${p.image}" alt=""
                                                                    style="width: 40px; height: 40px; object-fit: cover; border-radius: 5px; margin-right: 10px;">
                                                                ${p.name}
                                                            </div>
                                                        </td>
                                                        <td>
                                                            <fmt:formatNumber value="${p.price}" type="currency"
                                                                currencySymbol="₫" />
                                                        </td>
                                                        <td>${p.sold}</td>
                                                        <td><span class="badge bg-primary">${p.view} view</span></td>
                                                    </tr>
                                                </c:forEach>
                                                <c:if test="${empty mostViewedProducts}">
                                                    <tr>
                                                        <td colspan="5" class="text-center">Chưa có dữ liệu thống kê
                                                        </td>
                                                    </tr>
                                                </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </main>

                        <jsp:include page="/WEB-INF/view/admin/layout/footer.jsp"></jsp:include>
                    </div>
                </div>

                <jsp:include page="/WEB-INF/view/admin/layout/js.jsp"></jsp:include>
                <script src="${pageContext.request.contextPath}/admin/js/dashboard.js"></script>
                <script>
                    document.addEventListener("DOMContentLoaded", function () {
                        // Lấy dữ liệu từ biến Model của Spring Boot
                        const labels = JSON.parse('${chartLabelsJson}');
                        const dataRevenue = JSON.parse('${chartDataJson}');

                        // Gọi hàm trong file js bên ngoài
                        initRevenueChart(labels, dataRevenue);
                    });
                </script>
            </body>

            </html>