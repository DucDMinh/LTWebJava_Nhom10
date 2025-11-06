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
                    <title>Product</title>
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
                                <div class="container mt-3">
                                    <div class="row">
                                        <div><a href="/admin/product" class="btn btn-success">Back</a></div>
                                        <div class="col-24"
                                            style="display: flex;justify-content:space-evenly; padding-top: 20px;">
                                            <img src="/images/product/${product.image}" alt=""
                                                style="width: 30%; height: 500;">
                                            <div class="card" style="border: none; width: 40%;">
                                                <div></div>
                                                <h1 class="text-center">Product Detail: ${id}</h1>
                                                <div class="card-header" style="text-align: center;">
                                                    Product Information
                                                </div>
                                                <ul class="list-group list-group-flush">
                                                    <li class="list-group-item">ID: ${product.id}</li>
                                                    <li class="list-group-item">Name: ${product.name}</li>
                                                    <li class="list-group-item">Price: ${product.price}</li>
                                                    <li class="list-group-item">Detail Description:
                                                        ${product.detailDesc}
                                                    </li>
                                                    <li class="list-group-item">Short Description: ${product.shortDesc}
                                                    </li>
                                                </ul>
                                            </div>
                                            <br>
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