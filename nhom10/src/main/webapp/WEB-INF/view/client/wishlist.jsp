<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
            <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

                <!DOCTYPE html>
                <html>

                <head>
                    <title>CellWorld - Wishlist</title>
                    <meta charset="utf-8">
                    <meta http-equiv="X-UA-Compatible" content="IE=edge">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
                    <style>
                        .wishlist-container {
                            max-width: 1100px;
                        }

                        .wishlist-table {
                            width: 100%;
                            border: 1px solid #eee;
                            border-radius: 12px;
                            overflow: hidden;
                        }

                        .wishlist-row {
                            display: grid;
                            grid-template-columns: 40% 15% 15% 20% 10%;
                            padding: 20px 15px;
                            align-items: center;
                            border-bottom: 1px solid #f1f1f1;
                        }

                        .wishlist-header {
                            background: #fafafa;
                            font-weight: 600;
                            text-transform: uppercase;
                            font-size: 14px;
                        }

                        .product-img {
                            width: 70px;
                            height: 70px;
                            object-fit: cover;
                            border-radius: 8px;
                        }

                        .product-name {
                            font-size: 16px;
                            font-weight: 600;
                        }

                        .product-id {
                            font-size: 14px;
                            color: gray;
                        }

                        .badge {
                            padding: 8px 14px;
                            font-size: 13px;
                            background-color: #03c42630;
                            color: rgb(28, 28, 28);
                            border-radius: 20px;
                        }

                        .wishlist-col.delete form,
                        .wishlist-col.action form {
                            margin: 0;
                        }
                    </style>
                </head>

                <body data-bs-spy="scroll" data-bs-target="#navbar" data-bs-root-margin="0px 0px -40%"
                    data-bs-smooth-scroll="true" tabindex="0">

                    <jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

                    <!-- Banner -->
                    <section style="background: url(/client/img/banner.jpg) center 15%/cover no-repeat; height: 300px;">
                        <div aria-label="breadcrumb" class="container"></div>
                    </section>

                    <main>
                        <div class="container mt-5">
                            <!-- Breadcrumbs -->
                            <div class="breadcrumb">
                                <nav style="--bs-breadcrumb-divider: '>'" aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="/client/homes">Trang chủ</a></li>
                                        <li class="breadcrumb-item" aria-current="page">Wishlists</li>
                                    </ol>
                                </nav>
                            </div>

                            <div class="container wishlist-container mt-4">
                                <h2 class="fw-bold text-center mb-4">Sản phẩm yêu thích</h2>

                                <div class="wishlist-table">

                                    <div class="wishlist-row wishlist-header">
                                        <div class="wishlist-col product">SẢN PHẨM</div>
                                        <div class="wishlist-col price">GIÁ</div>
                                        <div class="wishlist-col status">TRẠNG THÁI</div>
                                        <div class="wishlist-col action">THÊM VÀO GIỎ</div>
                                        <div class="wishlist-col delete">HỦY</div>
                                    </div>


                                    <c:forEach var="item" items="${wishlistItems}">
                                        <div class="wishlist-row">

                                            <div class="wishlist-col product d-flex align-items-center gap-3">
                                                <img src="/images/product/${item.product.image}" class="product-img"
                                                    alt="${item.product.name}">
                                                <div>
                                                    <p class="product-name mb-1">${item.product.name}</p>

                                                </div>
                                            </div>


                                            <div class="wishlist-col price">${item.product.price} VNĐ</div>


                                            <div class="wishlist-col status">
                                                <button class="btn btn-sm"
                                                    style="background-color: rgba(115, 239, 142, 0.395);">
                                                    còn hàng
                                                </button>
                                            </div>


                                            <div class="wishlist-col action">
                                                <a href="/product/${item.product.id}" class="btn btn-sm"
                                                    style="background-color: rgba(115, 239, 142, 0.395);">
                                                    Đặt hàng
                                                </a>
                                            </div>


                                            <div class="wishlist-col delete">
                                                <form action="/wishlist/remove" method="post">
                                                    <input type="hidden" name="wishId" value="${item.id}">

                                                    <c:if test="${not empty _csrf}">
                                                        <input type="hidden" name="${_csrf.parameterName}"
                                                            value="${_csrf.token}">
                                                    </c:if>

                                                    <button type="submit"
                                                        style="background-color: rgba(247, 11, 11, 0.397); border-radius: 50%;">
                                                        <i class="fa-solid fa-xmark"></i>
                                                    </button>
                                                </form>
                                            </div>
                                        </div>
                                    </c:forEach>


                                    <c:if test="${empty wishlistItems}">
                                        <div class="text-center p-4">Bạn chưa có sản phẩm yêu thích nào.</div>
                                    </c:if>

                                </div>
                            </div>
                        </div>
                    </main>

                    <jsp:include page="/WEB-INF/view/client/layout/insta-shop.jsp"></jsp:include>
                    <jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>
                    <jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
                </body>

                </html>