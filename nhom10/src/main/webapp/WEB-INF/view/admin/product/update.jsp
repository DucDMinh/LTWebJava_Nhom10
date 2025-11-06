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
                                        <div class="col-24 mx-auto">
                                            <a href="/admin/product" class="btn btn-success">Back</a>
                                        </div>
                                        <div class="col-md-5 col-12 mx-auto">
                                            <h1>Update product ${id}</h1>
                                            <form:form method="post" action="/admin/product/update"
                                                modelAttribute="update" enctype="multipart/form-data">
                                                <hr>
                                                <div class="mb-3" style="display: none;">
                                                    <label for="" class="form-label">ID</label>
                                                    <form:input type="text" path="id" class="form-control"
                                                        readonly="true" />
                                                </div>
                                                <div class="row mt-2">
                                                    <div class="col">
                                                        <label class="form-label">Name</label>
                                                        <form:input type="text" path="name" class="form-control" />
                                                    </div>
                                                    <div class="col">
                                                        <c:set var="errorPrice">
                                                            <form:errors path="price" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label">Price</label>
                                                        <form:input type="number" min="0" step="0.01" path="price"
                                                            class="form-control ${not empty errorPrice ? 'is-invalid' : ''}" />
                                                        ${errorPrice}
                                                    </div>
                                                </div>
                                                <div class="row mt-2">
                                                    <c:set var="errorDetailDesc">
                                                        <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                                    </c:set>
                                                    <label class="form-label">Detail Description</label>
                                                    <form:textarea type="text" path="detailDesc"
                                                        class="form-control ${not empty errorDetailDesc ? 'is-invalid' : ''}" />
                                                    ${errorDetailDesc}
                                                </div>
                                                <div class="row mt-2">
                                                    <div class="col">
                                                        <c:set var="errorShortDesc">
                                                            <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label">Short Description</label>
                                                        <form:input type="text" path="shortDesc"
                                                            class="form-control ${not empty errorShortDesc ? 'is-invalid' : ''}" />
                                                        ${errorShortDesc}
                                                    </div>
                                                    <div class="col">
                                                        <c:set var="errorQuantity">
                                                            <form:errors path="quantity" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <label class="form-label">Quantity</label>
                                                        <form:input type="number" min="0" step="1" path="quantity"
                                                            class="form-control ${not empty errorQuantity ? 'is-invalid' : ''}" />
                                                        ${errorQuantity}
                                                    </div>
                                                </div>
                                                <div class="row mt-2">
                                                    <div class="col">
                                                        <label class="form-label">Factory</label>
                                                        <form:select class="form-select" path="factory">
                                                            <form:option value="Apple (Macbook)">Apple (Macbook)
                                                            </form:option>
                                                            <form:option value="Asus">Asus</form:option>
                                                            <form:option value="Lenovo">Lenovo</form:option>
                                                            <form:option value="HP">HP</form:option>
                                                            <form:option value="Alien">Alien</form:option>
                                                            <form:option value="Dell">Dell</form:option>
                                                        </form:select>
                                                    </div>
                                                    <div class="col">
                                                        <label class="form-label">Target</label>
                                                        <form:select class="form-select" path="target">
                                                            <form:option value="Gaming">Gaming</form:option>
                                                            <form:option value="Design">Design</form:option>
                                                            <form:option value="Office">Office</form:option>
                                                            <form:option value="Coding">Coding</form:option>
                                                        </form:select>
                                                    </div>
                                                </div>
                                                <button type=" submit" class="btn btn-primary mt-3">Submit</button>
                                            </form:form>
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